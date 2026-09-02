import UIKit

// Docente: Juan León S.
// ===== EJERCICIO 1: CONDICIONALES =====

// --- Ejemplo (ya resuelto): ---
let nota = 15.0
if nota >= 13.0 {
    print("Aprobado con \(nota)")
} else {
    print("Desaprobado con \(nota)")
}

// TODO 1: Validar si una persona es mayor de edad
let edad = 17
if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}

// TODO 2: Clasificar una nota con else if
let miNota = 16.0
// Categorías: Excelente (18-20), Bueno (15-17), Aprobado (13-14), Desaprobado (0-12)
if miNota >= 18.0 {
    print("Excelente")
} else if miNota >= 15.0 {
    print("Bueno")
} else if miNota >= 13.0 {
    print("Aprobado")
} else {
    print("Desaprobado")
}

// TODO 3: Verificar si un número es positivo, negativo o cero
let numero = -5
if numero > 0 {
    print("El número es positivo")
} else if numero < 0 {
    print("El número es negativo")
} else {
    print("El número es cero")
}

// ===== FIX: Encuentra y corrige los 3 errores =====

// FIX 1: Corrección de llaves de apertura/cierre en la estructura if/else if
let temperatura = 35
if temperatura >= 30 {
    print("Hace calor")
} else if temperatura > 20 {
    print("Clima agradable")
} else {
    print("Hace frio")
}

// FIX 2: Corrección de la interpolación \(compra - saldo) y cierre de llaves
let saldo = 100.0
let compra = 150.0
if saldo > compra {
    print("Compra realizada")
} else {
    print("Saldo insuficiente: te faltan S/.\(compra - saldo)")
}

// FIX 3: Corrección de operadores lógicos (&&), sintaxis de llaves y rangos de hora
let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos dias")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora <= 23 {
    print("Buenas noches")
} else {
    print("Hora inválida")
}

// ===== PREDICT: Respuestas a las predicciones =====

// PREDICT 1 y 2:
// Imprime "Mayor que 10".
// ¿Por qué no imprime "Mayor que 5" también?
// Respuesta: Porque en una cadena 'if / else if', en cuanto se cumple la primera condición verdadera (15 > 10), Swift ejecuta ese bloque y salta el resto sin evaluar los demás 'else if'.

// PREDICT 3:
// Imprime "Es lunes O llueve".
// Respuesta: La primera condición (esLunes && llueve) falla porque llueve es 'false'. La segunda condición (esLunes || llueve) es 'true' porque el operador '||' (Ó) solo requiere que una de las dos variables sea verdadera.

// ===== EJERCICIO 2: SWITCH =====

// --- Ejemplo (ya resuelto): ---
let diaSemana = 3
switch diaSemana {
case 1: print("Lunes")
case 2: print("Martes")
case 3: print("Miércoles")
case 4: print("Jueves")
case 5: print("Viernes")
case 6: print("Sábado")
case 7: print("Domingo")
default: print("Día inválido")
}

// --- TODO 4: Clasificar nota numérica a letra ---
let notaSwitch = 16
switch nota {
case 18...20:
    print("A")
case 15...17:
    print("B")
case 13...14:
    print("C")
case 11...12:
    print("D")
case 0...10:
    print("F")
default:
    print("Nota inválida")
}

// --- TODO 5: Calculadora simple con switch ---
let num1 = 20.0
let num2 = 5.0
let operacion = "+"
switch operacion {
case "+":
    print("Resultado: \(num1 + num2)")
case "-":
    print("Resultado: \(num1 - num2)")
case "*":
    print("Resultado: \(num1 * num2)")
case "/":
    if num2 != 0 {
        print("Resultado: \(num1 / num2)")
    } else {
        print("Error: No se puede dividir entre 0")
    }
default:
    print("Operación no válida")
}

