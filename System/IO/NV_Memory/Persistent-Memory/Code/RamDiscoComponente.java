package com.logisim.persistentMemory;

import java.io.IOException;

import com.cburch.logisim.data.BitWidth;
import com.cburch.logisim.data.Value;
import com.cburch.logisim.instance.InstanceData;
import com.cburch.logisim.instance.InstanceState;

/**
 * Lógica de una instancia del componente: estado propio de cada simulación,
 * vínculo con la capa de persistencia y evaluación de lectura/escritura.
 *
 * <p>
 * Comportamiento:
 * <ul>
 * <li><b>Lectura asíncrona:</b> Data Out refleja siempre el contenido de la
 * palabra
 * apuntada por Address. No depende de Clock ni de Write Enable: cambia en
 * cuanto
 * cambia la dirección o el contenido de esa palabra.</li>
 * <li><b>Escritura síncrona:</b> en el flanco de subida de Clock, si WE=1 y el
 * chip está
 * seleccionado, se guarda Data In en la palabra de Address. Como la salida es
 * combinacional, tras la escritura Data Out muestra el nuevo valor.</li>
 * <li><b>Direccionamiento por palabra:</b> cada dirección identifica una
 * palabra de 64 bits;
 * se usan todos los bits de Address.</li>
 * <li><b>Select (CS):</b> activo salvo que valga 0 explícitamente. Con CS=0 no
 * se escribe y
 * la salida pasa a alta impedancia (Z).</li>
 * <li>Address o Data In indefinidos (X/Z): la lectura da salida de error y la
 * escritura
 * se ignora.</li>
 * <li>Cualquier {@link IOException} se captura: la salida pasa a error y el
 * fallo se
 * muestra en el símbolo, pero la simulación continúa.</li>
 * </ul>
 */
final class RamDiscoComponente {

    // Índices de los puertos (deben coincidir con
    // RamDiscoFactory.actualizarPuertos)
    static final int P_DIR = 0;
    static final int P_DIN = 1;
    static final int P_WE = 2;
    static final int P_CS = 3;
    static final int P_CLK = 4;
    static final int P_DOUT = 5;

    /** Ancho fijo del bus de datos. */
    static final BitWidth ANCHO_DATO = BitWidth.create(64);

    /** Retardo de propagación de la salida (en ticks de simulación). */
    private static final int RETARDO = 10;

    private RamDiscoComponente() {
    }

    /** Estado asociado a una instancia dentro de una simulación concreta. */
    static final class DatosRam implements InstanceData, Cloneable {
        Value relojAnterior; // null hasta la primera evaluación
        String rutaAbierta; // ruta con la que se enlazó 'memoria'
        AlmacenamientoDisco memoria; // null si no hay archivo válido
        String error; // mensaje de error propio (ruta inválida, etc.)

        @Override
        public DatosRam clone() {
            try {
                return (DatosRam) super.clone(); // el almacén es compartido: es lo deseado
            } catch (CloneNotSupportedException e) {
                throw new AssertionError(e); // imposible: implementamos Cloneable
            }
        }
    }

    private static DatosRam obtenerDatos(InstanceState state) {
        DatosRam d = (DatosRam) state.getData();
        if (d == null) {
            d = new DatosRam();
            state.setData(d);
        }
        return d;
    }

    /** Punto de entrada llamado desde {@code RamDiscoFactory.propagate}. */
    static void propagate(InstanceState state) {
        DatosRam d = obtenerDatos(state);
        String ruta = state.getAttributeValue(RamDiscoFactory.ATTR_RUTA_ARCHIVO);
        if (ruta == null) {
            ruta = "";
        }

        // Detección de flanco de subida (el primer valor observado nunca cuenta como
        // flanco)
        Value reloj = state.getPortValue(P_CLK);
        boolean flanco = d.relojAnterior != null
                && !Value.TRUE.equals(d.relojAnterior)
                && Value.TRUE.equals(reloj);
        d.relojAnterior = reloj;

        // Enlazar con el archivo si cambió la ruta (o reintentar en cada flanco si
        // falló)
        boolean cambioRuta = !ruta.equals(d.rutaAbierta);
        if (cambioRuta || (flanco && d.memoria == null)) {
            enlazarMemoria(d, ruta);
        }

        boolean seleccionado = !Value.FALSE.equals(state.getPortValue(P_CS));

        // 1) Escritura síncrona: solo en el flanco de subida
        if (flanco && seleccionado && Value.TRUE.equals(state.getPortValue(P_WE))) {
            escribir(state, d);
        }

        // 2) Lectura asíncrona: la salida se recalcula en cada propagación
        state.setPort(P_DOUT, leer(state, d, seleccionado), RETARDO);
    }

    private static void enlazarMemoria(DatosRam d, String ruta) {
        d.rutaAbierta = ruta;
        d.memoria = null;
        d.error = null;
        if (ruta.trim().isEmpty()) {
            d.error = "Sin archivo";
            return;
        }
        try {
            d.memoria = RegistroAlmacenes.obtener(ruta);
        } catch (IOException e) {
            d.error = e.getMessage();
        }
    }

    /**
     * Guarda Data In en la palabra apuntada por Address (si las entradas son
     * válidas).
     */
    private static void escribir(InstanceState state, DatosRam d) {
        if (d.memoria == null) {
            return;
        }
        Value dir = state.getPortValue(P_DIR);
        Value din = state.getPortValue(P_DIN);
        if (!dir.isFullyDefined() || !din.isFullyDefined()) {
            return; // no se escribe con entradas indefinidas
        }
        try {
            d.memoria.escribirPalabra(dir.toLongValue(), din.toLongValue());
        } catch (IOException e) {
            // El fallo queda registrado en el almacén (getUltimoError); no se propaga
        }
    }

    /** Valor combinacional de Data Out para la dirección actual. */
    private static Value leer(InstanceState state, DatosRam d, boolean seleccionado) {
        if (!seleccionado) {
            return Value.createUnknown(ANCHO_DATO); // alta impedancia
        }
        if (d.memoria == null) {
            return Value.createError(ANCHO_DATO);
        }
        Value dir = state.getPortValue(P_DIR);
        if (!dir.isFullyDefined()) {
            return Value.createError(ANCHO_DATO);
        }
        try {
            // La dirección es de palabra: se usan todos sus bits (hasta 37)
            return Value.createKnown(ANCHO_DATO, d.memoria.leerPalabra(dir.toLongValue()));
        } catch (IOException e) {
            return Value.createError(ANCHO_DATO);
        }
    }

    /**
     * Texto de estado para dibujar en el símbolo, o {@code null} si todo va bien.
     */
    static String describirEstado(InstanceData datos, String ruta) {
        if (ruta == null || ruta.trim().isEmpty()) {
            return "Sin archivo";
        }
        if (datos instanceof DatosRam) {
            DatosRam d = (DatosRam) datos;
            if (d.error != null) {
                return d.error;
            }
            if (d.memoria != null && d.memoria.getUltimoError() != null) {
                return "Error de E/S";
            }
        }
        return null;
    }
}
