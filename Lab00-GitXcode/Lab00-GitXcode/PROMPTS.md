# Prompts utilizados – Laboratorio 01

## Herramienta de IA utilizada
Gemini (Google)

## Ejercicio 5 – Problema A: IMC

### Prompt 1:
Actúa como un desarrollador experto en Swift. Genera código en Swift para Xcode Playground que calcule el IMC (Índice de Masa Corporal) de 3 personas (Carlos: 70kg, 1.75m; Ana: 50kg, 1.60m; Luis: 95kg, 1.80m). Clasifica según categorías (Bajo peso < 18.5, Normal < 25, Sobrepeso < 30, Obesidad >= 30) usando operadores ternarios e imprime los resultados en una tabla formateada con tabulaciones (\t). Incluye comentarios explícitos en cada línea.

### Respuesta de la IA:
La IA generó un bloque de código dentro de una estructura `do { ... }` calculando las variables de peso, estatura, la fórmula de IMC y la clasificación mediante operadores ternarios. Finalmente, imprimió los resultados en forma de tabla con `String(format:)` e incluyó comentarios explicativos por cada línea.

### ¿Funcionó a la primera?
Sí, ejecutó correctamente sin errores de compilación.

### ¿Tuviste que corregir algo?
No, el código generó la salida formateada tal cual se especificó.

## Ejercicio 5 – Problema B: Conversor

### Prompt:
Actúa como un desarrollador experto en Swift. Genera código en Swift para Xcode Playground que funcione como un conversor de moneda fija. Define tipos de cambio para USD (3.75), EUR (4.10) y MXN (0.22). Convierte tres montos en soles (S/. 100, S/. 500 y S/. 1000) e imprime una tabla comparativa con formato de 2 decimales y comentarios explicativos línea por línea.

### Respuesta de la IA:
Proporcionó un bloque `do { ... }` declarando los tipos de cambio, convirtiendo los tres valores en soles a las distintas divisas y mostrando la salida organizada en columnas con formato monetario de dos decimales y comentarios.

### ¿Funcionó a la primera?
Sí.

### ¿Tuviste que corregir algo?
No, la estructura y tabulaciones funcionaron a la primera.

## Ejercicio 5 – Problema C: Notas

### Prompt:
Actúa como un desarrollador experto en Swift. Genera código en Swift para Xcode Playground que evalúe las notas de 5 alumnos en un curso. La nota final es 30% Pa y 70% Pb. Si la nota final es mayor o igual a 13.0 el alumno aprueba. Imprime una tabla con las notas y estados de cada alumno, calcula e imprime el promedio general de la clase, e incluye comentarios explicativos en cada línea.

### Respuesta de la IA:
Creó el bloque de código evaluando a los 5 alumnos, calculando sus promedios ponderados, su condición final (Aprobado/Desaprobado), la media de la clase entera y la impresión tabulada con comentarios extensos en cada instrucción.

### ¿Funcionó a la primera?
Sí.

### ¿Tuviste que corregir algo?
No.

## Ejercicio 6 – Conversiones

### Prompt:
Actúa como un desarrollador experto en Swift. Genera código funcional para Xcode Playground que resuelva un conversor de tres categorías:
1. Temperatura: Convierte 3 valores de Celsius a Fahrenheit y Kelvin.
2. Distancia: Convierte 3 valores de Kilómetros a Millas y Metros.
3. Tiempo: Convierte 3 duraciones de Horas a Minutos y Segundos.
Organiza cada bloque en `do { ... }`, imprime en tablas formateadas con tabulaciones y agrega comentarios línea por línea explicando las fórmulas.

### Respuesta de la IA:
Entregó los tres bloques `do` necesarios con las operaciones matemáticas para cada unidad, la salida en consola formateada mediante patrones de impresión y comentarios didácticos en cada variable.

### ¿Funcionó a la primera?
Sí.

### ¿Tuviste que corregir algo?
No, el código fue completamente funcional desde el primer intento.

