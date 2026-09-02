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
