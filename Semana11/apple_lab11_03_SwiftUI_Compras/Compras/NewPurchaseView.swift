import SwiftUI
import SwiftData

struct NewPurchaseView: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Proveedor.nombre) private var suppliers: [Proveedor]
    @Query(sort: \Producto.nombre) private var products: [Producto]
    @State private var supplierID: PersistentIdentifier?
    @State private var productID: PersistentIdentifier?
    @State private var quantity = ""
    @State private var cost = ""
    @State private var credit = false
    @State private var error: String?
    @State private var success = false
    @State private var saving = false
    @FocusState private var inputFocused: Bool
    var amounts: (subtotal: Double, igv: Double, total: Double)? { try? ComprasService.amounts(cantidad: Int(quantity) ?? 0, costo: Double(cost.replacingOccurrences(of: ",", with: ".")) ?? 0) }
    var body: some View {
        Screen(title: "Nueva compra") {
            Form {
                Section { VisualHeader(eyebrow: "Nueva operación", title: "Planifica tu abastecimiento", subtitle: sesion.usuario?.nombre ?? "", symbol: "cart.badge.plus") }.floatingRow()
                Section("Abastecimiento") {
                    Picker("Proveedor", selection: $supplierID) {
                        Text("Selecciona un proveedor").tag(nil as PersistentIdentifier?)
                        ForEach(suppliers) { Text($0.nombre).tag(Optional($0.persistentModelID)) }
                    }
                    .accessibilityIdentifier("compra.proveedor")
                    Picker("Producto", selection: $productID) {
                        Text("Selecciona un producto").tag(nil as PersistentIdentifier?)
                        ForEach(products) { Text($0.nombre).tag(Optional($0.persistentModelID)) }
                    }
                    .accessibilityIdentifier("compra.producto")
                    LabeledContent("Cantidad") { TextField("Cantidad", text: $quantity).keyboardType(.numberPad).multilineTextAlignment(.trailing).focused($inputFocused) }
                    LabeledContent("Costo unitario") { TextField("Costo unitario (S/)", text: $cost).keyboardType(.decimalPad).multilineTextAlignment(.trailing).focused($inputFocused) }
                }
                Section("Condición de pago") {
                    Picker("Pago", selection: $credit) { Text("Contado").tag(false); Text("Crédito 30 días").tag(true) }.pickerStyle(.segmented)
                    if credit { Text("Vence 30 días calendario después del registro.").font(.footnote).foregroundStyle(.secondary) }
                }
                Section("Resumen de la compra") {
                    VStack(spacing: 16) {
                        HStack { Label("Subtotal", systemImage: "receipt"); Spacer(); Text(Brand.money(amounts?.subtotal ?? 0)).monospacedDigit() }
                        HStack { Text("IGV 18 %"); Spacer(); Text(Brand.money(amounts?.igv ?? 0)).monospacedDigit() }.foregroundStyle(.secondary)
                        Divider()
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Total").font(.subheadline.bold())
                            Text(Brand.money(amounts?.total ?? 0)).font(.largeTitle.bold()).monospacedDigit().foregroundStyle(Brand.emphasis).minimumScaleFactor(0.7)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }.surfaceCard()
                }.floatingRow()
                if let a = amounts, ComprasService.needsApproval(total: a.total) {
                    Section { Label("Desde S/ 5 000 requiere aprobación. Hasta entonces no cambia el inventario ni genera deuda.", systemImage: "exclamationmark.shield").foregroundStyle(Brand.warning).font(.callout).surfaceCard(accent: Brand.amber) }.floatingRow()
                }
                if suppliers.isEmpty || products.isEmpty { Section { Text("Un supervisor debe registrar proveedores y productos antes de realizar una compra.").foregroundStyle(.secondary) } }
                if let error { Section { ErrorNotice(text: error) } }
                Section {
                    Button((amounts?.total ?? 0) >= 5000 ? "Enviar a aprobación" : "Registrar compra", action: submit)
                        .buttonStyle(PrimaryActionStyle()).frame(maxWidth: .infinity).disabled(saving || amounts == nil || supplierID == nil || productID == nil)
                }
            }.scrollContentBackground(.hidden).background(Brand.background).scrollDismissesKeyboard(.immediately)
            .appToolbar { ToolbarItemGroup(placement: .keyboard) { Spacer(); Button("Listo") { inputFocused = false } } }
            .alert("Compra guardada", isPresented: $success) { Button("Aceptar", role: .cancel) {} } message: { Text("Puedes consultar su estado en Mis compras.") }
        }
    }
    func submit() {
        guard !saving else { return }; saving = true; defer { saving = false }
        do {
            guard let supplier = suppliers.first(where: { $0.persistentModelID == supplierID }), let product = products.first(where: { $0.persistentModelID == productID }),
                  let q = Int(quantity), let c = Double(cost.replacingOccurrences(of: ",", with: ".")) else { throw AppError("Revisa los datos de la compra.") }
            _ = try ComprasService(context, sesion).registerPurchase(proveedor: supplier, producto: product, cantidad: q, costo: c, credito: credit)
            quantity = ""; cost = ""; error = nil; success = true
        } catch { self.error = error.localizedDescription }
    }
}
