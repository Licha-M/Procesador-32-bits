package com.logisim.persistentMemory;

import java.awt.Color;
import java.awt.Graphics;

import com.cburch.logisim.data.Attribute;
import com.cburch.logisim.data.Attributes;
import com.cburch.logisim.data.BitWidth;
import com.cburch.logisim.data.Bounds;
import com.cburch.logisim.data.Direction;
import com.cburch.logisim.instance.Instance;
import com.cburch.logisim.instance.InstanceFactory;
import com.cburch.logisim.instance.InstancePainter;
import com.cburch.logisim.instance.InstanceState;
import com.cburch.logisim.instance.Port;
import com.cburch.logisim.util.GraphicsUtil;
import com.cburch.logisim.util.StringUtil;

/**
 * Factory del componente "RAM persistente en disco".
 *
 * <p>
 * Define la apariencia, las dimensiones, los atributos configurables (ancho de
 * dirección 12..37 bits y ruta del archivo de respaldo) y los puertos, cuyo
 * ancho de
 * dirección se reajusta dinámicamente al cambiar el atributo. La lógica de
 * simulación
 * se delega en {@link RamDiscoComponente}.
 */
public class RamDiscoFactory extends InstanceFactory {

    /** Ancho del bus de dirección, validado por Logisim en el rango [12, 37]. */
    public static final Attribute<Integer> ATTR_ANCHO_DIRECCION = Attributes.forIntegerRange(
            "addrWidth", StringUtil.constantGetter("Ancho de dirección (bits)"), 12, 37);

    /** Ruta del archivo de respaldo (propiedad "file.path"). */
    public static final Attribute<String> ATTR_RUTA_ARCHIVO = Attributes.forString(
            "file.path", StringUtil.constantGetter("Ruta del archivo (file.path)"));

    private static final int ANCHO_SIMBOLO = 140;

    public RamDiscoFactory() {
        super("RamDiscoPersistente", StringUtil.constantGetter("RAM persistente en disco"));
        setAttributes(
                new Attribute<?>[] { ATTR_ANCHO_DIRECCION, ATTR_RUTA_ARCHIVO },
                new Object[] { Integer.valueOf(24), "" });
        // El punto de anclaje (0,0) es el pin de salida, en el borde derecho
        setOffsetBounds(Bounds.create(-ANCHO_SIMBOLO, -40, ANCHO_SIMBOLO, 120));
    }

    // ---------------------------------------------------------------------
    // Puertos
    // ---------------------------------------------------------------------

    @Override
    protected void configureNewInstance(Instance instance) {
        instance.addAttributeListener(); // necesario para recibir instanceAttributeChanged
        actualizarPuertos(instance);
    }

    @Override
    protected void instanceAttributeChanged(Instance instance, Attribute<?> atributo) {
        if (atributo == ATTR_ANCHO_DIRECCION) {
            actualizarPuertos(instance);
            instance.fireInvalidated();
        }
    }

    /**
     * (Re)crea los puertos usando el ancho de dirección configurado actualmente.
     */
    private void actualizarPuertos(Instance instance) {
        int bits = instance.getAttributeValue(ATTR_ANCHO_DIRECCION);
        BitWidth anchoDir = BitWidth.create(bits);
        BitWidth uno = BitWidth.ONE;

        Port[] puertos = new Port[6];
        puertos[RamDiscoComponente.P_DIR] = new Port(-ANCHO_SIMBOLO, -20, Port.INPUT, anchoDir);
        puertos[RamDiscoComponente.P_DIN] = new Port(-ANCHO_SIMBOLO, 0, Port.INPUT, RamDiscoComponente.ANCHO_DATO);
        puertos[RamDiscoComponente.P_WE] = new Port(-ANCHO_SIMBOLO, 20, Port.INPUT, uno);
        puertos[RamDiscoComponente.P_CS] = new Port(-ANCHO_SIMBOLO, 40, Port.INPUT, uno);
        puertos[RamDiscoComponente.P_CLK] = new Port(-ANCHO_SIMBOLO, 60, Port.INPUT, uno);
        puertos[RamDiscoComponente.P_DOUT] = new Port(0, 0, Port.OUTPUT, RamDiscoComponente.ANCHO_DATO);

        puertos[RamDiscoComponente.P_DIR]
                .setToolTip(StringUtil.constantGetter("Dirección de palabra (cada dirección = 64 bits)"));
        puertos[RamDiscoComponente.P_DIN].setToolTip(StringUtil.constantGetter("Datos de entrada (64 bits)"));
        puertos[RamDiscoComponente.P_WE].setToolTip(StringUtil.constantGetter("Write Enable"));
        puertos[RamDiscoComponente.P_CS].setToolTip(StringUtil.constantGetter("Select (activo en alto)"));
        puertos[RamDiscoComponente.P_CLK].setToolTip(StringUtil.constantGetter("Reloj (flanco de subida)"));
        puertos[RamDiscoComponente.P_DOUT]
                .setToolTip(StringUtil.constantGetter("Datos de salida (64 bits, lectura asíncrona)"));

        instance.setPorts(puertos);
    }

    // ---------------------------------------------------------------------
    // Simulación y dibujo
    // ---------------------------------------------------------------------

    @Override
    public void propagate(InstanceState state) {
        RamDiscoComponente.propagate(state);
    }

    @Override
    public void paintInstance(InstancePainter painter) {
        Graphics g = painter.getGraphics();
        Bounds b = painter.getBounds();
        painter.drawBounds();

        painter.drawPort(RamDiscoComponente.P_DIR, "A", Direction.EAST);
        painter.drawPort(RamDiscoComponente.P_DIN, "D in", Direction.EAST);
        painter.drawPort(RamDiscoComponente.P_WE, "WE", Direction.EAST);
        painter.drawPort(RamDiscoComponente.P_CS, "CS", Direction.EAST);
        painter.drawClock(RamDiscoComponente.P_CLK, Direction.EAST);
        painter.drawPort(RamDiscoComponente.P_DOUT, "D out", Direction.WEST);

        int bits = painter.getAttributeValue(ATTR_ANCHO_DIRECCION);
        int cx = b.getX() + b.getWidth() / 2;
        int cy = b.getY() + b.getHeight() / 2;

        g.setColor(Color.BLACK);
        GraphicsUtil.drawCenteredText(g, "RAM en disco", cx, cy - 20);
        GraphicsUtil.drawCenteredText(g, "2^" + bits + " x 64 bits", cx, cy - 5);
        // Capacidad en bytes: 2^bits palabras * 8 bytes = 2^(bits+3) bytes
        GraphicsUtil.drawCenteredText(g, formatearCapacidad(bits + 3), cx, cy + 10);

        String estado = RamDiscoComponente.describirEstado(
                painter.getData(), painter.getAttributeValue(ATTR_RUTA_ARCHIVO));
        if (estado != null) {
            g.setColor(Color.RED);
            GraphicsUtil.drawCenteredText(g, recortar(estado, 22), cx, cy + 30);
            g.setColor(Color.BLACK);
        }
    }

    /** Capacidad lógica (2^exponente bytes) en unidades legibles. */
    private static String formatearCapacidad(int exponente) {
        String[] unidades = { "B", "KB", "MB", "GB", "TB" };
        int u = exponente / 10;
        return (1L << (exponente % 10)) + " " + unidades[Math.min(u, unidades.length - 1)];
    }

    private static String recortar(String texto, int max) {
        return texto.length() <= max ? texto : texto.substring(0, max - 1) + "…";
    }
}
