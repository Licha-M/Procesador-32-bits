package com.logisim.persistentMemory;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Capa de persistencia de la RAM: expone palabras de 64 bits sobre un archivo
 * en disco sin cargarlo jamás completo en la memoria de la JVM.
 *
 * <p>
 * Diseño:
 * <ul>
 * <li><b>Direccionamiento:</b> por palabra de 64 bits: la dirección 0 es la
 * primera palabra
 * (bytes 0-7 del archivo), la 1 la segunda (bytes 8-15), etc. Se usan todos los
 * bits de
 * la dirección. Orden de bytes dentro de la palabra: big-endian.</li>
 * <li><b>Páginas:</b> el archivo se divide en páginas de {@value #TAM_PAGINA}
 * bytes que se
 * cargan bajo demanda. Las zonas no escritas leen como ceros (archivo
 * "disperso":
 * solo crece cuando se escribe).</li>
 * <li><b>Caché LRU:</b> como máximo {@value #MAX_PAGINAS_CACHE} páginas
 * residentes en RAM.</li>
 * <li><b>Write-back:</b> las escrituras solo modifican la página en caché y la
 * marcan
 * "sucia". Se vuelcan a disco al expulsarla, al superar un umbral de páginas
 * sucias,
 * periódicamente (hilo del {@link RegistroAlmacenes}) o al cerrar la JVM.</li>
 * <li><b>Coherencia:</b> toda lectura pasa por la caché, por lo que siempre ve
 * el último
 * dato escrito aunque aún no esté en disco.</li>
 * <li><b>Concurrencia:</b> un único {@link ReentrantLock} protege todo el
 * estado, ya que
 * acceden el hilo de simulación y el hilo de mantenimiento.</li>
 * </ul>
 */
public final class AlmacenamientoDisco {

    /** Tamaño de página en bytes (512 palabras de 64 bits). */
    public static final int TAM_PAGINA = 4096;
    private static final int BITS_PAGINA = 12; // log2(TAM_PAGINA)

    /** Palabras de 64 bits por página (512) y su logaritmo en base 2. */
    private static final int PALABRAS_POR_PAGINA = TAM_PAGINA / 8;
    private static final int BITS_PALABRAS_PAGINA = 9;

    /** Máximo de páginas en caché (2048 * 4 KiB = 8 MiB). */
    static final int MAX_PAGINAS_CACHE = 2048;

    /** Al alcanzar este número de páginas sucias se vuelcan todas a disco. */
    static final int UMBRAL_PAGINAS_SUCIAS = 128;

    /**
     * Límite duro de páginas en caché cuando el disco está fallando y no se puede
     * expulsar nada: evita crecimiento ilimitado de memoria.
     */
    private static final int MAX_PAGINAS_EN_FALLO = MAX_PAGINAS_CACHE * 2;

    /** Página residente en memoria. */
    private static final class Pagina {
        final byte[] datos = new byte[TAM_PAGINA];
        boolean sucia;
    }

    private final Path ruta;
    private final ReentrantLock cerrojo = new ReentrantLock();

    /**
     * Orden de acceso (true) => política LRU al iterar desde el elemento más
     * antiguo.
     */
    private final LinkedHashMap<Long, Pagina> cache = new LinkedHashMap<>(512, 0.75f, true);

    private FileChannel canal; // se abre de forma perezosa
    private int paginasSucias;
    private long ultimoAccesoNs = System.nanoTime();
    private volatile String ultimoError; // último fallo de E/S (null si el último acceso a disco fue correcto)

    public AlmacenamientoDisco(Path ruta) {
        this.ruta = ruta;
    }

    public Path getRuta() {
        return ruta;
    }

    /** @return descripción del último error de E/S, o {@code null} si no hay. */
    public String getUltimoError() {
        return ultimoError;
    }

    // ---------------------------------------------------------------------
    // API pública de acceso a palabras de 64 bits
    // ---------------------------------------------------------------------

    /**
     * Lee la palabra de 64 bits situada en la dirección de palabra indicada.
     *
     * @throws IOException si hay que leer de disco y falla
     */
    public long leerPalabra(long direccion) throws IOException {
        cerrojo.lock();
        try {
            ultimoAccesoNs = System.nanoTime();
            Pagina p = obtenerPagina(direccion >>> BITS_PALABRAS_PAGINA);
            return leerLong(p.datos, desplazamiento(direccion));
        } catch (IOException e) {
            ultimoError = describir(e);
            throw e;
        } finally {
            cerrojo.unlock();
        }
    }

    /**
     * Escribe una palabra de 64 bits en la dirección de palabra indicada.
     * La escritura queda en la caché (write-back); un fallo al volcar a disco no se
     * propaga, pues el dato ya está a salvo en memoria y se reintentará después.
     *
     * @throws IOException solo si no se pudo ni cargar la página destino
     */
    public void escribirPalabra(long direccion, long valor) throws IOException {
        cerrojo.lock();
        try {
            ultimoAccesoNs = System.nanoTime();
            Pagina p = obtenerPagina(direccion >>> BITS_PALABRAS_PAGINA);
            escribirLong(p.datos, desplazamiento(direccion), valor);
            if (!p.sucia) {
                p.sucia = true;
                paginasSucias++;
            }
            if (paginasSucias >= UMBRAL_PAGINAS_SUCIAS) {
                try {
                    vaciarInterno(false);
                } catch (IOException e) {
                    ultimoError = describir(e); // se reintentará más tarde
                }
            }
        } catch (IOException e) {
            ultimoError = describir(e);
            throw e;
        } finally {
            cerrojo.unlock();
        }
    }

    /**
     * Vuelca a disco todas las páginas sucias (sin forzar sincronización física).
     */
    public void vaciar() throws IOException {
        cerrojo.lock();
        try {
            vaciarInterno(false);
        } catch (IOException e) {
            ultimoError = describir(e);
            throw e;
        } finally {
            cerrojo.unlock();
        }
    }

    /**
     * Vuelca todo, fuerza la escritura física, cierra el canal y libera la caché.
     * Si el volcado falla, la caché se conserva para no perder datos.
     */
    public void cerrar() throws IOException {
        cerrojo.lock();
        try {
            vaciarInterno(true);
            cerrarCanal();
            cache.clear();
            paginasSucias = 0;
        } catch (IOException e) {
            ultimoError = describir(e);
            throw e;
        } finally {
            cerrojo.unlock();
        }
    }

    /**
     * Tarea periódica: vuelca las páginas sucias y, si lleva inactivo más de
     * {@code inactividadNs}, libera el descriptor de archivo y la caché.
     * Nunca lanza excepciones de E/S.
     */
    void mantenimientoPeriodico(long inactividadNs) {
        cerrojo.lock();
        try {
            if (paginasSucias > 0) {
                vaciarInterno(false);
            }
            boolean inactivo = System.nanoTime() - ultimoAccesoNs > inactividadNs;
            if (inactivo && canal != null && paginasSucias == 0) {
                cerrarCanal();
                cache.clear();
            }
        } catch (IOException e) {
            ultimoError = describir(e);
        } finally {
            cerrojo.unlock();
        }
    }

    // ---------------------------------------------------------------------
    // Lógica interna (siempre se invoca con el cerrojo tomado)
    // ---------------------------------------------------------------------

    private Pagina obtenerPagina(long indice) throws IOException {
        Pagina p = cache.get(indice); // get() actualiza el orden LRU
        if (p != null) {
            return p;
        }
        if (cache.size() >= MAX_PAGINAS_EN_FALLO) {
            throw new IOException("Caché saturada: el disco no responde y no se pueden expulsar páginas");
        }
        p = cargarPagina(indice);
        cache.put(indice, p);
        try {
            expulsarExcedente();
        } catch (IOException e) {
            // No se pudo escribir una página sucia: se conserva en caché (no se pierde el
            // dato)
            // y se informa del error, pero la operación en curso puede continuar.
            ultimoError = describir(e);
        }
        return p;
    }

    /** Expulsa las páginas menos recientes hasta respetar el límite de caché. */
    private void expulsarExcedente() throws IOException {
        Iterator<Map.Entry<Long, Pagina>> it = cache.entrySet().iterator();
        while (cache.size() > MAX_PAGINAS_CACHE && it.hasNext()) {
            Map.Entry<Long, Pagina> e = it.next();
            if (e.getValue().sucia) {
                escribirPagina(e.getKey(), e.getValue()); // si falla, no se elimina
            }
            it.remove();
        }
    }

    private Pagina cargarPagina(long indice) throws IOException {
        asegurarCanal();
        Pagina p = new Pagina();
        ByteBuffer bb = ByteBuffer.wrap(p.datos);
        long base = indice << BITS_PAGINA;
        while (bb.hasRemaining()) {
            int n = canal.read(bb, base + bb.position());
            if (n < 0) {
                break; // más allá del fin del archivo: el resto permanece en cero
            }
        }
        ultimoError = null;
        return p;
    }

    private void escribirPagina(long indice, Pagina p) throws IOException {
        asegurarCanal();
        ByteBuffer bb = ByteBuffer.wrap(p.datos);
        long base = indice << BITS_PAGINA;
        while (bb.hasRemaining()) {
            canal.write(bb, base + bb.position());
        }
        if (p.sucia) {
            p.sucia = false;
            paginasSucias--;
        }
        ultimoError = null;
    }

    /**
     * Escribe en disco todas las páginas sucias, en orden ascendente de posición.
     */
    private void vaciarInterno(boolean forzarSincronizacion) throws IOException {
        if (paginasSucias > 0) {
            List<Map.Entry<Long, Pagina>> sucias = new ArrayList<>();
            for (Map.Entry<Long, Pagina> e : cache.entrySet()) {
                if (e.getValue().sucia) {
                    sucias.add(e);
                }
            }
            sucias.sort(Map.Entry.comparingByKey());
            for (Map.Entry<Long, Pagina> e : sucias) {
                escribirPagina(e.getKey(), e.getValue());
            }
        }
        if (forzarSincronizacion && canal != null && canal.isOpen()) {
            canal.force(false);
        }
    }

    private void asegurarCanal() throws IOException {
        if (canal != null && canal.isOpen()) {
            return;
        }
        Path padre = ruta.getParent();
        if (padre != null) {
            Files.createDirectories(padre);
        }
        canal = FileChannel.open(ruta,
                StandardOpenOption.CREATE, StandardOpenOption.READ, StandardOpenOption.WRITE);
    }

    private void cerrarCanal() throws IOException {
        if (canal != null) {
            try {
                canal.close();
            } finally {
                canal = null;
            }
        }
    }

    // ---------------------------------------------------------------------
    // Utilidades
    // ---------------------------------------------------------------------

    /**
     * Desplazamiento en bytes dentro de la página para una dirección de palabra.
     */
    private static int desplazamiento(long direccion) {
        return (int) ((direccion & (PALABRAS_POR_PAGINA - 1)) << 3);
    }

    private static long leerLong(byte[] b, int off) {
        long v = 0;
        for (int i = 0; i < 8; i++) {
            v = (v << 8) | (b[off + i] & 0xFFL);
        }
        return v;
    }

    private static void escribirLong(byte[] b, int off, long v) {
        for (int i = 7; i >= 0; i--) {
            b[off + i] = (byte) v;
            v >>>= 8;
        }
    }

    private static String describir(IOException e) {
        String msg = e.getMessage();
        return e.getClass().getSimpleName() + (msg != null ? ": " + msg : "");
    }
}
