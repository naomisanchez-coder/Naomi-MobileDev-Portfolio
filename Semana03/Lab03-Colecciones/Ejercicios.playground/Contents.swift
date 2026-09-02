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

// Desarrollado por: Naomi Sánchez
// Ejercicio 4: Combinación de Colecciones
import Foundation

// ===== Ejemplo resuelto: Sistema de notas =====
var notasPa: [String: Double] = [:]
var notasPb: [String: Double] = [:]

print("¿Cuántos alumnos?")
let cantidadAlumnos = Int(readLine() ?? "") ?? 0

if cantidadAlumnos > 0 {
    for i in 1...cantidadAlumnos {
        print("\nAlumno \(i) - Nombre:")
        let nombre = readLine() ?? ""
        print("Nota Pa:")
        let pa = Double(readLine() ?? "") ?? 0
        print("Nota Pb:")
        let pb = Double(readLine() ?? "") ?? 0
        notasPa[nombre] = pa
        notasPb[nombre] = pb
    }
}

print("\n===== REPORTE DE NOTAS =====")
var totalAprobados = 0
var sumaGeneral = 0.0

for (alumno, pa) in notasPa {
    if let pb = notasPb[alumno] {
        let notaFinal = 0.30 * pa + 0.70 * pb
        let estado = notaFinal >= 13.0 ? "Aprobado" : "Desaprobado"
        print("\(alumno): Pa=\(pa) Pb=\(pb) Final=\(notaFinal) -> \(estado)")
        sumaGeneral += notaFinal
        if notaFinal >= 13.0 {
            totalAprobados += 1
        }
    }
}

if !notasPa.isEmpty {
    print("Promedio general: \(sumaGeneral / Double(notasPa.count))")
    print("Aprobados: \(totalAprobados) de \(notasPa.count)")
}

// ===== TODO 10: Inventario de productos =====
var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

print("\n¿Cuántos productos desea registrar?")
let totalProds = Int(readLine() ?? "") ?? 0

if totalProds > 0 {
    for i in 1...totalProds {
        print("\nProducto \(i) - Nombre:")
        let nombre = readLine() ?? ""
        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0
        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0
        
        precios[nombre] = precio
        stocks[nombre] = stock
    }
}

// Calcular valor total del inventario (precio * stock)
var valorTotalInventario = 0.0
for (prod, precio) in precios {
    if let stock = stocks[prod] {
        valorTotalInventario += precio * Double(stock)
    }
}
print("\n===== INVENTARIO =====")
print("Valor total del inventario: S/. \(valorTotalInventario)")

// Mostrar productos con stock bajo (< 5)
print("\n===== PRODUCTOS CON STOCK BAJO (< 5) =====")
var hayStockBajo = false
for (prod, stock) in stocks {
    if stock < 5 {
        print("- \(prod): \(stock) unidades (S/. \(precios[prod] ?? 0) c/u)")
        hayStockBajo = true
    }
}
if !hayStockBajo {
    print("No hay productos con stock crítico.")
}

// Desarrollado por: Naomi Sánchez
// Ejercicio 5: Carrito de Compras 2.0
import Foundation

// ===== CARRITO DE COMPRAS 2.0 =====
var nombresCarrito: [String] = []
var preciosCarrito: [Double] = []
var cantidadesCarrito: [Int] = []

// TODO 11: Pedir productos
print("¿Cuántos productos va a comprar?")
let totalProductos = Int(readLine() ?? "") ?? 0

if totalProductos > 0 {
    for i in 1...totalProductos {
        print("\nProducto \(i) - Nombre:")
        nombresCarrito.append(readLine() ?? "")
        print("Precio unitario:")
        preciosCarrito.append(Double(readLine() ?? "") ?? 0)
        print("Cantidad:")
        cantidadesCarrito.append(Int(readLine() ?? "") ?? 0)
    }
}

// TODO 12: Calcular subtotales
var subtotales: [Double] = []
for i in 0..<nombresCarrito.count {
    let sub = preciosCarrito[i] * Double(cantidadesCarrito[i])
    subtotales.append(sub)
}

// TODO 13: Total del carrito
var totalCarrito = 0.0
for sub in subtotales {
    totalCarrito += sub
}

// TODO 14: Nombre del cliente
print("\nNombre del cliente:")
let cliente = readLine() ?? ""

