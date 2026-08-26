import UIKit

// ==========================================
// EJERCICIO 1: VARIABLES Y CONSTANTES
// Docente: Juan León
// ==========================================

// --- Ejemplo (ya resuelto) ---
let nombreProfesor = "Juan Leon"
var puntosProfesor = 100
print("Profesor: \(nombreProfesor), puntos: \(puntosProfesor)")

// --- TODO 1: Declara una CONSTANTE con tu nombre completo
let nombreCompleto = "Naomi Sanchez"

// --- TODO 2: Declara una VARIABLE con tu edad
var edad = 20

// --- TODO 3: Declara una CONSTANTE con tu estatura (Double)
let estatura: Double = 1.60

// --- TODO 4: Declara una VARIABLE Bool: ¿trabajas actualmente?
var trabaja: Bool = false

// --- TODO 5: Declara una CONSTANTE con tu número de celular como String
let celular: String = "902633254"

// --- TODO 6: Imprime TODAS tus variables con print()
print("Nombre: \(nombreCompleto), Edad: \(edad), Estatura: \(estatura), Trabaja: \(trabaja), Celular: \(celular)")


// ==========================================
// 1.2 CORREGIR ERRORES (FIX)
// ==========================================

// FIX 1: 'let' define una constante que no se puede reasignar. Se cambió a 'var'.
var puntaje = 50
puntaje = 80

// FIX 2: No se debe usar 'var' dos veces para la misma variable en el mismo ámbito.
var nombre = "Ana"
nombre = "Maria"

// FIX 3: 29.99 es un valor decimal (Double), no un entero (Int).
let precio: Double = 29.99

// FIX 4: "true" entre comillas es un String; el tipo Bool usa true sin comillas.
var activo: Bool = true


// ==========================================
// 1.3 PREDICCIONES (PREDICT)
// ==========================================

let x = 10
var y = 20
y = y + x
print(y) // PREDICT 1: Imprime 30 (20 + 10)

do {
    let a = "Hola"
    let b = "Mundo"
    print(a + " " + b) // PREDICT 2
}

var contador = 0
contador = contador + 1
contador = contador + 1
contador = contador + 1
print(contador) // PREDICT 3: Imprime 3

let entero = 7
let decimal = Double(entero)
print(type(of: decimal)) // PREDICT 4: Imprime Double


// ==========================================
// 1.4 INFERENCIA DE TIPOS
// ==========================================

// TODO 7: Swift infiere Int
let anio = 2026
print(type(of: anio))

// TODO 8: Swift infiere Double
let peso = 72.5
print(type(of: peso))

// TODO 9: Swift infiere String
let ciudad = "Lima"
print(type(of: ciudad))

// TODO 10: Swift infiere Bool
let matriculado = false
print(type(of: matriculado))

// ==========================================
// EJERCICIO 2: OPERACIONES ARITMÉTICAS
// Docente: Juan León
// ==========================================

let a = 25
let b = 7

// --- Ejemplo (ya resuelto):
let suma = a + b
print("Suma: \(a) + \(b) = \(suma)") // 32

// --- TODO 11: Calcula la resta ---
let resta = a - b
print("Resta: \(a) - \(b) = \(resta)")

// --- TODO 12: Calcula la multiplicación ---
let multiplicacion = a * b
print("Multiplicación: \(a) * \(b) = \(multiplicacion)")

// --- TODO 13: Calcula la división entera ---
let divisionEntera = a / b
print("División entera: \(a) / \(b) = \(divisionEntera)")

// --- TODO 14: Calcula el residuo (módulo) ---
let residuo = a % b
print("Residuo: \(a) % \(b) = \(residuo)")


// ==========================================
// 2.2 — PREDICCIÓN DE DIVISIÓN
// ==========================================

print(10 / 3)   // PREDICT 5a: 3
print(10 % 3)   // PREDICT 5b: 1
print(20 / 7)   // PREDICT 5c: 2
print(20 % 7)   // PREDICT 5d: 6
print(100 / 3)  // PREDICT 5e: 33
print(100 % 3)  // PREDICT 5f: 1


// ==========================================
// 2.3 — CORREGIR CÁLCULOS (FIX)
// ==========================================

// FIX 5: Faltaban paréntesis. Sin ellos, dividía solo nota3 entre 3.
let nota1 = 15
let nota2 = 12
let nota3 = 18
let promedio = (nota1 + nota2 + nota3) / 3
print("Promedio: \(promedio)")

// FIX 6: Faltaban paréntesis para priorizar la resta antes de multiplicar.
let fahrenheit = 98.6
let celsius = (fahrenheit - 32) * 5 / 9
print("Celsius: \(celsius)")

// FIX 7: Se convierten los Int a Double para obtener la división con decimales (3.5714...).
let dividendo = 25
let divisor = 7
let resultado = Double(dividendo) / Double(divisor)
print("Resultado: \(resultado)")


// ==========================================
// 2.4 — CÁLCULOS PRÁCTICOS
// ==========================================

// --- TODO 15: Calcula el IGV (18%) de un producto de S/. 350.00
let precioProducto = 350.0
let igv = precioProducto * 0.18
let precioConIgv = precioProducto + igv
print("Precio: S/. \(precioProducto)")
print("IGV: S/. \(igv)")
print("Total: S/. \(precioConIgv)")

// --- TODO 16: Calcula el área de un círculo con radio 5.0
let pi = 3.14159
let radio = 5.0
let area = pi * radio * radio
print("Área: \(area)")

