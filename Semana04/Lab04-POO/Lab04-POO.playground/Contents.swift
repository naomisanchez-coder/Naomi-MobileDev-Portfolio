// ===== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Docente: Juan León
import Foundation

enum CategoriaElectro {
    case lineaBlanca, tecnologia, pequenos
}

struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

class Sucursal {
    let nombre: String
    let ciudad: String
    
    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }
    
    func descuento() -> Double {
        return 0.05
    }
    
    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }
    
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1.0 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio
        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}

// TODO 14: SucursalLima
class SucursalLima: Sucursal {
    override func descuento() -> Double {
        return 0.10
    }
    
    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500.0 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// TODO 15: SucursalProvincia
class SucursalProvincia: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        let calculo = monto * 0.08
        if calculo < 50.0 {
            return 50.0
        } else {
            return calculo
        }
    }
}

// TODO 16: SucursalOutlet
class SucursalOutlet: Sucursal {
    override func descuento() -> Double {
        return 0.25
    }
    
    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// TODO 18: Prueba de extensible (SucursalOnline)
class SucursalOnline: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}
// Respuesta TODO 18: Se agregaron exactamente 5 líneas para incluir SucursalOnline sin alterar el resto del código.

// TODO 17: Recorrido Polimórfico
let refrigeradora = Electrodomestico(nombre: "Refrigeradora", marca: "Frost", precioLista: 2000.0, categoria: .lineaBlanca)
let licuadora = Electrodomestico(nombre: "Licuadora", marca: "Mix", precioLista: 250.0, categoria: .pequenos)

let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima"),
    SucursalOnline(nombre: "Online Global", ciudad: "Digital")
]

print("===== Refrigeradora (S/ 2000.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

print("\n===== Licuadora (S/ 250.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}

// ===== FIX: Corrección de Errores =====

class SucursalMall: Sucursal {
    // FIX 7: Se añade 'override' requerido por Swift al sobreescribir métodos
    override func descuento() -> Double {
        return 0.12
    }
}

class SucursalExpress: Sucursal {
    let radioKm: Int
    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        // FIX 8: Se requiere super.init(...) para inicializar las propiedades heredadas
        super.init(nombre: nombre, ciudad: ciudad)
    }
}

// ===== PREDICT: Análisis de Ejecución =====

let misteriosa: Sucursal = SucursalLima(nombre: "Lima Centro", ciudad: "Lima")

// PREDICT 6: Devuelve 0.1
// Justificación: La instancia real es SucursalLima. Swift usa despacho dinámico en tiempo de ejecución para invocar su método descuento().
print(misteriosa.descuento())

let monto = 2000.0 * (1.0 - misteriosa.descuento())

// PREDICT 7: Devuelve 0.0
// Justificación: El monto calculado es S/ 1800.0. Al evaluarse la condición (monto >= 1500.0) en SucursalLima, retorna 0.0.
print(misteriosa.costoEnvio(monto: monto))

// ===== CASO 2 — PARTE A: BIBLIOTECA (SIN IA) =====
// Docente: Juan León

// TODO 19: escribe aquí el enum, el struct, la clase y la simulación

enum EstadoLibro {
    case disponible
    case prestado
}

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}

class Biblioteca {
    var libros: [Libro] = []
    
    func agregar(libro: Libro) {
        libros.append(libro)
    }
    
    // Agrega estos métodos DENTRO de la clase Biblioteca:
        
    func prestar(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado
                    print("Préstamo aprobado: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya está prestado")
                    return false
                }
            }
        }
        print("Error: no existe \(titulo)")
        return false
    }
    
    func devolver(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible
                    print("Devolución registrada: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya está disponible")
                    return false
                }
            }
        }
        print("Error: no existe \(titulo)")
        return false
    }


// Agrega este método DENTRO de la clase Biblioteca:
func inventario() {
        print("===== INVENTARIO =====")
        for libro in libros {
            let estadoTexto: String
            switch libro.estado {
            case .disponible:
                estadoTexto = "disponible"
            case .prestado:
                estadoTexto = "prestado"
            }
            print("\(libro.titulo) (\(libro.autor)) - \(estadoTexto)")
        }
    }
}

// ===== SIMULACIÓN CASO 2A (BIBLIOTECA SIN IA) =====

let biblio = Biblioteca()

// 1. Agregar los tres libros iniciales
biblio.agregar(libro: Libro(titulo: "Cien años de soledad", autor: "Gabriel García Márquez"))
biblio.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa"))
biblio.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes"))

// 2. Prestar "La ciudad y los perros"
_ = biblio.prestar(titulo: "La ciudad y los perros")

// 3. Intentar prestarlo de nuevo (Error)
_ = biblio.prestar(titulo: "La ciudad y los perros")

