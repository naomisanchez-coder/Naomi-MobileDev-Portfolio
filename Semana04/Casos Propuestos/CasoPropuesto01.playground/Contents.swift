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
    let porcentajeIGV = 0.18    // Porcentaje del IGV vigente en Perú

    init(nombre: String, dni: String) {
        self.nombre = nombre
        self.dni = dni
    }

    // Añade un curso al array de inscripciones del estudiante
    func agregarCurso(_ curso: Curso) {
        cursos.append(curso)
    }

    // Suma las CANTIDADES de todas las líneas (no la cantidad de líneas).
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

    // REGLA 1: 10% de descuento sobre el total con IGV si lleva 3 o más cursos
    func descuentoPorCantidad() -> Double {
        if cantidadDeCursos() >= 3 {
            return totalConIGV() * 0.10
        }
        return 0.0
    }

    // REGLA 2: en la clase base no hay beneficio institucional
    func descuentoEspecial() -> Double {
        return 0.0
    }

    // Etiqueta que aparece en la cabecera de la factura
    func etiquetaAlumnoTecsup() -> String {
        return "No"
    }

    // Monto final: al total gravado se le restan los dos descuentos
    func totalFinal() -> Double {
        return totalConIGV() - descuentoPorCantidad() - descuentoEspecial()
    }

    // Formatea un monto a 2 decimales, como se muestra en una boleta real
    func montoFormateado(_ valor: Double) -> String {
        return String(format: "%.2f", valor)
    }

    // Imprime la factura completa. Se escribe UNA sola vez en la clase base:
    // la subclase la hereda y el resultado cambia solo por los override.
    func mostrarFactura() {
        print("🎓 FACTURA DE CURSOS")
        print("Estudiante: \(nombre)")
        print("DNI: \(dni)")
        print("Alumno de Tecsup: \(etiquetaAlumnoTecsup())")
        print("------------------------------")

        for curso in cursos {
            print("\(curso.nombre) x\(curso.cantidad) - S/ \(montoFormateado(curso.totalLinea()))")
        }

        print("------------------------------")
        print("Subtotal: S/ \(montoFormateado(subtotal()))")
        print("IGV (18%): S/ \(montoFormateado(igv()))")
        print("Total con IGV: S/ \(montoFormateado(totalConIGV()))")

        if descuentoPorCantidad() > 0.0 {
            print("Descuento 10% por cantidad: -S/ \(montoFormateado(descuentoPorCantidad()))")
        }
        if descuentoEspecial() > 0.0 {
            print("Descuento especial Tecsup: -S/ \(montoFormateado(descuentoEspecial()))")
        }

        print("💰 TOTAL FINAL A PAGAR: S/ \(montoFormateado(totalFinal()))")
    }
}

// --- HERENCIA: EstudianteTecsup HEREDA todo el cálculo de Estudiante
//     (cursos, subtotal, IGV, descuento por cantidad, total final, mostrarFactura)
//     y solo REDEFINE las dos reglas que le son propias. ---
class EstudianteTecsup: Estudiante {
    let codigoAlumno: String    // Propiedad NUEVA que la clase base no tiene

    init(nombre: String, dni: String, codigoAlumno: String) {
        self.codigoAlumno = codigoAlumno            // 1ro: la propiedad propia
        super.init(nombre: nombre, dni: dni)        // 2do: inicializa lo heredado
    }

    // override porque ya existe en la clase padre y cambiamos su resultado
    override func etiquetaAlumnoTecsup() -> String {
        return "Sí"
    }

    // REGLA 2 aplicada: S/ 400 de descuento, pero SOLO si compró 3 o más cursos
    override func descuentoEspecial() -> Double {
        if cantidadDeCursos() >= 3 {
            return 400.0
        }
        return 0.0
    }
}

// ===== SIMULACIÓN =====

// Estudiante que SÍ es alumno de Tecsup -> se instancia la subclase
let juan = EstudianteTecsup(nombre: "Juan León", dni: "78965412", codigoAlumno: "T-2025-001")

// Se inscribe a 3 cursos distintos, uno de ellos dos veces (4 inscripciones)
juan.agregarCurso(Curso(nombre: "Swift Avanzado", precioUnitario: 450.0, cantidad: 1, categoria: .programacion))
juan.agregarCurso(Curso(nombre: "IA con Python", precioUnitario: 650.0, cantidad: 2, categoria: .inteligenciaArtificial))
juan.agregarCurso(Curso(nombre: "Diseño UX/UI", precioUnitario: 500.0, cantidad: 1, categoria: .diseno))

juan.mostrarFactura()

// --- Prueba de contraste: el mismo flujo con la CLASE BASE ---
print("")
let ana = Estudiante(nombre: "Ana Rojas", dni: "70123456")
ana.agregarCurso(Curso(nombre: "Swift Avanzado", precioUnitario: 450.0, cantidad: 1, categoria: .programacion))
ana.mostrarFactura()
