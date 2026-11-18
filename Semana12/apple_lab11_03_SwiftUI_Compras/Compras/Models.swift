import Foundation
import SwiftData

enum Rol: String, CaseIterable { case comprador = "Comprador", supervisor = "Supervisor" }
enum Estado: String { case pendiente = "Pendiente", aprobada = "Aprobada", rechazada = "Rechazada" }

@Model final class Usuario {
    var nombre: String
    @Attribute(.unique) var usuario: String
    var clave: String
    var rol: String
    @Relationship(deleteRule: .deny, inverse: \Compra.comprador) var compras: [Compra] = []
    init(nombre: String, usuario: String, clave: String, rol: Rol) {
        self.nombre = nombre; self.usuario = usuario; self.clave = clave; self.rol = rol.rawValue
    }
}
@Model final class Proveedor {
    var nombre: String
    var ruc: String
    @Relationship(deleteRule: .deny, inverse: \Compra.proveedor) var compras: [Compra] = []
    init(nombre: String, ruc: String) { self.nombre = nombre; self.ruc = ruc }
}
@Model final class Producto {
    var nombre: String
    var categoria: String
    var stock: Int
    var costoPromedio: Double
    @Relationship(deleteRule: .deny, inverse: \Compra.producto) var compras: [Compra] = []
    init(nombre: String, categoria: String, stock: Int, costoPromedio: Double) {
        self.nombre = nombre; self.categoria = categoria; self.stock = stock; self.costoPromedio = costoPromedio
    }
}
@Model final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String
    var pagada: Bool
    var motivoRechazo: String?
    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?
    init(fecha: Date, cantidad: Int, costoUnitario: Double, igv: Double, total: Double,
         alCredito: Bool, vence: Date, comprador: Usuario, proveedor: Proveedor, producto: Producto) {
        self.fecha = fecha; self.cantidad = cantidad; self.costoUnitario = costoUnitario
        self.igv = igv; self.total = total; self.alCredito = alCredito; self.vence = vence
        estado = Estado.pendiente.rawValue; pagada = false
        self.comprador = comprador; self.proveedor = proveedor; self.producto = producto
    }
    var esDeuda: Bool { estado == Estado.aprobada.rawValue && alCredito && !pagada }
    func vencida(en fecha: Date = .now) -> Bool { esDeuda && vence < fecha }
}

enum Store {
    static let schema = Schema([Usuario.self, Proveedor.self, Producto.self, Compra.self])
    static func container(memory: Bool = false, url: URL? = nil) throws -> ModelContainer {
        let config: ModelConfiguration
        if let url { config = ModelConfiguration(schema: schema, url: url) }
        else { config = ModelConfiguration("Compras", schema: schema, isStoredInMemoryOnly: memory) }
        return try ModelContainer(for: schema, configurations: [config])
    }
}
