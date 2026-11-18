import Foundation
import SwiftData

@main struct BusinessTests {
    @MainActor static func main() throws {
        var passed = 0
        func check(_ condition: @autoclosure () -> Bool, _ label: String) throws {
            guard condition() else { throw AppError("FAIL: \(label)") }; passed += 1; print("PASS: \(label)")
        }
        func fails(_ label: String, _ operation: () throws -> Void) throws {
            do { try operation() } catch { passed += 1; print("PASS: \(label)"); return }
            throw AppError("FAIL: \(label)")
        }
        let container = try Store.container(memory: true), session = Sesion()
        let ctx = ModelContext(container), service = ComprasService(ctx, session)
        try service.register(nombre: "María Torres", usuario: " mTorres ", clave: "segura123", confirmacion: "segura123", rol: .comprador)
        let buyer = session.usuario!
        try check(buyer.usuario == "mtorres" && buyer.clave != "segura123", "1 registro normalizado, sesión y hash")
        try fails("1 duplicado normalizado") { try service.register(nombre: "Otro", usuario: "MT ORRES", clave: "segura123", confirmacion: "segura123", rol: .comprador) }
        try fails("clave corta") { try service.register(nombre: "Otro", usuario: "otro", clave: "1234", confirmacion: "1234", rol: .comprador) }
        try fails("confirmación distinta") { try service.register(nombre: "Otro", usuario: "otro", clave: "123456", confirmacion: "123457", rol: .comprador) }
        session.salir()
        do { try service.login(usuario: "mtorres", clave: "incorrecta"); throw AppError("FAIL login") }
        catch { try check(error.localizedDescription == "Usuario o clave incorrectos" && session.usuario == nil, "2 login genérico sin sesión") }
        try service.login(usuario: " MTORRES ", clave: "segura123")
        try service.register(nombre: "Supervisor", usuario: "supervisor", clave: "segura123", confirmacion: "segura123", rol: .supervisor)
        let supervisor = session.usuario!
        try service.supplier(nil, nombre: "Distribuidora Lima", ruc: "20123456789")
        let supplier = try ctx.fetch(FetchDescriptor<Proveedor>()).first!
        func product(_ name: String) throws -> Producto {
            session.entrar(supervisor)
            try service.product(nil, nombre: name, categoria: "Equipos", stock: 40, costo: 110)
            return try ctx.fetch(FetchDescriptor<Producto>()).first { $0.nombre == name }!
        }
        let p = try product("Caso 3"); session.entrar(buyer)
        let date = Date(timeIntervalSince1970: 1_700_000_000)
        let c = try service.registerPurchase(proveedor: supplier, producto: p, cantidad: 10, costo: 120, credito: true, fecha: date)
        try check(c.igv == 216 && c.total == 1416 && c.cantidad == 10 && p.stock == 50 && p.costoPromedio == 112 && c.esDeuda && c.vence == Calendar.current.date(byAdding: .day, value: 30, to: date), "3 crédito, importes, stock, promedio y 30 días")
        let p4 = try product("Caso 4"); session.entrar(buyer)
        let c4 = try service.registerPurchase(proveedor: supplier, producto: p4, cantidad: 10, costo: 120, credito: false)
        try check(c4.pagada && !c4.esDeuda && c4.estado == "Aprobada", "4 contado pagado sin deuda")
        let p5 = try product("Casos 5 y 6"); session.entrar(buyer)
        let c5 = try service.registerPurchase(proveedor: supplier, producto: p5, cantidad: 50, costo: 120, credito: true)
        try check(c5.total == 7080 && c5.estado == "Pendiente" && !c5.esDeuda && p5.stock == 40 && p5.costoPromedio == 110, "5 base independiente 40/110, pendiente sin efectos")
        try fails("comprador no aprueba") { try service.approve(c5) }
        session.entrar(supervisor); try service.approve(c5)
        try check(p5.stock == 90 && abs(p5.costoPromedio - 115.55555555555556) < 0.00001 && c5.esDeuda, "6 aprobación 90 y 115.56")
        try fails("reaprobación bloqueada") { try service.approve(c5) }
        try check(p5.stock == 90, "aprobación exactamente una vez")
        session.entrar(buyer)
        let c7 = try service.registerPurchase(proveedor: supplier, producto: p5, cantidad: 50, costo: 120, credito: true)
        session.entrar(supervisor)
        try fails("7 rechazo sin motivo") { try service.reject(c7, motivo: "  ") }
        try service.reject(c7, motivo: "Precio elevado")
        try check(c7.estado == "Rechazada" && c7.motivoRechazo == "Precio elevado" && p5.stock == 90 && !c7.esDeuda, "7 rechazo con motivo sin efectos")
        try fails("rechazada no se aprueba") { try service.approve(c7) }
        let debtBefore = supplier.compras.filter(\.esDeuda).reduce(0) { $0 + $1.total }
        try check(c.vencida(), "8 vencimiento pasado")
        try service.pay(c)
        let debtAfter = supplier.compras.filter(\.esDeuda).reduce(0) { $0 + $1.total }
        try check(c.pagada && !c.esDeuda && !c.vencida() && debtBefore - debtAfter == 1416 && p.stock == 50, "8 pago reduce deuda sin reaplicar stock")
        try fails("doble pago") { try service.pay(c) }
        try fails("pago de rechazada") { try service.pay(c7) }
        try service.register(nombre: "Otro comprador", usuario: "otro", clave: "segura123", confirmacion: "segura123", rol: .comprador)
        let other = session.usuario!
        let otherVisible = try service.visiblePurchases()
        try check(otherVisible.isEmpty, "9 otro comprador no ve compras ajenas")
        session.entrar(buyer)
        let ownVisible = try service.visiblePurchases()
        try check(ownVisible.allSatisfy { $0.comprador === buyer }, "9 solo compras propias")
        try fails("9 comprador no paga") { try service.pay(c5) }
        try fails("comprador no crea producto") { try service.product(nil, nombre: "X", categoria: "X", stock: 0, costo: 0) }
        try fails("comprador no elimina proveedor") { try service.delete(supplier) }
        session.entrar(supervisor)
        try fails("deny producto con compras") { try service.delete(p5) }
        try fails("deny proveedor con compras") { try service.delete(supplier) }
        try fails("deny usuario con compras") { try service.delete(buyer) }
        try check(ComprasService.needsApproval(total: 5000) && !ComprasService.needsApproval(total: 4999.99), "frontera 5000 exactos")
        session.entrar(buyer)
        let boundary = try service.registerPurchase(proveedor: supplier, producto: p5, cantidad: 1, costo: 5000 / 1.18, credito: true)
        try check(abs(boundary.total - 5000) < 0.000001 && boundary.estado == "Pendiente" && p5.stock == 90, "compra en frontera sin efectos")
        try fails("cantidad cero") { _ = try service.registerPurchase(proveedor: supplier, producto: p, cantidad: 0, costo: 120, credito: true) }
        try fails("costo infinito") { _ = try service.registerPurchase(proveedor: supplier, producto: p, cantidad: 1, costo: .infinity, credito: true) }
        let zero = Producto(nombre: "Cero", categoria: "Test", stock: 0, costoPromedio: 0)
        let projection = try ComprasService.projection(zero, cantidad: 10, costo: 120)
        try check(projection.stock == 10 && projection.costo == 120, "stock inicial cero")
        let all = try ctx.fetch(FetchDescriptor<Compra>())
        let igv = all.filter { $0.estado == "Aprobada" }.reduce(0) { $0 + $1.igv }
        try check(igv == 1512, "crédito fiscal solo aprobadas: 216 + 216 + 1080")
        session.entrar(supervisor)
        try service.product(p5, nombre: "Producto editado", categoria: "Actualizado", stock: 91, costo: 116)
        try check(p5.stock == 91 && p5.costoPromedio == 116 && p5.nombre == "Producto editado", "supervisor puede editar producto con compras sin borrarlo")
        session.entrar(other); session.salir(); try check(session.usuario == nil, "cierre de sesión")
        // Persistencia aislada en disco; nunca se abre ni borra la base de uso normal.
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("ComprasTests-\(UUID()).sqlite")
        do {
            let disk = try Store.container(url: url), dc = ModelContext(disk), ds = Sesion(), svc = ComprasService(dc, ds)
            try svc.register(nombre: "Persistente", usuario: "persistente", clave: "segura123", confirmacion: "segura123", rol: .supervisor)
            try svc.supplier(nil, nombre: "Persistido", ruc: "123")
            try svc.product(nil, nombre: "Persistido", categoria: "Prueba", stock: 40, costo: 110)
            let supplier = try dc.fetch(FetchDescriptor<Proveedor>()).first!, product = try dc.fetch(FetchDescriptor<Producto>()).first!
            try svc.register(nombre: "Comprador disco", usuario: "disco", clave: "segura123", confirmacion: "segura123", rol: .comprador)
            _ = try svc.registerPurchase(proveedor: supplier, producto: product, cantidad: 10, costo: 120, credito: true)
        }
        let reopened = try Store.container(url: url), rc = ModelContext(reopened)
        let persisted = try rc.fetch(FetchDescriptor<Compra>()).first!
        try check(persisted.total == 1416 && persisted.esDeuda && persisted.producto?.stock == 50 && persisted.comprador?.usuario == "disco", "persistencia y relaciones tras reabrir contenedor")
        print("RESULTADO: \(passed) comprobaciones correctas")
    }
}
