// Desarrollado por: Naomi Sánchez
// Ejercicio 1: Arrays
import Foundation

// ===== Ejemplo resuelto: Registro de notas interactivo =====
var notas: [Double] = []

// Pedir al usuario 3 notas
for i in 1...3 {
    print("Ingrese la nota \(i):")
    let entrada = readLine() ?? ""
    let nota = Double(entrada) ?? 0
    notas.append(nota)
}

// Mostrar las notas ingresadas
print("\nNotas ingresadas: \(notas)")
print("Total de notas: \(notas.count)")

// Calcular el promedio
var suma = 0.0
for nota in notas {
    suma += nota
}
let promedio = suma / Double(notas.count)

// Mostrar resultados
print("Suma: \(suma)")
print("Promedio: \(promedio)")
print("Nota más alta: \(notas.max()!)")
print("Nota más baja: \(notas.min()!)")
print("Notas ordenadas: \(notas.sorted())")

// ===== TODO 1: Registro de 5 alumnos =====
var alumnos: [String] = []
for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}
print("Alumnos: \(alumnos)")

// ===== TODO 2: Buscar un alumno =====
print("Buscar alumno:")
let buscar = readLine() ?? ""
if alumnos.contains(buscar) {
    print("\(buscar) está en la lista")
} else {
    print("\(buscar) NO está en la lista")
}

// ===== TODO 3: Notas con clasificación =====
var notasClase: [Double] = []
for i in 1...5 {
    print("Nota del alumno \(i):")
    let n = Double(readLine() ?? "") ?? 0
    notasClase.append(n)
}
var aprobados = 0
var desaprobados = 0
var sumaNotas = 0.0

for nota in notasClase {
    sumaNotas += nota
    if nota >= 13 {
        aprobados += 1
    } else {
        desaprobados += 1
    }
}
print("Promedio: \(sumaNotas / Double(notasClase.count))")
print("Aprobados: \(aprobados), Desaprobados: \(desaprobados)")

// ===== FIX: Errores corregidos =====
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Uva") // FIX 1: Corregido, no se puede agregar un Int (7) a un array de Strings.

var colores = ["Rojo", "Azul", "Verde"] // FIX 2: Corregido de 'let' a 'var' para permitir mutación.
colores.append("Amarillo")

let numeros = [10, 20, 30, 40, 50]
print(numeros[4]) // FIX 3: Corregido índice de 5 a 4 (los índices válidos son de 0 a 4).

// ===== PREDICT =====
var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)
print(lista)
print(lista.count)
// PREDICT 1: [2, 3, 4, 5, 6]
// PREDICT 2: 5

var nombres = ["Ana", "Carlos", "Beto"]
print(nombres.sorted())
print(nombres)
// PREDICT 3: ["Ana", "Beto", "Carlos"]
// PREDICT 4: ["Ana", "Carlos", "Beto"]

// Desarrollado por: Naomi Sánchez
// Ejercicio 2: Diccionarios
import Foundation

// ===== Ejemplo resuelto: Directorio de contactos =====
var contactos: [String: String] = [:]

for i in 1...3 {
    print("\nContacto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Teléfono:")
    let telefono = readLine() ?? ""
    contactos[nombre] = telefono
}

print("\n===== DIRECTORIO =====")
for (nombre, telefono) in contactos {
    print("\(nombre): \(telefono)")
}

print("\nBuscar contacto:")
let buscarContacto = readLine() ?? ""
if let tel = contactos[buscarContacto] {
    print("Teléfono de \(buscarContacto): \(tel)")
} else {
    print("\(buscarContacto) no encontrado")
}

// ===== TODO 4: Catálogo de productos =====
var productos: [String: Double] = [:]
for i in 1...4 {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    productos[nombre] = precio
}

// ===== TODO 5: Mostrar catálogo =====
print("===== CATÁLOGO =====")
for (nombre, precio) in productos {
    print("\(nombre): S/. \(precio)")
}

