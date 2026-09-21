# Casos Propuestos — Semana 04

Curso: Programación en Móviles Avanzado
Docente: Juan José León Suiyon
Alumna: Naomi Sánchez

---

## Caso Propuesto 01 — Factura de cursos libres Tecsup

Concepto de POO aplicado: **Herencia**

### Descripción del problema
La institución Tecsup dicta cursos libres. Un alumno puede inscribirse a más
de un curso. Si lleva 3 o más cursos, obtiene un descuento del 10% sobre el
total con IGV. Si además es alumno de Tecsup, obtiene un descuento adicional
de S/ 400.00, pero únicamente si también cumple la condición de llevar 3 o
más cursos.

### Requerimientos funcionales

| ID | Requerimiento | Descripción |
|----|---------------|-------------|
| RF-01 | Registrar cursos | El sistema permite agregar cursos a un estudiante, indicando nombre, precio unitario, cantidad y categoría. |
| RF-02 | Calcular importe por curso | El sistema calcula el importe de cada línea multiplicando el precio unitario por la cantidad inscrita. |
| RF-03 | Calcular subtotal | El sistema suma los importes de todos los cursos inscritos. |
| RF-04 | Calcular IGV | El sistema aplica el 18% de IGV sobre el subtotal. |
| RF-05 | Calcular total gravado | El sistema obtiene el total con IGV sumando subtotal + IGV. |
| RF-06 | Descuento por cantidad | Si el estudiante lleva 3 o más cursos, el sistema aplica un 10% de descuento sobre el total con IGV. |
| RF-07 | Descuento especial Tecsup | Si el estudiante es alumno de Tecsup Y lleva 3 o más cursos, el sistema aplica un descuento adicional de S/ 400.00. |
| RF-08 | Calcular total final | El sistema resta ambos descuentos al total con IGV para obtener el monto a pagar. |
| RF-09 | Emitir factura | El sistema imprime los datos del estudiante, el detalle de cursos, subtotal, IGV, total gravado, descuentos aplicados y total final. |
| RF-10 | Mostrar solo descuentos aplicados | Las líneas de descuento se imprimen únicamente cuando su monto es mayor a cero. |

### Reglas de negocio
- RN-01: El IGV es del 18% y se aplica siempre, sin excepción.
- RN-02: El descuento del 10% se calcula sobre el total **con** IGV, no sobre el subtotal.
- RN-03: El descuento de S/ 400 nunca se aplica solo por ser alumno Tecsup: requiere obligatoriamente 3 o más cursos.
- RN-04: La cantidad de cursos se cuenta sumando las cantidades de cada inscripción, no la cantidad de líneas distintas.

### Diseño orientado a objetos

| Elemento | Tipo | Rol |
|----------|------|-----|
| `CategoriaCurso` | enum | Conjunto cerrado de categorías de cursos (programación, IA, diseño). |
| `Curso` | struct | Dato por valor: una línea de la factura (nombre, precio, cantidad, categoría). |
| `Estudiante` | class (base) | Define el flujo completo del cálculo (subtotal, IGV, descuentos, total final) y la impresión de la factura. |
| `EstudianteTecsup` | class (subclase) | Hereda todo el flujo de `Estudiante` y sobreescribe únicamente `descuentoEspecial()` y `etiquetaAlumnoTecsup()`. |

**Justificación de la herencia:** el cálculo de subtotal, IGV, descuento por
cantidad, total final e impresión de la factura es idéntico para cualquier
estudiante. Lo único que cambia según el tipo de alumno es el beneficio
institucional. Por eso la clase base concentra todo el flujo común, y la
subclase redefine solo las dos reglas que le son propias, evitando
duplicar código.

### Cómo ejecutar
Abrir `CasoPropuesto01.playground` en Xcode y correrlo (▶). La consola
imprime dos facturas: una de un alumno Tecsup con 4 inscripciones (activa
ambos descuentos) y otra de un alumno externo con 1 inscripción (sin
descuentos), para verificar que las reglas se activan correctamente.
