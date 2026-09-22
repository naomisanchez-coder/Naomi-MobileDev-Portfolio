# Semana 02 — Simulador de Plan de Pago a Crédito

## Descripción
Programa en Swift (Xcode Playground) que simula el plan de pagos de una compra
financiada a crédito, calculando intereses según el plazo elegido, generando el
cronograma mes a mes, validando los datos ingresados y estimando el ahorro que
genera un pago adelantado sobre el monto financiado.

## ¿Qué hace el código?
- Modela una compra a crédito (producto, precio, cantidad, plan de meses, pago
  adelantado opcional) usando el struct `CompraCredito`.
- Calcula automáticamente la tasa de interés según el plan: 20% (6 meses),
  40% (12 meses), 60% (24 meses).
- Genera el cronograma de cuotas (mes, fecha, monto inicial, pago, resta por pagar),
  avanzando la fecha real mes a mes desde una fecha de inicio.
- Si se indica un mes de pago adelantado, aplica el monto extra en ese mes y
  recalcula automáticamente cuántos meses realmente se pagan.
- Compara el escenario con y sin pago adelantado para mostrar el ahorro en soles
  y en meses de deuda.
- Valida que el plan sea 6, 12 o 24 meses y que el mes de pago adelantado esté
  dentro del rango del plan, mostrando un mensaje de error claro si no lo está.

## Requerimientos funcionales
1. El sistema debe permitir registrar producto, precio unitario, cantidad y plan
   de pago (6, 12 o 24 meses).
2. El sistema debe validar el plan de pago y rechazar valores distintos a 6, 12 o 24.
3. El sistema debe calcular el interés y el monto financiado según el plan elegido.
4. El sistema debe generar el cronograma mensual con fecha, monto inicial, cuota
   pagada y saldo restante.
5. El sistema debe permitir registrar un pago adelantado opcional (mes y monto)
   y validar que el mes esté dentro del rango del plan.
6. El sistema debe mostrar cuántos meses se pagan en total y el ahorro obtenido
   si se realizó un pago adelantado.
7. El sistema debe manejar y mostrar errores de validación sin detener la ejecución
   del resto del programa.

## Estructura del proyecto
- `EjerciciosClase.playground` — código fuente (Contents.swift)
- `README.md` — este archivo
