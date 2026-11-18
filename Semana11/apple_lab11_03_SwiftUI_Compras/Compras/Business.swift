import Foundation
import SwiftData
import Observation
import CommonCrypto
import Security

struct AppError: LocalizedError {
    let message: String
    init(_ message: String) { self.message = message }
    var errorDescription: String? { message }
}
@Observable @MainActor final class Sesion {
    private(set) var usuario: Usuario?
    var supervisor: Bool { usuario?.rol == Rol.supervisor.rawValue }
    func entrar(_ usuario: Usuario) { self.usuario = usuario }
    func salir() { usuario = nil }
}

enum Password {
    static func derive(_ text: String, salt: Data, rounds: UInt32) throws -> Data {
        let password = Array(text.utf8)
        var output = Data(count: 32)
        let result = output.withUnsafeMutableBytes { out in
            salt.withUnsafeBytes { saltBytes in
                password.withUnsafeBytes { input in
                    CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), input.baseAddress?.assumingMemoryBound(to: Int8.self), password.count,
                        saltBytes.baseAddress?.assumingMemoryBound(to: UInt8.self), salt.count,
                        CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256), rounds, out.baseAddress?.assumingMemoryBound(to: UInt8.self), 32)
                }
            }
        }
        guard result == kCCSuccess else { throw AppError("No se pudo proteger la clave.") }
        return output
    }
    static func hash(_ text: String) throws -> String {
        var salt = Data(count: 16)
        let status = salt.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, 16, $0.baseAddress!) }
        guard status == errSecSuccess else { throw AppError("No se pudo generar una clave segura.") }
        let hash = try derive(text, salt: salt, rounds: 120_000)
        return "pbkdf2$120000$\(salt.base64EncodedString())$\(hash.base64EncodedString())"
    }
    static func verify(_ text: String, stored: String) -> Bool {
        let parts = stored.split(separator: "$")
        guard parts.count == 4, parts[0] == "pbkdf2", let rounds = UInt32(parts[1]), rounds == 120_000,
              let salt = Data(base64Encoded: String(parts[2])), let expected = Data(base64Encoded: String(parts[3])),
              let actual = try? derive(text, salt: salt, rounds: rounds), actual.count == expected.count else { return false }
        return zip(actual, expected).reduce(UInt8(0)) { $0 | ($1.0 ^ $1.1) } == 0
    }
}

// Validación común de alta y edición; no modifica registros existentes.
enum ProductValidation {
    static func spaces(_ text: String) -> String {
        text.split(whereSeparator: \.isWhitespace).joined(separator: " ")
    }
    static func key(_ text: String) -> String { spaces(text).lowercased() }
    static func fields(nombre: String, categoria: String, stock: Int, costo: Double) throws -> (nombre: String, categoria: String) {
        let name = spaces(nombre), category = spaces(categoria)
        guard (2...120).contains(name.count) else { throw AppError("El nombre del producto debe tener entre 2 y 120 caracteres.") }
        let lower = name.lowercased()
        let markers: Set<String> = ["test", "prueba", "asdf", "qwerty", "producto de prueba"]
        let repeatedLetter = lower.count >= 4 && lower.allSatisfy(\.isLetter) && Set(lower).count == 1
        guard !markers.contains(lower), !repeatedLetter else { throw AppError("Ingresa un nombre de producto descriptivo; evita marcadores de prueba o letras repetidas.") }
        guard (2...60).contains(category.count) else { throw AppError("La categoría debe tener entre 2 y 60 caracteres.") }
        guard stock >= 0 else { throw AppError("El stock debe ser un entero mayor o igual a cero.") }
        guard costo.isFinite, costo >= 0, (Double(stock) * costo).isFinite else { throw AppError("El costo debe ser un número finito no negativo y permitir una valoración válida del inventario.") }
        return (name, category)
    }
    static func numbers(stock: String, costo: String) throws -> (stock: Int, costo: Double) {
        guard let quantity = Int(stock.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            throw AppError("Ingresa un stock entero dentro del rango admitido por el dispositivo.")
        }
        guard let cost = Double(costo.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ",", with: ".")), cost.isFinite, cost >= 0 else {
            throw AppError("Ingresa un costo numérico, finito y mayor o igual a cero.")
        }
        guard quantity >= 0 else { throw AppError("El stock no puede ser negativo.") }
        return (quantity, cost)
    }
}

