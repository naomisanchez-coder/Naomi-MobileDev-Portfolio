import SwiftUI
import SwiftData

struct ProductsView: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Producto.nombre) private var products: [Producto]
    @State private var search = ""
    @State private var showEditor = false
    @State private var editing: Producto?
    @State private var deleting: Producto?
    @State private var error: String?
    var filtered: [Producto] { products.filter { search.isEmpty || $0.nombre.localizedStandardContains(search) || $0.categoria.localizedStandardContains(search) } }
    var body: some View {
        Screen(title: "Productos") {
            List {
                Section { VisualHeader(eyebrow: "Inventario", title: "Productos que mueven tu negocio", subtitle: "Consulta existencias, costos y valoración en un solo lugar.", symbol: "shippingbox.fill") }.floatingRow()
                Section { Metric(title: "Valor del inventario", value: Brand.money(products.reduce(0) { $0 + Double($1.stock) * $1.costoPromedio }), symbol: "shippingbox") }.floatingRow()
                Section("Catálogo · \(filtered.count) productos") {
                    if filtered.isEmpty { ContentUnavailableView("Sin productos", systemImage: "shippingbox", description: Text(sesion.supervisor ? "Añade un producto con el botón +." : "El supervisor administra el catálogo.")) }
                    ForEach(filtered) { p in
                        Button { if sesion.supervisor { editing = p; showEditor = true } } label: {
                            ProductRow(product: p).surfaceCard(accent: p.stock < 10 ? Brand.warning : Brand.green)
                        }.buttonStyle(.plain).floatingRow().deleteDisabled(!sesion.supervisor).accessibilityHint(sesion.supervisor ? "Editar producto" : "Solo consulta")
                    }.onDelete(perform: requestDelete)
                }
                if let error { Section { ErrorNotice(text: error) } }
            }.catalogBackground().searchable(text: $search, prompt: "Producto o categoría")
                .appToolbar { addToolbar }
                .sheet(isPresented: $showEditor) { ProductEditor(product: editing) }
                .confirmationDialog("¿Eliminar este producto?", isPresented: Binding(get: { deleting != nil }, set: { if !$0 { deleting = nil } }), titleVisibility: .visible) {
                    Button("Eliminar", role: .destructive) { if let deleting { do { try ComprasService(context, sesion).delete(deleting) } catch { self.error = error.localizedDescription } }; deleting = nil }
                }
        }
    }
    @ToolbarContentBuilder private var addToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if sesion.supervisor { Button { editing = nil; showEditor = true } label: { Image(systemName: "plus") }.accessibilityLabel("Añadir producto") }
        }
    }
    func requestDelete(_ offsets: IndexSet) { if sesion.supervisor, let i = offsets.first { deleting = filtered[i] } }
}
struct ProductEditor: View {
    let product: Producto?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @State private var nombre = ""
    @State private var categoria = ""
    @State private var stock = "0"
    @State private var costo = "0"
    @State private var error: String?
    var body: some View {
        NavigationStack {
            Form {
                Section("Producto") { TextField("Nombre", text: $nombre); TextField("Categoría", text: $categoria) }
                Section { TextField("Stock inicial", text: $stock).keyboardType(.numberPad); TextField("Costo promedio (S/)", text: $costo).keyboardType(.decimalPad) }
                header: { Text("Inventario") }
                if let error { ErrorNotice(text: error) }
            }.scrollContentBackground(.hidden).background(Brand.background).navigationTitle(product == nil ? "Nuevo producto" : "Editar producto").navigationBarTitleDisplayMode(.inline)
                .appToolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                    ToolbarItem(placement: .confirmationAction) { Button("Guardar") {
                        do {
                            guard let s = Int(stock), let c = Double(costo.replacingOccurrences(of: ",", with: ".")) else { throw AppError("Ingresa stock entero y costo numérico.") }
                            try ComprasService(context, sesion).product(product, nombre: nombre, categoria: categoria, stock: s, costo: c); dismiss()
                        } catch { self.error = error.localizedDescription }
                    } }
                }
                .onAppear { if let product { nombre = product.nombre; categoria = product.categoria; stock = String(product.stock); costo = String(product.costoPromedio) } }
        }.tint(Brand.green)
    }
}

struct ProductRow: View {
    let product: Producto
    var stockColor: Color { product.stock == 0 ? Brand.danger : product.stock < 10 ? Brand.warning : Brand.emphasis }
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 12) {
                IconTile(symbol: "shippingbox.fill")
                VStack(alignment: .leading, spacing: 5) {
                    Text(product.nombre).font(.headline).foregroundStyle(Brand.ink)
                    Text(product.categoria).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer(minLength: 4)
            }
            HStack {
                Label("\(product.stock) u. · \(product.stock == 0 ? "Sin stock" : product.stock < 10 ? "Stock bajo" : "Disponible")", systemImage: product.stock < 10 ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
                    .font(.caption.bold()).foregroundStyle(stockColor)
                Spacer()
            }
            Divider()
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) { Text("Costo promedio").font(.caption).foregroundStyle(.secondary); Text(Brand.money(product.costoPromedio)).font(.headline).monospacedDigit() }
                Spacer()
                VStack(alignment: .trailing, spacing: 5) { Text("Valor del inventario").font(.caption).foregroundStyle(.secondary); Text(Brand.money(Double(product.stock) * product.costoPromedio)).font(.headline).monospacedDigit().foregroundStyle(Brand.emphasis) }
            }
        }.foregroundStyle(Brand.ink)
    }
}
