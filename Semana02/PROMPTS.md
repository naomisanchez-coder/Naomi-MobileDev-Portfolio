# Prompts utilizados — Laboratorio 02

## Herramienta de IA utilizada
Gemini

## Ejercicio 6 — Carrito mejorado

### Prompt (estructura CTRFE):
CONTEXTO: Desarrollo de un laboratorio de lógica de programación en Swift usando Xcode Playground.
TAREA: Mejorar el ejercicio del carrito de compras agregando cálculo de subtotal, aplicación de descuentos por categoría y monto total, e impuestos.
RESTRICCIONES: Utilizar estructuras condicionales (if/else, switch) y comentar absolutamente cada línea de código explicando la lógica.
FORMATO: Código en Swift compatible con Xcode Playground.
EJEMPLO: Simulación de un carrito con items seleccionados, aplicando un 10% de descuento si supera el monto límite.

### ¿Funcionó a la primera?
Sí, el código funcionó correctamente en la primera ejecución generando los cálculos esperados en consola.

### ¿La IA usó algo que no conocías?
Sí, la combinación de múltiples condiciones booleanas dentro de los bloques de descuento y la formateación directa en interpolación de texto `\(...)`.

## Ejercicio 7 — Juego de adivinanza

### Prompt (estructura CTRFE):
CONTEXTO: Desarrollo de un laboratorio en Swift en Xcode Playground sobre estructuras condicionales y bucles.
TAREA: Crear un mini juego de adivinanza de números simulado que cumpla con:
1. Definir un número secreto fijo (ej. 42).
2. Simular 5 intentos con variables independientes (juegoIntento1 = 20, juegoIntento2 = 50, etc.).
3. Utilizar un bucle while para recorrer e inspeccionar los intentos.
4. Mostrar en cada intento si el número es "Muy alto", "Muy bajo" o "¡Correcto!".
5. Contar e imprimir cuántos intentos se necesitaron para adivinar.
6. Si no adivina en 5 intentos, mostrar "Perdiste. El número era: X".
RESTRICCIONES: Comentar CADA línea del código explicando la lógica de comparación.
FORMATO: Bloque de código ejecutable en Xcode Playground.
EJEMPLO: Uso de `while numeroDeIntento <= 5 && !adivinoElNumero` para controlar las iteraciones.

### ¿Funcionó a la primera?
No del todo. Al principio las variables generaban un error de redeclaración (`Invalid redeclaration`) por existir en ejercicios anteriores dentro del mismo Playground. Se corrigió renombrando las variables a `juegoIntento1`, `juegoIntento2`, etc.

### ¿La IA usó algo que no conocías?
Sí, la bandera booleana (`var adivinoElNumero = false`) combinada con el operador `!` dentro de la condición de control del bucle `while` para detener la ejecución inmediatamente al acertar.
