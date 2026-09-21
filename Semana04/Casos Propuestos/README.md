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


---

## Caso Propuesto 02 — Clientes del banco (Natural / Jurídico)

Conceptos de POO aplicados: **Herencia** y **Polimorfismo**

### Descripción del problema
El banco registra dos tipos de clientes: personas naturales y personas
jurídicas (empresas). Ambos comparten datos comunes de cuenta, pero cada uno
tiene información propia de identificación. El sistema debe poder mostrar los
datos de cualquier cliente, sin importar su tipo, de manera uniforme.

### Requerimientos funcionales

| ID | Requerimiento | Descripción |
|----|---------------|-------------|
| RF-01 | Registrar datos comunes | El sistema almacena código, dirección, fecha de registro, número de cuenta y monto mínimo de apertura para todo cliente. |
| RF-02 | Registrar cliente natural | El sistema permite crear un cliente natural con nombre completo y DNI, además de los datos comunes. |
| RF-03 | Registrar cliente jurídico | El sistema permite crear un cliente jurídico con razón social, RUC y representante legal, además de los datos comunes. |
| RF-04 | Mostrar datos según el tipo | El sistema muestra los datos propios de cada tipo de cliente (natural o jurídico) seguidos de los datos comunes de cuenta. |
| RF-05 | Recorrido uniforme de clientes | El sistema puede recorrer una lista mixta de clientes naturales y jurídicos, mostrando los datos correctos de cada uno sin distinguir el tipo manualmente. |

### Reglas de negocio
- RN-01: Todo cliente, sin importar su tipo, tiene código, dirección, fecha de registro, número de cuenta y monto mínimo de apertura.
- RN-02: Un cliente natural se identifica por DNI; un cliente jurídico se identifica por RUC.
- RN-03: Al mostrar los datos de un cliente, primero se presentan sus datos propios (identificación) y después los datos comunes de cuenta.

### Diseño orientado a objetos

| Elemento | Tipo | Rol |
|----------|------|-----|
| `Cliente` | class (base) | Define los datos comunes de cuenta y el método `mostrarDatos()`. |
| `ClienteNatural` | class (subclase) | Hereda de `Cliente`, agrega `nombreCompleto` y `dni`, sobreescribe `mostrarDatos()`. |
| `ClienteJuridico` | class (subclase) | Hereda de `Cliente`, agrega `razonSocial`, `ruc` y `representanteLegal`, sobreescribe `mostrarDatos()`. |

**Justificación de la herencia:** ambos tipos de cliente comparten los datos
de cuenta (código, dirección, número de cuenta, etc.), así que esa
información y su inicialización se escriben una sola vez en `Cliente`. Cada
subclase solo añade lo que la diferencia.

**Justificación del polimorfismo:** el array de clientes se declara como
`[Cliente]`, el tipo base, aunque contiene instancias de ambas subclases. El
recorrido usa un único `for-in` que llama siempre a `cliente.mostrarDatos()`;
Swift decide en tiempo de ejecución cuál versión del método ejecutar según
el tipo real de cada objeto, sin necesidad de condicionales que pregunten
por el tipo.

### Cómo ejecutar
Abrir `CasoPropuesto02.playground` en Xcode y correrlo (▶). La consola
imprime los datos de un cliente natural y un cliente jurídico, recorridos
desde el mismo array `[Cliente]`, confirmando que cada uno muestra su
información específica antes de los datos comunes de cuenta.