@MainActor final class ComprasService {
    let context: ModelContext
    let sesion: Sesion
    init(_ context: ModelContext, _ sesion: Sesion) { self.context = context; self.sesion = sesion; context.autosaveEnabled = false }
    static func normalized(_ value: String) -> String { value.split(whereSeparator: \.isWhitespace).joined().lowercased() }
    func save() throws { do { try context.save() } catch { context.rollback(); throw AppError("No se pudo guardar. Los cambios se revirtieron. \(error.localizedDescription)") } }
    func require(_ rol: Rol) throws -> Usuario {
        guard let u = sesion.usuario, u.rol == rol.rawValue, u.modelContext === context else { throw AppError("Tu rol no permite esta operación.") }
        return u
    }
    func exists(_ username: String) throws -> Bool {
        let key = Self.normalized(username)
        return try context.fetchCount(FetchDescriptor<Usuario>(predicate: #Predicate { $0.usuario == key })) > 0
    }
    func register(nombre: String, usuario: String, clave: String, confirmacion: String, rol: Rol) throws {
        let name = nombre.trimmingCharacters(in: .whitespacesAndNewlines), key = Self.normalized(usuario)
        guard !name.isEmpty, !key.isEmpty else { throw AppError("Completa nombre y usuario.") }
        guard clave.count >= 6 else { throw AppError("La clave debe tener al menos 6 caracteres.") }
        guard clave == confirmacion else { throw AppError("Las claves no coinciden.") }
        guard try !exists(key) else { throw AppError("Este usuario ya existe.") }
        let u = Usuario(nombre: name, usuario: key, clave: try Password.hash(clave), rol: rol)
        context.insert(u); try save(); sesion.entrar(u)
    }
    func login(usuario: String, clave: String) throws {
        let key = Self.normalized(usuario)
        let users = try context.fetch(FetchDescriptor<Usuario>(predicate: #Predicate { $0.usuario == key }))
        guard let u = users.first, Password.verify(clave, stored: u.clave) else { throw AppError("Usuario o clave incorrectos") }
        sesion.entrar(u)
    }
    static func amounts(cantidad: Int, costo: Double) throws -> (subtotal: Double, igv: Double, total: Double) {
        guard cantidad > 0, costo.isFinite, costo > 0 else { throw AppError("Cantidad y costo deben ser positivos.") }
        let subtotal = Double(cantidad) * costo, igv = subtotal * 0.18
        guard subtotal.isFinite, (subtotal + igv).isFinite else { throw AppError("El importe excede el rango permitido.") }
        return (subtotal, igv, subtotal + igv)
    }
    static func needsApproval(total: Double) -> Bool { total >= 5000 }
    static func projection(_ product: Producto, cantidad: Int, costo: Double) throws -> (stock: Int, costo: Double) {
        _ = try amounts(cantidad: cantidad, costo: costo)
        let (stock, overflow) = product.stock.addingReportingOverflow(cantidad)
        guard !overflow, product.stock >= 0, product.costoPromedio.isFinite, product.costoPromedio >= 0 else { throw AppError("Stock o costo fuera de rango.") }
        let avg = (Double(product.stock) * product.costoPromedio + Double(cantidad) * costo) / Double(stock)
        guard avg.isFinite else { throw AppError("El costo promedio excede el rango permitido.") }
        return (stock, avg)
    }
    func registerPurchase(proveedor: Proveedor, producto: Producto, cantidad: Int, costo: Double, credito: Bool, fecha: Date = .now) throws -> Compra {
        let user = try require(.comprador)
        guard proveedor.modelContext === context, producto.modelContext === context else { throw AppError("Selecciona un proveedor y producto válidos.") }
        let a = try Self.amounts(cantidad: cantidad, costo: costo)
        guard let vence = Calendar.current.date(byAdding: .day, value: 30, to: fecha) else { throw AppError("Fecha inválida.") }
        let projection = try Self.projection(producto, cantidad: cantidad, costo: costo)
        let c = Compra(fecha: fecha, cantidad: cantidad, costoUnitario: costo, igv: a.igv, total: a.total,
                       alCredito: credito, vence: vence, comprador: user, proveedor: proveedor, producto: producto)
        context.insert(c)
        if !Self.needsApproval(total: a.total) { apply(c, product: producto, projection: projection) }
        try save(); return c
    }
    private func apply(_ c: Compra, product: Producto, projection: (stock: Int, costo: Double)) {
        product.stock = projection.stock; product.costoPromedio = projection.costo
        c.estado = Estado.aprobada.rawValue; c.pagada = !c.alCredito
    }
    func approve(_ c: Compra) throws {
        _ = try require(.supervisor)
        guard c.modelContext === context, c.estado == Estado.pendiente.rawValue, let p = c.producto else { throw AppError("Esta compra ya fue procesada o no tiene producto.") }
        let projection = try Self.projection(p, cantidad: c.cantidad, costo: c.costoUnitario)
        apply(c, product: p, projection: projection); try save()
    }
    func reject(_ c: Compra, motivo: String) throws {
        _ = try require(.supervisor)
        let text = motivo.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { throw AppError("Escribe un motivo de rechazo.") }
        guard c.modelContext === context, c.estado == Estado.pendiente.rawValue else { throw AppError("Esta compra ya fue procesada.") }
        c.estado = Estado.rechazada.rawValue; c.motivoRechazo = text; try save()
    }
    func pay(_ c: Compra) throws {
        _ = try require(.supervisor)
        guard c.modelContext === context, c.esDeuda else { throw AppError("Solo se puede pagar una compra aprobada a crédito y no pagada.") }
        c.pagada = true; try save()
    }
    func visiblePurchases() throws -> [Compra] {
        guard let user = sesion.usuario else { throw AppError("Inicia sesión.") }
        let all = try context.fetch(FetchDescriptor<Compra>(sortBy: [SortDescriptor(\Compra.fecha, order: .reverse)]))
        return sesion.supervisor ? all : all.filter { $0.comprador?.persistentModelID == user.persistentModelID }
    }
    func product(_ p: Producto?, nombre: String, categoria: String, stock: Int, costo: Double) throws {
        _ = try require(.supervisor)
        if let p, p.modelContext !== context { throw AppError("Producto inválido.") }
        let values = try ProductValidation.fields(nombre: nombre, categoria: categoria, stock: stock, costo: costo)
        let nameKey = ProductValidation.key(values.nombre), categoryKey = ProductValidation.key(values.categoria)
        let products = try context.fetch(FetchDescriptor<Producto>())
        guard !products.contains(where: { item in
            item.persistentModelID != p?.persistentModelID && ProductValidation.key(item.nombre) == nameKey && ProductValidation.key(item.categoria) == categoryKey
        }) else { throw AppError("Ya existe un producto con ese nombre y categoría.") }
        if let p {
            p.nombre = values.nombre; p.categoria = values.categoria; p.stock = stock; p.costoPromedio = costo
        } else { context.insert(Producto(nombre: values.nombre, categoria: values.categoria, stock: stock, costoPromedio: costo)) }
        try save()
    }
    func supplier(_ p: Proveedor?, nombre: String, ruc: String) throws {
        _ = try require(.supervisor)
        guard !nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !ruc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { throw AppError("Completa nombre y RUC.") }
        if let p { guard p.modelContext === context else { throw AppError("Proveedor inválido.") }; p.nombre = nombre; p.ruc = ruc }
        else { context.insert(Proveedor(nombre: nombre, ruc: ruc)) }
        try save()
    }
    func delete(_ p: Producto) throws { _ = try require(.supervisor); guard p.compras.isEmpty else { throw AppError("No se puede borrar un producto con compras.") }; context.delete(p); try save() }
    func delete(_ p: Proveedor) throws { _ = try require(.supervisor); guard p.compras.isEmpty else { throw AppError("No se puede borrar un proveedor con compras.") }; context.delete(p); try save() }
    func delete(_ u: Usuario) throws { _ = try require(.supervisor); guard u.compras.isEmpty else { throw AppError("No se puede borrar un usuario con compras.") }; context.delete(u); try save(); if sesion.usuario === u { sesion.salir() } }
}