// ===== TODO 6: Valor total =====
var valorTotal = 0.0
for (_, precio) in productos {
    valorTotal += precio
}
print("Valor total: S/. \(valorTotal)")

// ===== TODO 7: Buscar producto =====
print("Buscar producto:")
let buscarProd = readLine() ?? ""
if let precioEncontrado = productos[buscarProd] {
    print("\(buscarProd) cuesta S/. \(precioEncontrado)")
} else {
    print("Producto no encontrado")
}

// ===== ANALYZE =====
var edades: [String: Int] = ["Ana": 20, "Luis": 22, "María": 19]
var mayores: [String] = []

for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre)
    }
}
print("Mayores de 21: \(mayores)")

// ANALYZE 1: ¿Qué hace? ¿Qué imprime?
// Respuesta: Recorre el diccionario de edades, filtra las personas con edad mayor o igual a 21 y guarda sus nombres en el array 'mayores'.
// Imprime: Mayores de 21: ["Luis"]

// Desarrollado por: Naomi Sánchez
// Ejercicio 3: Sets
import Foundation

// ===== Ejemplo resuelto: Alumnos en cursos =====
var alumnosIOS: Set<String> = []
print("===== ALUMNOS iOS =====")
for i in 1...3 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    alumnosIOS.insert(nombre)
}

var alumnosAndroid: Set<String> = []
print("\n===== ALUMNOS ANDROID =====")
for i in 1...3 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    alumnosAndroid.insert(nombre)
}

let enAmbos = alumnosIOS.intersection(alumnosAndroid)
let todos = alumnosIOS.union(alumnosAndroid)
let soloIOS = alumnosIOS.subtracting(alumnosAndroid)
let soloAndroid = alumnosAndroid.subtracting(alumnosIOS)

print("\n===== RESULTADOS =====")
print("En ambos: \(enAmbos)")
print("Solo iOS: \(soloIOS)")
print("Solo Android: \(soloAndroid)")
print("Total únicos: \(todos.count)")

// ===== TODO 8: Eliminar duplicados =====
var numerosDuplicados: [Int] = []
for i in 1...8 {
    print("Número \(i):")
    let n = Int(readLine() ?? "") ?? 0
    numerosDuplicados.append(n)
}
print("Con duplicados: \(numerosDuplicados)")
let sinDuplicados = Array(Set(numerosDuplicados)).sorted()
print("Sin duplicados: \(sinDuplicados)")

// ===== TODO 9: Comparar asistencia =====
var asistenciaLunes: Set<String> = []
print("\n===== ASISTENCIA LUNES =====")
for i in 1...4 {
    print("Alumno \(i) (Lunes):")
    let nombre = readLine() ?? ""
    asistenciaLunes.insert(nombre)
}

var asistenciaMartes: Set<String> = []
print("\n===== ASISTENCIA MARTES =====")
for i in 1...4 {
    print("Alumno \(i) (Martes):")
    let nombre = readLine() ?? ""
    asistenciaMartes.insert(nombre)
}

print("\n===== REPORTE ASISTENCIA =====")
print("Asistieron ambos días: \(asistenciaLunes.intersection(asistenciaMartes))")
print("Solo lunes: \(asistenciaLunes.subtracting(asistenciaMartes))")
print("Solo martes: \(asistenciaMartes.subtracting(asistenciaLunes))")

// ===== PREDICT =====
let setA: Set = [1, 2, 3, 4, 5]
let setB: Set = [4, 5, 6, 7, 8]

print(setA.intersection(setB))
// PREDICT 5: Set([4, 5])

print(setA.union(setB).count)
// PREDICT 6: 8

print(setA.subtracting(setB))
// PREDICT 7: Set([1, 2, 3])

var repetidos: Set = ["A", "B", "A", "C", "B"]
print(repetidos.count)
// PREDICT 8: 3