// --- TODO 17: Calcula tu nota final del curso
let notaPa = 15.0
let notaPb = 13.0
let notaFinal = 0.30 * notaPa + 0.70 * notaPb
print("Nota final: \(notaFinal)")
print("¿Aprueba? \(notaFinal >= 13.0)")

// ==========================================
// EJERCICIO 3: INTERPOLACIÓN DE CADENAS
// Docente: Juan León
// ==========================================

// --- 3.1 — Completar interpolación
do {
    let fruta = "manzana"
    let cantidad = 5
    let precio = 2.50
    print("Compré \(cantidad) \(fruta)s por S/. \(Double(cantidad) * precio)")

    // --- TODO 18: Crea tu tarjeta de presentación ---
    let nombre = "Naomi"
    let apellido = "Sanchez"
    let edad = 20
    let carrera = "Diseño y Desarrollo de Software"
    let ciclo = 3
    let distrito = "Lima"

    print("Me llamo \(nombre) \(apellido), tengo \(edad) años.")
    print("Estudio \(carrera), ciclo \(ciclo).")
    print("Vivo en \(distrito).")
}

// --- 3.2 — Factura con cálculos
do {
    // ===== TODO 19: Completa la factura =====
    let prod1 = "Laptop"
    let prec1 = 3500.00
    let cant1 = 1

    let prod2 = "Mouse"
    let prec2 = 45.50
    let cant2 = 2

    let prod3 = "Teclado"
    let prec3 = 120.00
    let cant3 = 1

    // TODO: Calcula el subtotal de cada producto
    let sub1 = prec1 * Double(cant1)
    let sub2 = prec2 * Double(cant2)
    let sub3 = prec3 * Double(cant3)

    // TODO: Calcula el subtotal general
    let subtotalGeneral = sub1 + sub2 + sub3

    // TODO: Calcula el IGV (18%)
    let igv = subtotalGeneral * 0.18

    // TODO: Calcula el total
    let total = subtotalGeneral + igv

    // TODO: Imprime la factura usando interpolación:
    print("==================================")
    print("       FACTURA DE VENTA           ")
    print("1. \(prod1) x\(cant1): S/. \(sub1)")
    print("2. \(prod2) x\(cant2): S/. \(sub2)")
    print("3. \(prod3) x\(cant3): S/. \(sub3)")
    print("----------------------------------")
    print("Subtotal: S/. \(subtotalGeneral)")
    print("IGV 18%:   S/. \(igv)")
    print("TOTAL:     S/. \(total)")
    print("==================================")
}

// --- 3.3 — Predicción de interpolación
do {
    let n = "Swift"
    let v = 5
    print("\(n) versión \(v)")             // PREDICT 6a: Swift versión 5
    print("\(v) x \(v) = \(v * v)")         // Imprime: 5 x 5 = 25
    print("Hay \(v + 3) alumnos")          // PREDICT 6b: Hay 8 alumnos

    let p1 = 100.0                          // PREDICT 6c: Declara precio base 100.0
    let d = 0.15
    print("Descuento: S/. \(p1 * d)")      // PREDICT 6d: Descuento: S/. 15.0
}

// ==========================================
// EJERCICIO 4: INVESTIGACIÓN Y CONVERSIONES
// Docente: Juan León
// ==========================================

// --- 4.1 — Conversiones de tipo
do {
    // ===== TODO 20: Completa las conversiones =====
    let entero = 42
    let decimal = 9.99
    let texto = "150"
    let textoInvalido = "hola"

    // TODO: Convierte 'entero' a Double
    let enteroADouble = Double(entero)
    print(enteroADouble) // Imprime: 42.0

    // TODO: Convierte 'decimal' a Int
    let decimalAEntero = Int(decimal)
    print(decimalAEntero) // PREDICT 7: Imprime 9 (Swift trunca la parte decimal, no redondea).

    // TODO: Convierte 'texto' a Int
    let textoAEntero = Int(texto)
    print(textoAEntero) // PREDICT 8: Imprime Optional(150) (Retorna un Int opcional porque la conversión puede fallar).

    // TODO: Convierte 'textoInvalido' a Int
    let invalido = Int(textoInvalido)
    print(invalido) // PREDICT 9: Imprime nil (La conversión falla completamente porque el texto contiene letras).
}

// --- 4.2 — Ejercicio de investigación
do {
    // ===== TODO 21: Redondear un Double a 2 decimales =====
    let piValor = 3.14159
    let piRedondeado = String(format: "%.2f", piValor)
    print("Pi a 2 decimales: \(piRedondeado)")
    
    /*
     EXPLICACIÓN TODO 21:
     Se utilizó el especificador de formato `String(format: "%.2f", valor)`.
     El parámetro `%.2f` le indica a Swift que formatee el número de tipo Double
     mostrando exactamente 2 dígitos decimales redondeados.
    */

    // ===== TODO 22: Operador += en Swift =====
    /*
     EXPLICACIÓN TODO 22:
     El operador `+=` es el operador de adición y asignación combinada.
     Suma el valor del lado derecho al valor actual de la variable y guarda
     el resultado en esa misma variable (equivale a escribir `x = x + valor`).
    */

    // Ejemplo 1: Incrementar un contador o puntaje
    var puntaje = 100
    puntaje += 50
    print("Ejemplo 1 (Puntaje): \(puntaje)")

    // Ejemplo 2: Concatenar/acumular texto en un String
    var mensaje = "Hola"
    mensaje += " Swift"
    print("Ejemplo 2 (Texto): \(mensaje)")

    // Ejemplo 3: Acumular compras en una cuenta
    var totalCuenta = 20.5
    totalCuenta += 9.5
    print("Ejemplo 3 (Cuenta): \(totalCuenta)")
}
