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

let a = "Hola"
let b = "Mundo"
print(a + " " + b) // PREDICT 2: Imprime "Hola Mundo"

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