// --- TODO 6: Categoría de producto por precio ---
let precio = 350.0
// Categorías: Económico (0-99), Medio (100-499), Premium (500-999), Lujo (1000+)
switch precio {
case 0..<100:
    print("Económico")
case 100..<500:
    print("Medio")
case 500..<1000:
    print("Premium")
case 1000...:
    print("Lujo")
default:
    print("Precio inválido")
}

// ===== 2.2 PREDICCIONES =====

// PREDICT 4:
// ¿Qué imprime?: Imprime "28 o 29 días".
// Explicación: La variable 'mes' vale 2, lo que coincide directamente con la evaluación del 'case 2:'.

// PREDICT 5:
// ¿Qué imprime?: Imprime "Vocal".
// Explicación: La variable 'letra' es de tipo Character con valor "a", haciendo match directo con el primer grupo de caracteres ('case "a", "e", "i", "o", "u":').

// ===== EJERCICIO 3: BUCLES FOR-IN =====

// --- Ejemplo (ya resuelto): ---
// Imprime los números del 1 al 5:
for i in 1...5 {
    print("Número: \(i)")
}

// --- TODO 7: Tabla de multiplicar del 7 ---
// Imprime: 7 x 1 = 7, 7 x 2 = 14, ... 7 x 12 = 84
for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
var suma = 0
for i in 1...100 {
    suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)") // Debe dar 5050

// --- TODO 9: Calcular el factorial de 8 ---
var factorial = 1
for i in 1...8 {
    factorial = factorial * i
}
print("8! = \(factorial)")

// --- TODO 10: Patrón de asteriscos ---
for i in 1...5 {
    print(String(repeating: "*", count: i))
}

// ===== 3.2 CORREGIR BUCLES =====

// FIX 4: Se quiere imprimir los números pares del 2 al 20
for i in 1...20 {
    if i % 2 == 0 { // Se cambió % 2 == 1 por % 2 == 0 para filtrar pares
        print(i)
    }
}

// FIX 5: Se quiere contar del 10 al 1 (cuenta regresiva)
for i in stride(from: 10, through: 1, by: -1) { // Se usó stride para restar de 1 en 1
    print(i)
}

// ===== 3.3 PREDICCIONES =====

// PREDICT 6:
// ¿Valor final de total?: 15
// ¿Cuántas iteraciones?: 5 iteraciones (i toma los valores 1, 2, 3, 4 y 5).

// PREDICT 7:
// ¿Para qué sirve '_' en vez de 'i'?:
// Respuesta: Se utiliza el comodín '_' cuando no se requiere usar el valor del contador dentro del bloque, indicándole a Swift que únicamente debe repetir la acción esa cantidad de veces.

// ===== EJERCICIO 4: WHILE Y REPEAT-WHILE =====

// --- 4.1 Ejemplo (ya resuelto): ---
var contador = 5
while contador > 0 {
    print("Cuenta regresiva: \(contador)")
    contador -= 1 // Resta 1 en cada vuelta
}
print("¡Despegue!")

// --- TODO 11: Ahorro mensual ---
// Un alumno ahorra S/. 150 cada mes.
// ¿Cuántos meses necesita para juntar S/. 2000?
var ahorro = 0.0
var meses = 0
let meta = 2000.0
let ahorroMensual = 150.0

while ahorro < meta {
    ahorro += ahorroMensual
    meses += 1
}
print("Necesita \(meses) meses para juntar S/. \(meta)")

// --- TODO 12: División sucesiva ---
// Divide un número entre 2 repetidamente hasta que sea menor a 1
var numeroWhile = 1000.0
var divisiones = 0

while numeroWhile >= 1.0 {
    numeroWhile = numeroWhile / 2
    divisiones += 1
    print("División \(divisiones): \(numeroWhile)")
}
print("Se dividió \(divisiones) veces")

// --- 4.2 TODO 13: Validar datos con repeat-while ---
// Simula pedir una nota hasta que sea válida (entre 0 y 20)
let intento1 = 25 // Inválido: > 20
let intento2 = -3 // Inválido: < 0
let intento3 = 15 // Válido

