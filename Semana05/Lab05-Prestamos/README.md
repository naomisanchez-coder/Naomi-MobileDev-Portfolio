# Calculadora de préstamos

Actividad final del Laboratorio 05 de Programación en Móviles Avanzado de Tecsup. Calcula la cuota mensual de un préstamo y el monto total a pagar, incluido el capital y los intereses.

## Proyecto y ejecución

Abre `Prestamos.xcodeproj` en Xcode, selecciona el esquema **Prestamos**, elige un simulador iOS y ejecuta con **⌘R**. El proyecto requiere iOS 17 o posterior y usa Swift, UIKit, Storyboard y Auto Layout, sin dependencias externas.

`Prestamos/Base.lproj/Main.storyboard` contiene el formulario, sus constraints y las conexiones con `ViewController`. El controlador coordina la vista y presenta resultados o alertas. `LoanInput` valida la entrada y `LoanCalculator` calcula las cuotas, ambos independientes de UIKit.

Ingresa el capital en soles, la tasa anual como porcentaje (por ejemplo, `12` para 12 %) y el plazo en años enteros. Toca **Calcular** para ver ambos importes en soles con dos decimales. **Listo** cierra el teclado. El formulario admite desplazamiento y se adapta al teclado y a la rotación.

## Fórmula

La actividad de la página 25 de la guía del laboratorio utiliza amortización con cuotas fijas:

```text
r = (tasa anual en porcentaje / 100) / 12
n = años × 12
M = P × [r × (1 + r)^n] / [(1 + r)^n − 1]
Total = M × n
```

`P` es el capital y `M` es la cuota mensual. El modelo evalúa la expresión equivalente `P × r / [1 − (1 + r)^(-n)]` con `log1p` y `expm1`, que conservan precisión cerca de cero. Para una tasa anual de 0 %, la cuota es `P / n` y el total es `P`. El redondeo se aplica solo al presentar los resultados.

## Validaciones

- Capital mayor que cero, tasa anual no negativa y plazo entero positivo.
- Capital y tasa admiten un punto o una coma como separador decimal, sin separadores de miles. Los espacios al inicio y al final se permiten y una entrada de solo espacios se considera vacía.
- Se rechazan campos vacíos, texto inválido, separadores mezclados o repetidos y entradas o resultados fuera del rango numérico. Las alertas aparecen en español y los resultados se limpian al editar el formulario o al fallar un cálculo.

## Verificación

Compilación de simulador completada con Xcode 26.6 en iPhone 17e con iOS 26.5. Dos pruebas de interfaz con XCUITest, ejecutadas desde una copia temporal del proyecto, verificaron apertura, escritura en los tres campos, uso de **Listo** para cerrar el teclado, acción **Calcular**, presentación de resultados, alerta por capital vacío y limpieza del resultado anterior. La prueba horizontal verificó rotación, desplazamiento y acceso a controles y resultados con el formulario más bajo.

| Capital | Tasa anual | Años | Cuota mensual | Total |
| --- | --- | --- | --- | --- |
| 10000 | 12 % | 1 | S/ 888.49 | S/ 10661.85 |
| 12000 | 0 % | 1 | S/ 1000.00 | S/ 12000.00 |

Las nueve comprobaciones de Swift cubren ambas referencias, tasa muy pequeña, vacíos, texto inválido, decimales con punto y coma, años enteros, signos y extremos numéricos. Desde la carpeta de esta actividad:

```sh
test_dir="$(mktemp -d)"
xcrun swiftc -module-cache-path "$test_dir/cache" Prestamos/LoanCalculator.swift Prestamos/LoanInput.swift Tests/LoanChecks.swift -o "$test_dir/LoanChecks"
"$test_dir/LoanChecks"
```
