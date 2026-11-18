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

    @MainActor private func productRejected(_ name: String = "Monitor Dell P2422H", category: String = "Monitores", stock: Int = 2, cost: Double = 900) throws {
        let f = try Fixture(); f.session.entrar(f.supervisor)
        let count = try f.context.fetchCount(FetchDescriptor<Producto>())
        XCTAssertThrowsError(try f.service.product(nil, nombre: name, categoria: category, stock: stock, costo: cost))
        XCTAssertEqual(try f.context.fetchCount(FetchDescriptor<Producto>()), count)
        XCTAssertFalse(f.context.hasChanges)
    }
    @MainActor func test13ProductEmptyName() throws { try productRejected("") }
    @MainActor func test14ProductWhitespaceName() throws { try productRejected("  \n ") }
    @MainActor func test15ProductNameLength() throws {
        try productRejected("X"); try productRejected(String(repeating: "Ab", count: 61))
    }
    @MainActor func test16ProductObviousPlaceholders() throws {
        for name in ["XXXxxx", "aaaa", "Prueba", "TEST", "producto de prueba"] { try productRejected(name) }
    }
    @MainActor func test17ProductCommercialCodes() throws {
        let f = try Fixture(); f.session.entrar(f.supervisor)
        for name in ["3M", "HP", "WD", "X100", "iPhone 17 Pro", "ASUS ROG", "Tornillo M3 x 20"] {
            try f.service.product(nil, nombre: name, categoria: "Catálogo", stock: 0, costo: 0)
        }
        XCTAssertEqual(try f.context.fetchCount(FetchDescriptor<Producto>()), 8)
    }
    @MainActor func test18ProductDuplicateNormalization() throws {
        let f = try Fixture(); f.session.entrar(f.supervisor)
        XCTAssertThrowsError(try f.service.product(nil, nombre: "  LAPTOP   qa  ", categoria: "  eQUIPOS ", stock: 1, costo: 1))
        try f.service.product(nil, nombre: "Laptop QA", categoria: "Accesorios", stock: 1, costo: 1)
        let other = try XCTUnwrap(f.context.fetch(FetchDescriptor<Producto>()).first { $0.categoria == "Accesorios" })
        XCTAssertThrowsError(try f.service.product(other, nombre: "laptop QA", categoria: "Equipos", stock: 1, costo: 1))
        XCTAssertEqual(other.categoria, "Accesorios")
    }
    @MainActor func test19ProductCategoryValidation() throws {
        for category in ["", "   ", "A", String(repeating: "C", count: 61)] { try productRejected(category: category) }
    }
    @MainActor func test20ProductNegativeStock() throws { try productRejected(stock: -1) }
    func test21ProductStockParsing() throws {
        for stock in ["abc", "1.5", "9223372036854775808", "999999999999999999999999", "-1"] {
            XCTAssertThrowsError(try ProductValidation.numbers(stock: stock, costo: "1"))
        }
        XCTAssertEqual(try ProductValidation.numbers(stock: String(Int.max), costo: "0").stock, Int.max)
    }
    @MainActor func test22ProductInvalidCost() throws {
        for cost in [Double.nan, .infinity, -.infinity, -1, .greatestFiniteMagnitude] { try productRejected(cost: cost) }
        for text in ["NaN", "inf", "1e309", "abc", "-1"] { XCTAssertThrowsError(try ProductValidation.numbers(stock: "1", costo: text)) }
        XCTAssertEqual(try ProductValidation.numbers(stock: " 2 ", costo: " 10,50 ").costo, 10.5)
    }
    @MainActor func test23ProductValidEditExcludesSelf() throws {
        let f = try Fixture(); f.session.entrar(f.supervisor)
        try f.service.product(f.product, nombre: " LAPTOP   QA ", categoria: " Equipos ", stock: 45, costo: 115)
        XCTAssertEqual(f.product.nombre, "LAPTOP QA"); XCTAssertEqual(f.product.stock, 45)
        XCTAssertEqual(try f.context.fetchCount(FetchDescriptor<Producto>()), 1)
    }
    @MainActor func test24ProductValidCreationNormalizesSpaces() throws {
        let f = try Fixture(); f.session.entrar(f.supervisor)
        try f.service.product(nil, nombre: "  Monitor   Dell P2422H ", categoria: " Monitores   LED ", stock: 2, costo: 899.5)
        let p = try XCTUnwrap(f.context.fetch(FetchDescriptor<Producto>()).first { $0.nombre == "Monitor Dell P2422H" })
        XCTAssertEqual(p.categoria, "Monitores LED"); XCTAssertEqual(p.costoPromedio, 899.5)
    }

}
