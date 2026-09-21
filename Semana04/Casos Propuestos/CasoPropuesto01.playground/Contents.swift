// ===== CASO PROPUESTO 01: FACTURA DE CURSOS LIBRES — TECSUP =====
// Tema aplicado: HERENCIA (clase base Estudiante -> subclase EstudianteTecsup)
// Curso: Programación en Móviles Avanzado

import Foundation

// --- ENUM: clasifica el tipo de curso libre que dicta Tecsup.
//     Se usa enum porque las categorías son un conjunto cerrado y conocido. ---
enum CategoriaCurso {
    case programacion
    case inteligenciaArtificial
    case diseno
}

// --- STRUCT Curso: es un DATO puro, se copia por valor.
//     No necesita identidad propia, por eso es struct y no class. ---
struct Curso {
    let nombre: String          // Nombre del curso libre
    let precioUnitario: Double  // Precio de UNA inscripción al curso
    let cantidad: Int           // Cuántas veces se inscribió el estudiante
    let categoria: CategoriaCurso

    // Calcula el importe de esta línea de la factura: precio x cantidad
    func totalLinea() -> Double {
        return precioUnitario * Double(cantidad)
    }
}

// --- CLASE BASE Estudiante: representa a CUALQUIER persona que compra cursos.
//     Es class porque el estudiante tiene identidad: su lista de cursos
//     se modifica y todos deben ver los mismos datos (referencia). ---
class Estudiante {
    let nombre: String
    let dni: String
    var cursos: [Curso] = []    // Empieza vacío, se va llenando con agregarCurso

    // Porcentaje del IGV vigente en Perú. Se guarda como propiedad
    // para no repetir el número suelto por todo el código.
    let porcentajeIGV = 0.18

    init(nombre: String, dni: String) {
        self.nombre = nombre
        self.dni = dni
    }

    // Añade un curso al array de inscripciones del estudiante
    func agregarCurso(_ curso: Curso) {
        cursos.append(curso)
    }

    // Suma las CANTIDADES de todas las líneas (no la cantidad de líneas).
    // Esto es lo que se compara contra la regla de "3 o más cursos".
    func cantidadDeCursos() -> Int {
        var total = 0
        for curso in cursos {
            total += curso.cantidad
        }
        return total
    }

    // Suma el importe de todas las líneas de la factura (sin impuestos)
    func subtotal() -> Double {
        var suma = 0.0
        for curso in cursos {
            suma += curso.totalLinea()
        }
        return suma
    }

    // Calcula el impuesto: 18% aplicado sobre el subtotal
    func igv() -> Double {
        return subtotal() * porcentajeIGV
    }

    // Total gravado: es la base sobre la que se aplicarán los descuentos
    func totalConIGV() -> Double {
        return subtotal() + igv()
    }
}
