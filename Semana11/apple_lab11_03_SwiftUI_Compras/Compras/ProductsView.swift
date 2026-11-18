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
                Section { Metric(title: "Valor del inventario", value: Brand.money(products.reduce(0) { $0 + Double($1.stock) * $1.costoPromedio }), symbol: "shippingbox") }
                Section("Catálogo · \(filtered.count) productos") {
                    if filtered.isEmpty { ContentUnavailableView("Sin productos", systemImage: "shippingbox", description: Text(sesion.supervisor ? "Añade un producto con el botón +." : "El supervisor administra el catálogo.")) }
                    ForEach(filtered) { p in
                        Button { if sesion.supervisor { editing = p; showEditor = true } } label: {
                            ProductRow(product: p)
                        }.buttonStyle(.plain).deleteDisabled(!sesion.supervisor).accessibilityHint(sesion.supervisor ? "Editar producto" : "Solo consulta")
                    }.onDelete(perform: requestDelete)
                }
                if let error { Section { ErrorNotice(text: error) } }
            }.searchable(text: $search, prompt: "Producto o categoría")
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
                header: { Text("Inventario") } footer: { if !(product?.compras.isEmpty ?? true) { Text("Con compras registradas, stock y costo solo cambian mediante compras aprobadas.") } }
                    .disabled(!(product?.compras.isEmpty ?? true))
                if let error { ErrorNotice(text: error) }
            }.navigationTitle(product == nil ? "Nuevo producto" : "Editar producto").navigationBarTitleDisplayMode(.inline)
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
    var stockColor: Color { product.stock == 0 ? .red : product.stock < 10 ? .orange : Brand.green }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { Label(product.nombre, systemImage: "cube.box.fill").font(.headline); Spacer(); Text("\(product.stock) u.").font(.caption.bold()).foregroundStyle(stockColor) }
            HStack { Text(product.categoria); Spacer(); Text(Brand.money(product.costoPromedio)) }.font(.subheadline).foregroundStyle(.secondary)
            Text("Valor: \(Brand.money(Double(product.stock) * product.costoPromedio))").font(.caption).foregroundStyle(.secondary)
        }.padding(.vertical, 6).foregroundStyle(.primary)
    }
}
