import XCTest
import SwiftData
@testable import Compras

@MainActor private struct Fixture {
    let container: ModelContainer
    let context: ModelContext
    let session: Sesion
    let service: ComprasService
    let buyer: Usuario
    let supervisor: Usuario
    let product: Producto
    let supplier: Proveedor
    init(url: URL? = nil) throws {
        container = try Store.container(memory: url == nil, url: url)
        context = ModelContext(container); session = Sesion(); service = ComprasService(context, session)
        try service.register(nombre: "Comprador QA", usuario: "qa-buyer", clave: "SoloQA123", confirmacion: "SoloQA123", rol: .comprador)
        buyer = session.usuario!
        try service.register(nombre: "Supervisor QA", usuario: "qa-supervisor", clave: "SoloQA123", confirmacion: "SoloQA123", rol: .supervisor)
        supervisor = session.usuario!
        try service.product(nil, nombre: "Laptop QA", categoria: "Equipos", stock: 40, costo: 110)
        try service.supplier(nil, nombre: "Proveedor QA", ruc: "20111111111")
        product = try context.fetch(FetchDescriptor<Producto>()).first!
        supplier = try context.fetch(FetchDescriptor<Proveedor>()).first!
        session.entrar(buyer)
    }
    func purchase(_ quantity: Int, credit: Bool = true, date: Date = .now) throws -> Compra {
        try service.registerPurchase(proveedor: supplier, producto: product, cantidad: quantity, costo: 120, credito: credit, fecha: date)
    }
}
final class ComprasDomainTests: XCTestCase {
    @MainActor func test01RegistrationAndDuplicate() throws {
        let f = try Fixture()
        try f.service.register(nombre: "María Torres", usuario: "mtorres", clave: "SoloQA123", confirmacion: "SoloQA123", rol: .comprador)
        XCTAssertEqual(f.session.usuario?.usuario, "mtorres")
        XCTAssertNotEqual(f.session.usuario?.clave, "SoloQA123")
        XCTAssertThrowsError(try f.service.register(nombre: "Otro", usuario: " MT ORRES ", clave: "SoloQA123", confirmacion: "SoloQA123", rol: .comprador))
        XCTAssertThrowsError(try f.service.register(nombre: "Otro", usuario: "otro", clave: "1234", confirmacion: "1234", rol: .comprador))
        XCTAssertThrowsError(try f.service.register(nombre: "Otro", usuario: "otro", clave: "SoloQA123", confirmacion: "diferente", rol: .comprador))
    }
    @MainActor func test02IncorrectLogin() throws {
        let f = try Fixture(); f.session.salir()
        XCTAssertThrowsError(try f.service.login(usuario: "qa-buyer", clave: "incorrecta")) { XCTAssertEqual($0.localizedDescription, "Usuario o clave incorrectos") }
        XCTAssertNil(f.session.usuario)
        try f.service.login(usuario: " QA-BUYER ", clave: "SoloQA123")
        XCTAssertEqual(f.session.usuario?.rol, "Comprador")
    }
    @MainActor func test03CreditPurchase() throws {
        let f = try Fixture(), date = Date.now, c = try f.purchase(10, date: date)
        XCTAssertEqual(c.igv, 216); XCTAssertEqual(c.total, 1416)
        XCTAssertEqual(f.product.stock, 50); XCTAssertEqual(f.product.costoPromedio, 112)
        XCTAssertEqual(c.estado, "Aprobada"); XCTAssertTrue(c.esDeuda)
        XCTAssertEqual(c.vence, Calendar.current.date(byAdding: .day, value: 30, to: date))
    }
    @MainActor func test04CashPurchase() throws {
        let f = try Fixture(), c = try f.purchase(10, credit: false)
        XCTAssertTrue(c.pagada); XCTAssertFalse(c.esDeuda)
    }
    @MainActor func test05PendingHasNoEffects() throws {
        let f = try Fixture(), c = try f.purchase(50)
        XCTAssertEqual(c.total, 7080); XCTAssertEqual(c.estado, "Pendiente")
        XCTAssertEqual(f.product.stock, 40); XCTAssertEqual(f.product.costoPromedio, 110); XCTAssertFalse(c.esDeuda)
    }
    @MainActor func test06ApproveExactlyOnce() throws {
        let f = try Fixture(), c = try f.purchase(50)
        f.session.entrar(f.supervisor); try f.service.approve(c)
        XCTAssertEqual(f.product.stock, 90); XCTAssertEqual(f.product.costoPromedio, 10400 / 90, accuracy: 0.000001)
        XCTAssertTrue(c.esDeuda); XCTAssertThrowsError(try f.service.approve(c)); XCTAssertEqual(f.product.stock, 90)
    }
    @MainActor func test07RejectRequiresReason() throws {
        let f = try Fixture(), c = try f.purchase(50)
        f.session.entrar(f.supervisor)
        XCTAssertThrowsError(try f.service.reject(c, motivo: "  "))
        try f.service.reject(c, motivo: "Precio elevado")
        XCTAssertEqual(c.estado, "Rechazada"); XCTAssertEqual(c.motivoRechazo, "Precio elevado")
        XCTAssertEqual(f.product.stock, 40); XCTAssertFalse(c.esDeuda)
    }
    @MainActor func test08OverdueAndPayOnce() throws {
        let f = try Fixture(), c = try f.purchase(10, date: Calendar.current.date(byAdding: .day, value: -45, to: .now)!)
        XCTAssertTrue(c.vencida()); f.session.entrar(f.supervisor); try f.service.pay(c)
        XCTAssertTrue(c.pagada); XCTAssertFalse(c.esDeuda); XCTAssertFalse(c.vencida())
        XCTAssertEqual(f.product.stock, 50); XCTAssertThrowsError(try f.service.pay(c))
    }
    @MainActor func test09OwnPurchasesAndRoles() throws {
        let f = try Fixture(), c = try f.purchase(10)
        XCTAssertEqual(try f.service.visiblePurchases().count, 1)
        XCTAssertThrowsError(try f.service.pay(c)); XCTAssertThrowsError(try f.service.approve(c))
        XCTAssertThrowsError(try f.service.reject(c, motivo: "No autorizado"))
        XCTAssertThrowsError(try f.service.product(nil, nombre: "X", categoria: "X", stock: 0, costo: 0))
        XCTAssertThrowsError(try f.service.supplier(nil, nombre: "X", ruc: "X"))
        try f.service.register(nombre: "Otro QA", usuario: "otro-qa", clave: "SoloQA123", confirmacion: "SoloQA123", rol: .comprador)
        XCTAssertTrue(try f.service.visiblePurchases().isEmpty)
    }
    @MainActor func test10BoundaryAndDeletionGuards() throws {
        let f = try Fixture()
        XCTAssertFalse(ComprasService.needsApproval(total: 4999.99)); XCTAssertTrue(ComprasService.needsApproval(total: 5000))
        let c = try f.service.registerPurchase(proveedor: f.supplier, producto: f.product, cantidad: 1, costo: 5000 / 1.18, credito: true)
        XCTAssertEqual(c.estado, "Pendiente"); XCTAssertEqual(f.product.stock, 40)
        f.session.entrar(f.supervisor)
        XCTAssertThrowsError(try f.service.delete(f.product)); XCTAssertThrowsError(try f.service.delete(f.supplier)); XCTAssertThrowsError(try f.service.delete(f.buyer))
        XCTAssertThrowsError(try f.purchase(1))
    }
    @MainActor func test11PersistentReopen() throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("Compras-XCTest-\(UUID()).store")
        do { let f = try Fixture(url: url); _ = try f.purchase(10) }
        let reopened = try Store.container(url: url), context = ModelContext(reopened)
        let c = try XCTUnwrap(context.fetch(FetchDescriptor<Compra>()).first)
        XCTAssertEqual(c.total, 1416); XCTAssertEqual(c.producto?.stock, 50); XCTAssertEqual(c.comprador?.usuario, "qa-buyer")
        let session = Sesion(), service = ComprasService(context, session)
        try service.login(usuario: "qa-buyer", clave: "SoloQA123")
        XCTAssertEqual(session.usuario?.nombre, "Comprador QA")
    }
    @MainActor func test12SupervisorCatalogCRUD() throws {
        let f = try Fixture(); f.session.entrar(f.supervisor)
        try f.service.product(f.product, nombre: "Editado QA", categoria: "Otra", stock: 9, costo: 22)
        try f.service.supplier(f.supplier, nombre: "Editado QA", ruc: "20222222222")
        XCTAssertEqual(f.product.nombre, "Editado QA"); XCTAssertEqual(f.product.stock, 9)
        XCTAssertEqual(f.supplier.ruc, "20222222222")
        try f.service.delete(f.product); try f.service.delete(f.supplier); try f.service.delete(f.buyer)
        XCTAssertEqual(try f.context.fetchCount(FetchDescriptor<Producto>()), 0)
        XCTAssertEqual(try f.context.fetchCount(FetchDescriptor<Proveedor>()), 0)
        XCTAssertEqual(try f.context.fetchCount(FetchDescriptor<Usuario>()), 1)
    }

}