// 4. Devolverlo
_ = biblio.devolver(titulo: "La ciudad y los perros")

// 5. Prestar "El Quijote"
_ = biblio.prestar(titulo: "El Quijote")

// 6. Intentar prestar "El Principito" (no existe)
_ = biblio.prestar(titulo: "El Principito")

// 7. Mostrar inventario final
biblio.inventario()

// ===== CASO 2 — PARTE B: BIBLIOTECA (CON IA) =====
// Docente: Juan León

// TODO 20: pega aquí el código generado por la IA, ya comentado línea por línea

// Enum para definir los estados posibles de un libro
enum EstadoLibroIA {
    case disponible // Representa que el libro se encuentra listo para préstamo
    case prestado   // Representa que el libro fue entregado a un usuario
}

// Estructura Libro con semántica de valor
struct LibroIA {
    let titulo: String                 // Nombre inmutable del libro
    let autor: String                  // Autor inmutable del libro
    var estado: EstadoLibroIA = .disponible // Estado inicializado por defecto en disponible
}

// Clase Biblioteca que maneja la colección por referencia
class BibliotecaIA {
    var libros: [LibroIA] = [] // Colección mutable para almacenar las instancias de LibroIA
    
    // Agrega un nuevo libro al arreglo del catálogo
    func agregar(libro: LibroIA) {
        libros.append(libro) // Inserta el objeto al final del arreglo
    }
    
    // Procesa el préstamo iterando el arreglo por rango de índices
    func prestar(titulo: String) -> Bool {
        for i in 0..<libros.count { // Recorre los índices válidos desde 0 hasta el total de elementos
            if libros[i].titulo == titulo { // Evalúa si el título coincide con la búsqueda
                if libros[i].estado == .disponible { // Comprueba si el libro no está prestado
                    libros[i].estado = .prestado // Modifica directamente la propiedad del struct en la posición i
                    print("Préstamo aprobado: \(titulo)") // Muestra la confirmación de éxito
                    return true // Devuelve verdadero y finaliza la ejecución de la función
                } else {
                    print("Error: \(titulo) ya está prestado") // Notifica que el libro ya se encuentra prestado
                    return false // Devuelve falso indicando falla
                }
            }
        }
        print("Error: no existe \(titulo)") // Imprime mensaje de error al no encontrar coincidencia
        return false // Devuelve falso si el libro no existe
    }
    
    // Procesa la devolución con la lógica inversa al préstamo
    func devolver(titulo: String) -> Bool {
        for i in 0..<libros.count { // Recorre el arreglo por sus índices
            if libros[i].titulo == titulo { // Compara si el título es igual al buscado
                if libros[i].estado == .prestado { // Comprueba si el estado actual es prestado
                    libros[i].estado = .disponible // Cambia el estado a disponible directamente en la lista
                    print("Devolución registrada: \(titulo)") // Imprime la confirmación de devolución
                    return true // Retorna verdadero al completar el proceso
                } else {
                    print("Error: \(titulo) ya está disponible") // Reporta error si el libro no estaba prestado
                    return false // Retorna falso al no poder devolver
                }
            }
        }
        print("Error: no existe \(titulo)") // Notifica que el libro no forma parte del catálogo
        return false // Retorna falso al no existir
    }
    
    // Muestra en consola el listado de libros evaluando con switch
    func inventario() {
        print("===== INVENTARIO =====") // Imprime el título de la sección
        for libro in libros { // Iteración estándar sobre los elementos del catálogo
            let estadoTexto: String // Constante auxiliar para guardar el texto descriptivo
            switch libro.estado { // Evalúa la variable enum del libro actual
            case .disponible:
                estadoTexto = "disponible" // Cadena asignada cuando el libro está libre
            case .prestado:
                estadoTexto = "prestado" // Cadena asignada cuando el libro está prestado
            }
            print("\(libro.titulo) (\(libro.autor)) - \(estadoTexto)") // Formatea la salida completa en consola
        }
    }
}

// --- Simulación Caso 2B ---
let biblioIA = BibliotecaIA() // Crea la instancia de la biblioteca

// Añade los libros iniciales
biblioIA.agregar(libro: LibroIA(titulo: "Cien años de soledad", autor: "Gabriel García Márquez"))
biblioIA.agregar(libro: LibroIA(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa"))
biblioIA.agregar(libro: LibroIA(titulo: "El Quijote", autor: "Miguel de Cervantes"))

// Ejecución de la secuencia de prueba
_ = biblioIA.prestar(titulo: "La ciudad y los perros")
_ = biblioIA.prestar(titulo: "La ciudad y los perros")
_ = biblioIA.devolver(titulo: "La ciudad y los perros")
_ = biblioIA.prestar(titulo: "El Quijote")
_ = biblioIA.prestar(titulo: "El Principito")
biblioIA.inventario()
    