var intentoActual = intento1
var esValido = false
var numIntento = 1

repeat {
    // Verifica si intentoActual está entre 0 y 20
    if intentoActual >= 0 && intentoActual <= 20 {
        esValido = true
        print("Nota \(intentoActual) válida en intento \(numIntento)")
    } else {
        print("Nota \(intentoActual) inválida, intento \(numIntento)")
        // Simula el siguiente intento:
        if numIntento == 1 { intentoActual = intento2 }
        if numIntento == 2 { intentoActual = intento3 }
        numIntento += 1
    }
} while !esValido

// ===== 4.3 PREDICCIONES =====

// PREDICT 8:
// ¿Valor final de a?: 1
// ¿Cuántas vueltas?: 4 vueltas (100 -> 33 -> 11 -> 3 -> 1)

// PREDICT 9:
// ¿Valor final de b?: 1
// ¿Por qué repeat-while ejecuta al menos una vez?:
// Respuesta: Porque la condición 'while' se evalúa al FINAL del bloque, garantizando que el código dentro de 'repeat' se ejecute por lo menos una primera vez antes de comprobar si la condición es verdadera o falsa.

// ===== EJERCICIO 5: CARRITO DE COMPRAS =====

// --- 5.1 Datos de productos (ya definidos): ---
let prod1 = "Laptop"
let precio1 = 3500.0
let cant1 = 1

let prod2 = "Mouse"
let precio2 = 45.50
let cant2 = 2

let prod3 = "Teclado"
let precio3 = 120.00
let cant3 = 1

let prod4 = "Monitor"
let precio4 = 890.00
let cant4 = 1

let prod5 = "USB Cable"
let precio5 = 15.00
let cant5 = 3

// --- 5.2 TODO 14: Calcula el subtotal de cada producto ---
let sub1 = precio1 * Double(cant1)
let sub2 = precio2 * Double(cant2)
let sub3 = precio3 * Double(cant3)
let sub4 = precio4 * Double(cant4)
let sub5 = precio5 * Double(cant5)

// --- TODO 15: Calcula el subtotal general ---
let subtotalGeneral = sub1 + sub2 + sub3 + sub4 + sub5

// --- 5.3 TODO 16: Aplica descuento según monto de compra ---
var porcentajeDescuento = 0.0
if subtotalGeneral >= 5000 {
    porcentajeDescuento = 0.15
} else if subtotalGeneral >= 2000 {
    porcentajeDescuento = 0.10
} else if subtotalGeneral >= 500 {
    porcentajeDescuento = 0.05
} else {
    porcentajeDescuento = 0.0
}

let descuento = subtotalGeneral * porcentajeDescuento
let subtotalConDescuento = subtotalGeneral - descuento

// --- 5.4 TODO 17: Categoría de cliente según monto ---
let montoParaCategoria = Int(subtotalGeneral)
var categoriaCliente = ""

switch montoParaCategoria {
case 0..<500:
    categoriaCliente = "Regular"
case 500..<2000:
    categoriaCliente = "Frecuente"
case 2000..<5000:
    categoriaCliente = "Premium"
default:
    categoriaCliente = "VIP"
}

// --- 5.5 TODO 18: Calcula IGV y total ---
let igv = subtotalConDescuento * 0.18
let totalFinal = subtotalConDescuento + igv

// --- 5.6 TODO 19: Imprime el ticket de compra ---
var separador = ""
for _ in 1...40 {
    separador += "="
}

print(separador)
print("   TICKET DE COMPRA")
print("   Cliente: \(categoriaCliente)")
print(separador)
print("\(prod1) x\(cant1)       S/. \(sub1)")
print("\(prod2) x\(cant2)        S/. \(sub2)")
print("\(prod3) x\(cant3)      S/. \(sub3)")
print("\(prod4) x\(cant4)      S/. \(sub4)")
print("\(prod5) x\(cant5)    S/. \(sub5)")
print(separador)
print("Subtotal:            S/. \(subtotalGeneral)")
print("Descuento (\(porcentajeDescuento * 100)%): -S/. \(descuento)")
print("Subtotal c/desc:     S/. \(subtotalConDescuento)")
print("IGV (18%):           S/. \(igv)")
print(separador)
print("TOTAL:               S/. \(totalFinal)")
print(separador)
print("¡Gracias por su compra!")

