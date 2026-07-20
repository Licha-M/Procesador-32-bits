# Listado Simplificado de Pruebas - CPU RISC 32-bit

*   **Prueba 1: Lógica y Desplazamiento**
    *   **Estado:** [ Finalizada ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Verifica el correcto funcionamiento de las compuertas de la ALU con valores conocidos antes de introducir saltos complejos.

*   **Prueba 2: Banderas y Saltos Complejos (Eflags)**
    *   **Estado:** [ Finalizada ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Comprueba que la ALU actualiza el registro de estado tras operaciones aritméticas y que el control de flujo responda adecuadamente a dichos cambios (como desbordes o resultados negativos).

*   **Prueba 3: Captura de Acarreo y Ejecución Silenciosa**
    *   **Estado:** [ Finalizada ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Asegura que el prefijo de ejecución silenciosa evita la modificación de las banderas, y que el procesador puede recuperar correctamente un acarreo de una operación previa.

*   **Prueba 4: Acceso a Memoria Natural**
    *   **Estado:** [ Finalizada ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Valida los multiplexores de tamaño de memoria para asegurar que se lee y escribe la fracción correcta de la palabra en RAM en direcciones alineadas.

*   **Prueba 5: Lectura/Escritura del Banco Especial**
    *   **Estado:** [ Finalizada ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Valida las rutas de datos y la correcta transferencia de información entre el banco de registros normales y el banco de registros especiales.

*   **Prueba 6: Excepciones Básicas y Causa**
    *   **Estado:** [ Finalizada ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Asegura que el hardware detecte instrucciones ilegales o fallos lógicos, salte al vector correcto de interrupción y registre el motivo del fallo.

*   **Prueba 7: Cambio de Contexto y Syscalls**
    *   **Estado:** [ En proceso ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Comprueba el flujo completo de petición de servicios al sistema operativo, desde la llamada inicial hasta el retorno seguro.

*   **Prueba 8: Protección General y MMU**
    *   **Estado:** [ Sin Empezar ] (Sin empezar / En proceso / Finalizada)
    *   **Qué prueba y por qué:** Valida los sistemas de seguridad del procesador y el mapeo de memoria virtual, forzando excepciones como fallos de página o de protección general.
