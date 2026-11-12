package com.logisim.persistentMemory;

import java.io.IOException;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;

/**
 * Registro global de {@link AlmacenamientoDisco}, uno por archivo.
 *
 * <ul>
 * <li>Varias instancias del componente que apunten al mismo archivo comparten
 * el mismo
 * almacén, lo que garantiza coherencia entre ellas.</li>
 * <li>Un hilo demonio vuelca periódicamente las páginas sucias y libera
 * descriptores
 * de archivos inactivos.</li>
 * <li>Un hook de cierre de la JVM vuelca y cierra todo al salir de
 * Logisim.</li>
 * </ul>
 */
public final class RegistroAlmacenes {

    private static final long PERIODO_MANTENIMIENTO_S = 2;
    private static final long INACTIVIDAD_NS = TimeUnit.SECONDS.toNanos(30);

    private static final Object CERROJO = new Object();
    private static final Map<Path, AlmacenamientoDisco> ALMACENES = new HashMap<>();

    static {
        ThreadFactory fabrica = r -> {
            Thread t = new Thread(r, "RamDisco-Mantenimiento");
            t.setDaemon(true); // no debe impedir que la JVM termine
            return t;
        };
        ScheduledExecutorService planificador = Executors.newSingleThreadScheduledExecutor(fabrica);
        planificador.scheduleWithFixedDelay(RegistroAlmacenes::mantenimiento,
                PERIODO_MANTENIMIENTO_S, PERIODO_MANTENIMIENTO_S, TimeUnit.SECONDS);

        Runtime.getRuntime().addShutdownHook(new Thread(RegistroAlmacenes::cerrarTodos, "RamDisco-Cierre"));
    }

    private RegistroAlmacenes() {
    }

    /**
     * Devuelve el almacén asociado a la ruta (lo crea si no existe). No abre el
     * archivo:
     * eso ocurre de forma perezosa en el primer acceso.
     *
     * @throws IOException si el texto no es una ruta válida
     */
    public static AlmacenamientoDisco obtener(String rutaTexto) throws IOException {
        Path ruta;
        try {
            ruta = Paths.get(rutaTexto.trim()).toAbsolutePath().normalize();
        } catch (InvalidPathException e) {
            throw new IOException("Ruta de archivo inválida: " + rutaTexto, e);
        }
        synchronized (CERROJO) {
            return ALMACENES.computeIfAbsent(ruta, AlmacenamientoDisco::new);
        }
    }

    private static List<AlmacenamientoDisco> instantanea() {
        synchronized (CERROJO) {
            return new ArrayList<>(ALMACENES.values());
        }
    }

    /**
     * Tarea periódica; captura todo para que el planificador no se detenga nunca.
     */
    private static void mantenimiento() {
        try {
            for (AlmacenamientoDisco a : instantanea()) {
                a.mantenimientoPeriodico(INACTIVIDAD_NS);
            }
        } catch (RuntimeException e) {
            System.err.println("[RamDisco] Error en el mantenimiento periódico: " + e);
        }
    }

    /** Se ejecuta al cerrar la JVM: vuelca y cierra cada almacén. */
    private static void cerrarTodos() {
        for (AlmacenamientoDisco a : instantanea()) {
            try {
                a.cerrar();
            } catch (IOException | RuntimeException e) {
                System.err.println("[RamDisco] No se pudo cerrar " + a.getRuta() + ": " + e);
            }
        }
    }
}