// TODO 15: Descuento
var descPct = 0.0
if totalCarrito >= 5000 {
    descPct = 0.15
} else if totalCarrito >= 2000 {
    descPct = 0.10
} else if totalCarrito >= 500 {
    descPct = 0.05
}

let descuento = totalCarrito * descPct
let totalConDesc = totalCarrito - descuento

// TODO 16: IGV y total
let igv = totalConDesc * 0.18
let totalFinal = totalConDesc + igv

// TODO 17: Categoría
var categoria = ""
switch Int(totalCarrito) {
case 0..<500:
    categoria = "Regular"
case 500..<2000:
    categoria = "Frecuente"
case 2000..<5000:
    categoria = "VIP"
default:
    categoria = "Premium"
}

// TODO 18: Ticket
let sep = String(repeating: "=", count: 45)
print(sep)
print("        TICKET DE COMPRA 2.0")
print("Cliente: \(cliente) (\(categoria))")
print(sep)

for i in 0..<nombresCarrito.count {
    print("\(nombresCarrito[i]) x\(cantidadesCarrito[i])    S/. \(subtotales[i])")
}

print(sep)
print("Subtotal:        S/. \(totalCarrito)")
if descPct > 0 {
    print("Descuento (\(descPct * 100)%): -S/. \(descuento)")
}
print("IGV (18%):        S/. \(igv)")
print(sep)
print("TOTAL:           S/. \(totalFinal)")
print(sep)
print("¡Gracias por su compra, \(cliente)!")

// Desarrollado por: Naomi Sánchez
// Importa la librería base de Swift para funciones esenciales del sistema
import Foundation

// Declaración del diccionario de alumnos con sus 3 notas [String: [Double]]
var diccionarioAlumnos: [String: [Double]] = [:]

// Muestra el mensaje para pedir la cantidad de alumnos a ingresar
print("¿Cuántos alumnos desea registrar?")

// Lee el valor desde consola y lo convierte a entero de forma segura
let totalAlumnosReg = Int(readLine() ?? "") ?? 0

// Valida que el número de alumnos ingresado sea positivo
if totalAlumnosReg > 0 {
    // Bucle para iterar sobre la cantidad de alumnos a registrar
    for i in 1...totalAlumnosReg {
        // Muestra en consola el identificador del alumno actual
        print("\n--- Alumno \(i) ---")
        // Solicita el nombre del alumno por consola
        print("Nombre del alumno:")
        // Almacena el nombre ingresado o asigna un texto vacío si es nulo
        let nombreAlumno = readLine() ?? ""
        // Crea un arreglo local para guardar las 3 notas del alumno
        var notasDelAlumno: [Double] = []
        // Bucle para solicitar exactamente las 3 notas requeridas
        for j in 1...3 {
            // Imprime la indicación de cuál nota se está solicitando
            print("Nota \(j):")
            // Convierte la entrada a Double o asigna 0.0 por defecto
            let valorNota = Double(readLine() ?? "") ?? 0.0
            // Agrega la nota ingresada al arreglo local de notas
            notasDelAlumno.append(valorNota)
        }
        // Asigna el arreglo de notas a la clave del nombre dentro del diccionario
        diccionarioAlumnos[nombreAlumno] = notasDelAlumno
    }
}

// Inicializa el acumulador para la suma global de todos los promedios
var sumaTotalPromedios = 0.0
// Inicializa el contador de la cantidad de alumnos que aprobaron
var totalAprobadosReg = 0
// Variable tupla opcional para registrar al alumno con mayor promedio
var estudianteMaxPromedio: (nombre: String, promedio: Double)? = nil
// Variable tupla opcional para registrar al alumno con menor promedio
var estudianteMinPromedio: (nombre: String, promedio: Double)? = nil
// Arreglo de tuplas para almacenar los resultados procesados antes de ordenar
var listaProcesadaNotas: [(nombre: String, promedio: Double, estado: String)] = []

