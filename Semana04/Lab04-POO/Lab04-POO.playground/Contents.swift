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
}
