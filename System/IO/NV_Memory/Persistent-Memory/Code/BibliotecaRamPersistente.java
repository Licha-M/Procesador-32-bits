package com.logisim.persistentMemory;

import java.util.Collections;
import java.util.List;

import com.cburch.logisim.tools.AddTool;
import com.cburch.logisim.tools.Library;
import com.cburch.logisim.tools.Tool;

/**
 * Clase principal de la librería: registra en Logisim Evolution el componente
 * "RAM persistente en disco". Es la clase que Logisim instancia al cargar el
 * JAR.
 */
public class BibliotecaRamPersistente extends Library {

    private final List<Tool> herramientas;

    public BibliotecaRamPersistente() {
        herramientas = Collections.singletonList(new AddTool(new RamDiscoFactory()));
    }

    @Override
    public String getName() {
        return "Persistent Memory";
    }

    @Override
    public String getDisplayName() {
        return "Persistent Memory";
    }

    @Override
    public List<? extends Tool> getTools() {
        return herramientas;
    }
}
