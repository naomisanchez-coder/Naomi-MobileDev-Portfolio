import XCTest

final class ComprasUITests: XCTestCase {
    @MainActor func testScreensAndRoles() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["--ui-testing"]
        app.launch()
        func capture(_ name: String) {
            let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
            attachment.name = name; attachment.lifetime = .keepAlways; add(attachment)
        }
        func fill(_ placeholder: String, _ text: String, secure: Bool = false) {
            let field = secure ? app.secureTextFields[placeholder] : app.textFields[placeholder]
            if app.buttons["Listo"].exists { app.buttons["Listo"].tap() }
            for _ in 0..<6 { if field.exists && field.isHittable { break }; app.swipeUp() }
            XCTAssertTrue(field.waitForExistence(timeout: 8), placeholder)
            field.coordinate(withNormalizedOffset: CGVector(dx: 0.85, dy: 0.5)).tap(); field.typeText(text)
        }
        func register(_ username: String, supervisor: Bool) {
            app.buttons["Crear cuenta"].tap()
            XCTAssertTrue(app.navigationBars["Crear cuenta"].waitForExistence(timeout: 8))
            fill("Nombre completo", username)
            fill("Usuario único", username)
            fill("Clave · mínimo 6 caracteres", "Prueba123", secure: true)
            fill("Confirmar clave", "Prueba123", secure: true)
            app.swipeUp()
            if supervisor { app.segmentedControls.buttons["Supervisor"].tap() }
            app.swipeDown()
            capture("B2 Registro datos")
            app.swipeUp()
            capture("B2 Registro rol")
            app.buttons["Registrarme"].tap()
            XCTAssertTrue(app.tabBars.buttons["Productos"].waitForExistence(timeout: 10))
        }
        func logout() {
            app.buttons["Cuenta y cerrar sesión"].firstMatch.tap()
            app.buttons["Cerrar sesión"].tap()
            XCTAssertTrue(app.buttons["Crear cuenta"].waitForExistence(timeout: 8))
        }
        func login(_ username: String) {
            fill("login.usuario", username)
            fill("login.clave", "Prueba123", secure: true)
            app.buttons["login.ingresar"].tap()
            XCTAssertTrue(app.tabBars.buttons["Productos"].waitForExistence(timeout: 8))
        }
        func replace(_ placeholder: String, _ value: String) {
            let field = app.textFields[placeholder]
            field.tap()
            let old = field.value as? String ?? ""
            field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: old.count) + value)
        }
        func createProduct(_ name: String) {
            app.buttons["Añadir producto"].tap()
            fill("Nombre", name); fill("Categoría", "Equipos")
            replace("Stock inicial", "40"); replace("Costo promedio (S/)", "110")
            app.buttons["Guardar"].tap()
            for _ in 0..<5 { if app.staticTexts[name].exists { break }; app.swipeUp() }
            XCTAssertTrue(app.staticTexts[name].waitForExistence(timeout: 8))
        }
        func purchase(product: String, quantity: String, credit: Bool = true) {
            app.tabBars.buttons["Compra"].tap()
            app.descendants(matching: .any).matching(identifier: "compra.proveedor").firstMatch.tap(); app.buttons["Lima SAC"].tap()
            app.descendants(matching: .any).matching(identifier: "compra.producto").firstMatch.tap(); app.buttons[product].tap()
            fill("Cantidad", quantity); fill("Costo unitario (S/)", "120")
            app.buttons["Listo"].tap()
            app.swipeUp()
            app.segmentedControls.buttons[credit ? "Crédito 30 días" : "Contado"].tap()
            capture("B5 Nueva compra")
            let button = app.buttons[quantity == "50" ? "Enviar a aprobación" : "Registrar compra"]
            if !button.isHittable { app.swipeUp() }
            button.tap()
            XCTAssertTrue(app.alerts["Compra guardada"].waitForExistence(timeout: 8))
            app.alerts.buttons["Aceptar"].tap()
        }
        XCTAssertTrue(app.buttons["Crear cuenta"].waitForExistence(timeout: 10))
        capture("B1 Login")
        register("qa-redesign-supervisor", supervisor: true)
        XCTAssertEqual(app.tabBars.buttons.count, 5)
        app.tabBars.buttons["Productos"].tap()
        createProduct("Laptop UI"); createProduct("Monitor UI")
        capture("B3 Productos")
        app.swipeUp()
        capture("B3 Detalle catalogo")
        app.tabBars.buttons["Proveedores"].tap()
        app.buttons["Añadir proveedor"].tap()
        fill("Nombre o razón social", "Lima SAC"); fill("RUC", "20123456789")
        app.buttons["Guardar"].tap()
        XCTAssertTrue(app.staticTexts["Lima SAC"].waitForExistence(timeout: 8))
        capture("B4 Proveedores")
        logout()
        register("qa-redesign-comprador", supervisor: false)
        XCTAssertEqual(app.tabBars.buttons.count, 4)
        XCTAssertFalse(app.buttons["Añadir producto"].exists)
        purchase(product: "Laptop UI", quantity: "10")
        purchase(product: "Monitor UI", quantity: "50")
        purchase(product: "Laptop UI", quantity: "1", credit: false)
        purchase(product: "Laptop UI", quantity: "50")
        app.tabBars.buttons["Mis compras"].tap()
        XCTAssertTrue(app.staticTexts["Pendiente"].waitForExistence(timeout: 8))
        capture("B6 Mis compras")
        logout(); login("qa-redesign-supervisor")
        app.tabBars.buttons["Aprobar"].tap()
        XCTAssertTrue(app.buttons["aprobar.compra"].firstMatch.waitForExistence(timeout: 8))
        capture("B7 Aprobar")
        for _ in 0..<6 { if app.buttons["aprobar.compra"].firstMatch.isHittable { break }; app.swipeUp() }
        app.buttons["aprobar.compra"].firstMatch.tap()
        app.buttons["Aprobar compra"].tap()
        XCTAssertTrue(app.buttons["Rechazar"].waitForExistence(timeout: 8))
        for _ in 0..<6 { if app.buttons["Rechazar"].isHittable { break }; app.swipeUp() }
        app.buttons["Rechazar"].tap()
        app.alerts.textFields["Motivo obligatorio"].typeText("Precio elevado QA")
        app.alerts.buttons["Rechazar"].tap()
        XCTAssertTrue(app.staticTexts["Todo al día"].waitForExistence(timeout: 8))
        capture("B7 Todo al dia")
        app.tabBars.buttons["Por pagar"].tap()
        XCTAssertTrue(app.buttons["Pagar compra"].firstMatch.waitForExistence(timeout: 8))
        capture("B8 Por pagar")
        app.segmentedControls.buttons["Vencidas"].tap()
        capture("B8 Vencidas vacio")
        app.segmentedControls.buttons["Pendientes"].tap()
        app.buttons["Pagar compra"].firstMatch.tap(); app.buttons["Confirmar pago"].tap()
        app.segmentedControls.buttons["Pagadas"].tap()
        XCTAssertTrue(app.staticTexts["Pagada"].waitForExistence(timeout: 8))
        capture("B8 Pagadas")
        app.tabBars.buttons["Resumen"].tap()
        XCTAssertTrue(app.staticTexts["Valor del inventario"].waitForExistence(timeout: 8))
        capture("B9 Resumen")
        app.swipeUp()
        capture("B9 Barras y equipo")
        XCUIDevice.shared.press(.home)
        let home = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let icon = home.icons["Compras"]
        XCTAssertTrue(icon.waitForExistence(timeout: 8))
        let stable = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: icon)
        XCTAssertEqual(XCTWaiter.wait(for: [stable], timeout: 8), .completed)
        capture("Inicio icono Compras")
        app.terminate()
        app.launchArguments = ["--ui-testing", "--ui-dark"]
        app.launch()
        XCTAssertTrue(app.buttons["Crear cuenta"].waitForExistence(timeout: 10))
        capture("B1 Login oscuro")
    }
    @MainActor func testLoginAppearanceAndInvalidCredentials() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        func capture(_ name: String) {
            let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
            attachment.name = name; attachment.lifetime = .keepAlways; add(attachment)
        }
        app.launchArguments = ["--ui-testing"]
        app.launch()
        XCTAssertTrue(app.buttons["Crear cuenta"].waitForExistence(timeout: 10))
        capture("B1 Login")
        app.terminate()
        app.launchArguments = ["--ui-testing", "--ui-dark"]
        app.launch()
        XCTAssertTrue(app.buttons["Crear cuenta"].waitForExistence(timeout: 10))
        capture("B1 Login oscuro")
        app.textFields["login.usuario"].tap()
        app.textFields["login.usuario"].typeText("usuario-inexistente")
        app.secureTextFields["login.clave"].tap()
        app.secureTextFields["login.clave"].typeText("incorrecta")
        app.buttons["login.ingresar"].tap()
        XCTAssertTrue(app.staticTexts["Usuario o clave incorrectos"].waitForExistence(timeout: 10))
        capture("B1 Error generico")
    }

    @MainActor func testPersistentRelaunchWithVerifiedNavigation() throws {
        print("QA-PERSISTENCE-VERIFIED-NAV-20261118")
        // El script y esta guarda evitan crear cuentas persistentes en dispositivos personales.
        let deviceName = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] ?? ""
        guard deviceName.contains("Compras Rediseño QA") else { throw XCTSkip("Persistencia real requiere el simulador Compras Rediseño QA; dispositivo: " + deviceName) }
        print("Persistencia aislada en: " + deviceName)
        continueAfterFailure = false
        let app = XCUIApplication(), suffix = String(UUID().uuidString.prefix(6)).lowercased()
        let supervisor = "qa-sup-" + suffix, buyer = "qa-buy-" + suffix
        let product = "QA Producto " + suffix, supplier = "QA Proveedor " + suffix
        func field(_ label: String, _ text: String, secure: Bool = false) {
            let control = secure ? app.secureTextFields[label] : app.textFields[label]
            if app.buttons["Listo"].exists { app.buttons["Listo"].tap() }
            for _ in 0..<6 { if control.exists && control.isHittable { break }; app.swipeUp() }
            XCTAssertTrue(control.waitForExistence(timeout: 8)); control.coordinate(withNormalizedOffset: CGVector(dx: 0.85, dy: 0.5)).tap(); control.typeText(text)
        }
        func register(_ name: String, supervisor: Bool) {
            app.buttons["Crear cuenta"].tap()
            field("Nombre completo", name); field("Usuario único", name)
            field("Clave · mínimo 6 caracteres", "SoloQA123", secure: true); field("Confirmar clave", "SoloQA123", secure: true)
            app.swipeUp()
            if supervisor { app.segmentedControls.buttons["Supervisor"].tap() }
            app.buttons["Registrarme"].tap()
            XCTAssertTrue(app.tabBars.buttons["Productos"].waitForExistence(timeout: 10))
        }
        func logout() { app.buttons["Cuenta y cerrar sesión"].firstMatch.tap(); app.buttons["Cerrar sesión"].tap() }
        app.launchArguments = []; app.launch()
        register(supervisor, supervisor: true)
        app.tabBars.buttons["Productos"].tap(); app.buttons["Añadir producto"].tap()
        field("Nombre", product); field("Categoría", "QA persistencia")
        app.buttons["Guardar"].tap()
        app.tabBars.buttons["Proveedores"].tap(); app.buttons["Añadir proveedor"].tap()
        field("Nombre o razón social", supplier); field("RUC", "20999999999")
        app.buttons["Guardar"].tap()
        logout(); register(buyer, supervisor: false)
        app.tabBars.buttons["Compra"].tap()
        app.descendants(matching: .any).matching(identifier: "compra.proveedor").firstMatch.tap(); app.buttons[supplier].tap()
        app.descendants(matching: .any).matching(identifier: "compra.producto").firstMatch.tap(); app.buttons[product].tap()
        field("Cantidad", "2"); field("Costo unitario (S/)", "120")
        app.buttons["Listo"].tap(); app.swipeUp()
        app.segmentedControls.buttons["Crédito 30 días"].tap()
        let save = app.buttons["Registrar compra"]
        for _ in 0..<5 { if save.isHittable { break }; app.swipeUp() }; save.tap()
        XCTAssertTrue(app.alerts["Compra guardada"].waitForExistence(timeout: 8)); app.alerts.buttons["Aceptar"].tap()
        app.terminate(); app.launch()
        XCTAssertTrue(app.buttons["Crear cuenta"].waitForExistence(timeout: 10))
        field("login.usuario", buyer); field("login.clave", "SoloQA123", secure: true); app.buttons["login.ingresar"].tap()
        XCTAssertTrue(app.tabBars.buttons["Productos"].waitForExistence(timeout: 10))
        let history = app.tabBars.buttons["Mis compras"]
        XCTAssertTrue(history.waitForExistence(timeout: 10))
        for _ in 0..<3 {
            history.tap()
            if app.navigationBars["Mis compras"].waitForExistence(timeout: 3) { break }
        }
        XCTAssertTrue(app.navigationBars["Mis compras"].exists)
        let persistedRow = app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", supplier)).firstMatch
        for _ in 0..<6 { if persistedRow.exists && persistedRow.isHittable { break }; app.swipeUp() }
        XCTAssertTrue(persistedRow.waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Aprobada'")).firstMatch.exists)
        let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); screenshot.name = "Persistencia real tras reiniciar QA"; screenshot.lifetime = .keepAlways; add(screenshot)
        app.terminate()
    }

}