// ===== EJERCICIO 6: CARRITO MEJORADO CON IA =====

// Se define el precio unitario del producto 1 (Laptop)
let precioProd1 = 3500.0 // Asigna el valor flotante 3500.0 a la constante de precio
// Se define la cantidad a comprar del producto 1
let cantidadProd1 = 1 // Asigna el número entero 1 a la cantidad de laptops

// Se define el precio unitario del producto 2 (Mouse)
let precioProd2 = 45.50 // Asigna el valor flotante 45.50 a la constante de precio
// Se define la cantidad a comprar del producto 2
let cantidadProd2 = 2 // Asigna el número entero 2 a la cantidad de mouses

// Se define el precio unitario del producto 3 (Teclado)
let precioProd3 = 120.00 // Asigna el valor flotante 120.0 a la constante de precio
// Se define la cantidad a comprar del producto 3
let cantidadProd3 = 1 // Asigna el número entero 1 a la cantidad de teclados

// Se define el precio unitario del producto 4 (Monitor)
let precioProd4 = 890.00 // Asigna el valor flotante 890.0 a la constante de precio
// Se define la cantidad a comprar del producto 4
let cantidadProd4 = 1 // Asigna el número entero 1 a la cantidad de monitores

// Se define el precio unitario del producto 5 (Cable USB)
let precioProd5 = 15.00 // Asigna el valor flotante 15.0 a la constante de precio
// Se define la cantidad a comprar del producto 5
let cantidadProd5 = 3 // Asigna el número entero 3 a la cantidad de cables USB

// Variable que almacena el código del cupón promocional a validar
let cuponIngresado = "DESCUENTO20" // Asigna la cadena de texto con el código del cupón

// Requisito 16: Evalúa si los precios son no negativos y las cantidades mayores a cero
let esValido1 = precioProd1 >= 0 && cantidadProd1 > 0 // Retorna verdadero si el precio 1 es >= 0 y cantidad 1 es > 0
let esValido2 = precioProd2 >= 0 && cantidadProd2 > 0 // Retorna verdadero si el precio 2 es >= 0 y cantidad 2 es > 0
let esValido3 = precioProd3 >= 0 && cantidadProd3 > 0 // Retorna verdadero si el precio 3 es >= 0 y cantidad 3 es > 0
let esValido4 = precioProd4 >= 0 && cantidadProd4 > 0 // Retorna verdadero si el precio 4 es >= 0 y cantidad 4 es > 0
let esValido5 = precioProd5 >= 0 && cantidadProd5 > 0 // Retorna verdadero si el precio 5 es >= 0 y cantidad 5 es > 0

// Valida mediante un operador lógico AND que todas las condiciones sean verdaderas
let datosValidos = esValido1 && esValido2 && esValido3 && esValido4 && esValido5 // Junta las 5 validaciones en una sola bandera

