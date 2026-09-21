# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada [Gemini]

## Caso 2B — Biblioteca

### Prompt 1:
1. CONTEXTO: Soy estudiante de Swift, cuarta semana, trabajo en un Playground de Xcode.
2. TAREA: Necesito una biblioteca con enum EstadoLibro, struct Libro y class Biblioteca con prestar, devolver e inventario.
3. RESTRICCIONES: Solo struct, class, herencia, protocolos, enums, arrays, bucles y funciones. Sin optionals ni guard let, sin firstIndex(where:), sin didSet, sin propiedades calculadas, sin genéricos.
4. FORMATO: Solo el código Swift, con las firmas exactas que te indico.
5. EJEMPLO:
Préstamo aprobado: La ciudad y los perros
Error: La ciudad y los perros ya está prestado
Devolución registrada: La ciudad y los perros
Préstamo aprobado: El Quijote
Error: no existe El Principito
===== INVENTARIO =====
Cien años de soledad (Gabriel García Márquez) - disponible
La ciudad y los perros (Mario Vargas Llosa) - disponible
El Quijote (Miguel de Cervantes) - prestado

### Respuesta de la IA:
La IA generó la estructura requerida con el enum EstadoLibro, el struct Libro y la clase Biblioteca implementando la iteración numérica sobre el arreglo mediante rangos 0..<libros.count y la evaluación de estados con switch.

### ¿Funcionó a la primera?
Sí, funcionó a la primera al incluir las restricciones específicas dentro del prompt.

### ¿Usó algo que no hemos visto en clase?
No, gracias a la restricción explícita de evitar firstIndex(where:) y guard let, la IA se limitó al uso de bucles tradicionales por índice.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?
Ambas soluciones fueron prácticamente idénticas debido a la precisión del prompt y las reglas estrictas impuestas.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?
No, todas las líneas corresponden a los temas de programación orientada a objetos trabajados en la Semana 04.

### ¿Qué me pareció mejor de MI versión?
El control paso a paso durante el desarrollo manual y la comprensión directa de cómo se modifican los structs dentro de un arreglo.

### ¿Qué me pareció mejor de la versión de la IA?
La velocidad para escribir las estructuras sintácticas sin errores de tipeo.