// Recorre cada elemento clave-valor contenido en el diccionario de alumnos
for (estudiante, listaNotas) in diccionarioAlumnos {
    // Suma todas las notas del alumno mediante la función reduce
    let sumaNotasEstudiante = listaNotas.reduce(0.0, +)
    // Calcula el promedio dividiendo la suma entre el total de notas
    let promedioEstudiante = sumaNotasEstudiante / Double(listaNotas.count)
    // Acumula el promedio al total global para calcular la media general
    sumaTotalPromedios += promedioEstudiante
    
    // Declaración de la variable para guardar el resultado de la clasificación
    var clasificacionNota = ""
    // Clasifica el promedio del alumno mediante una estructura switch
    switch Int(promedioEstudiante) {
    // Evalúa si el promedio se encuentra en el rango de 18 a 20
    case 18...20:
        // Asigna la categoría Excelente para promedios altos
        clasificacionNota = "Excelente"
    // Evalúa si el promedio se encuentra en el rango de 14 a 17
    case 14...17:
        // Asigna la categoría Bueno para promedios intermedios altos
        clasificacionNota = "Bueno"
    // Evalúa si el promedio se encuentra en el rango de 11 a 13
    case 11...13:
        // Asigna la categoría Aprobado para promedios mínimos requeridos
        clasificacionNota = "Aprobado"
    // Captura cualquier otro promedio menor a 11
    default:
        // Asigna la categoría Desaprobado para notas deficientes
        clasificacionNota = "Desaprobado"
    }
    
    // Evalúa si la nota promedio cumple con la condición de aprobación (>= 11)
    if promedioEstudiante >= 11.0 {
        // Incrementa la cuenta de estudiantes aprobados
        totalAprobadosReg += 1
    }
    
    // Comprueba si es el primer registro o si supera el promedio máximo guardado
    if estudianteMaxPromedio == nil || promedioEstudiante > estudianteMaxPromedio!.promedio {
        // Actualiza la tupla con los datos del nuevo máximo
        estudianteMaxPromedio = (nombre: estudiante, promedio: promedioEstudiante)
    }
    
    // Comprueba si es el primer registro o si es menor al promedio mínimo guardado
    if estudianteMinPromedio == nil || promedioEstudiante < estudianteMinPromedio!.promedio {
        // Actualiza la tupla con los datos del nuevo mínimo
        estudianteMinPromedio = (nombre: estudiante, promedio: promedioEstudiante)
    }
    
    // Agrega el registro procesado a la lista temporal de resultados
    listaProcesadaNotas.append((nombre: estudiante, promedio: promedioEstudiante, estado: clasificacionNota))
}

// Ordena la lista de alumnos en forma descendente según sus promedios
let alumnosOrdenados = listaProcesadaNotas.sorted { $0.promedio > $1.promedio }

// Imprime el encabezado para la presentación de los resultados ordenados
print("\n===== RESULTADOS (ORDENADOS POR PROMEDIO) =====")
// Iteración sobre la lista previamente ordenada de alumnos
for item in alumnosOrdenados {
    // Muestra en consola el nombre, el promedio formateado y la clasificación
    print("Alumno: \(item.nombre) | Promedio: \(String(format: "%.2f", item.promedio)) | Clasificación: \(item.estado)")
}

// Comprueba que el diccionario no esté vacío antes de calcular estadísticas
if !diccionarioAlumnos.isEmpty {
    // Muestra el encabezado del reporte de estadísticas generales
    print("\n===== ESTADÍSTICAS DEL GRUPO =====")
    // Divide la suma de promedios entre la cantidad total de alumnos
    let mediaGeneral = sumaTotalPromedios / Double(diccionarioAlumnos.count)
    // Imprime el promedio general obtenido del grupo
    print("Promedio general: \(String(format: "%.2f", mediaGeneral))")
    
    // Desempaqueta de forma segura la tupla con el promedio más alto
    if let maximo = estudianteMaxPromedio {
        // Muestra en pantalla el alumno con la nota más alta
        print("Nota más alta: \(maximo.nombre) (\(String(format: "%.2f", maximo.promedio)))")
    }
    
    // Desempaqueta de forma segura la tupla con el promedio más bajo
    if let minimo = estudianteMinPromedio {
        // Muestra en pantalla el alumno con la nota más baja
        print("Nota más baja: \(minimo.nombre) (\(String(format: "%.2f", minimo.promedio)))")
    }
    
    // Calcula el porcentaje global de estudiantes aprobados
    let porcentajeAprobacion = (Double(totalAprobadosReg) / Double(diccionarioAlumnos.count)) * 100.0
    // Imprime en consola el porcentaje calculado de aprobados
    print("Porcentaje de aprobados: \(String(format: "%.1f", porcentajeAprobacion))%")
}