// Estructura condicional para detener el flujo si se encuentran datos corruptos
if !datosValidos { // Evalúa si la bandera de datos válidos es falsa
    print("Error: Se encontraron precios negativos o cantidades iguales o menores a 0.") // Imprime mensaje de error en consola
} else { // Ejecuta el cálculo comercial solo si todos los datos ingresados son válidos

    // Requisito 12: Descuento individual por cantidad (5% extra si la cantidad es >= 3)
    let descProd1 = cantidadProd1 >= 3 ? 0.05 : 0.0 // Asigna 0.05 si se compraron 3 o más unidades de producto 1, si no 0.0
    let subtotalProd1 = precioProd1 * Double(cantidadProd1) * (1.0 - descProd1) // Multiplica precio por cantidad reduciendo el porcentaje de descuento

    let descProd2 = cantidadProd2 >= 3 ? 0.05 : 0.0 // Asigna 0.05 si se compraron 3 o más unidades de producto 2, si no 0.0
    let subtotalProd2 = precioProd2 * Double(cantidadProd2) * (1.0 - descProd2) // Multiplica precio por cantidad reduciendo el porcentaje de descuento

    let descProd3 = cantidadProd3 >= 3 ? 0.05 : 0.0 // Asigna 0.05 si se compraron 3 o más unidades de producto 3, si no 0.0
    let subtotalProd3 = precioProd3 * Double(cantidadProd3) * (1.0 - descProd3) // Multiplica precio por cantidad reduciendo el porcentaje de descuento

    let descProd4 = cantidadProd4 >= 3 ? 0.05 : 0.0 // Asigna 0.05 si se compraron 3 o más unidades de producto 4, si no 0.0
    let subtotalProd4 = precioProd4 * Double(cantidadProd4) * (1.0 - descProd4) // Multiplica precio por cantidad reduciendo el porcentaje de descuento

    let descProd5 = cantidadProd5 >= 3 ? 0.05 : 0.0 // Como cantidadProd5 es 3, asigna 0.05 de descuento al producto 5
    let subtotalProd5 = precioProd5 * Double(cantidadProd5) * (1.0 - descProd5) // Multiplica precio por cantidad aplicando el 5% de descuento

    // Suma el subtotal acumulado de los 5 productos para obtener el subtotal inicial
    let subtotalBruto = subtotalProd1 + subtotalProd2 + subtotalProd3 + subtotalProd4 + subtotalProd5 // Acumula los 5 subtotales individuales

    // Requisito 13: Aplicación de cupón de descuento promocional "DESCUENTO20"
    let porcentajeCupon = (cuponIngresado == "DESCUENTO20") ? 0.20 : 0.0 // Si el cupón coincide exactamente con "DESCUENTO20" aplica 0.20 (20%)
    let montoMontoCupon = subtotalBruto * porcentajeCupon // Obtiene el valor en soles a descontar por concepto del cupón
    let subtotalConCupon = subtotalBruto - montoMontoCupon // Resta el monto del cupón al subtotal bruto acumulado

    // Requisito 14: Determinación del costo de envío (gratis si supera S/. 3000, si no S/. 25.00)
    let costoEnvio = subtotalConCupon > 3000.0 ? 0.0 : 25.00 // Evalúa si el monto supera 3000.0 para fijar costo en 0.0 o en 25.0

    // Calcula el total final sumando el costo de envío correspondiente
    let totalPagar = subtotalConCupon + costoEnvio // Suma el costo del envío al subtotal con cupón

    // Requisito 15: Puntos de fidelidad (1 punto por cada S/. 100 de compra)
    let puntosObtenidos = Int(totalPagar / 100.0) // Divide el total entre 100 y castea a entero descartando decimales

    // Muestra en consola la cabecera del reporte final
    print("===== TICKET DE COMPRA MEJORADO (CON IA) =====") // Imprime la línea de título
    // Muestra el subtotal bruto calculado
    print("Subtotal productos: S/. \(subtotalBruto)") // Muestra la sumatoria de productos con interpolación
    // Muestra el monto descontado por la validación del cupón
    print("Descuento cupón (\(porcentajeCupon * 100)%): -S/. \(montoMontoCupon)") // Muestra el porcentaje y valor descontado
    // Muestra el cobro del costo de envío calculado
    print("Costo de envío: S/. \(costoEnvio)") // Imprime si el envío es 0.0 o 25.0
    // Muestra el importe total a pagar en soles
    print("TOTAL A PAGAR: S/. \(totalPagar)") // Imprime el total definitivo de la transacción
    // Muestra la cantidad entera de puntos acumulados en la compra
    print("Puntos de fidelidad ganados: \(puntosObtenidos) pts") // Imprime los puntos calculados
}
