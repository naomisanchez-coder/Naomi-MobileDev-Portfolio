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
