import SwiftUI
import SwiftData

struct SuppliersView: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Proveedor.nombre) private var suppliers: [Proveedor]
    @State private var search = ""
    @State private var editing: Proveedor?
    @State private var showEditor = false
    @State private var deleting: Proveedor?
    @State private var error: String?
    var filtered: [Proveedor] { suppliers.filter { search.isEmpty || $0.nombre.localizedStandardContains(search) || $0.ruc.localizedStandardContains(search) } }
    var body: some View {
        Screen(title: "Proveedores") {
            List {
                Section("Red de abastecimiento") {
                    if filtered.isEmpty { ContentUnavailableView("Sin proveedores", systemImage: "building.2", description: Text("Los proveedores aparecerán aquí cuando el supervisor los registre.")) }
                    ForEach(filtered) { p in
                        Button { if sesion.supervisor { editing = p; showEditor = true } } label: {
                            SupplierRow(supplier: p)
                        }.buttonStyle(.plain).deleteDisabled(!sesion.supervisor)
                    }.onDelete(perform: requestDelete)
                }
                if let error { ErrorNotice(text: error) }
                Section { Text("Los totales incluyen únicamente compras aprobadas. Una compra pendiente o rechazada no genera deuda.").font(.footnote).foregroundStyle(.secondary) }
            }.searchable(text: $search, prompt: "Nombre o RUC")
                .appToolbar { addToolbar }
                .sheet(isPresented: $showEditor) { SupplierEditor(supplier: editing) }
                .confirmationDialog("¿Eliminar este proveedor?", isPresented: Binding(get: { deleting != nil }, set: { if !$0 { deleting = nil } }), titleVisibility: .visible) {
                    Button("Eliminar", role: .destructive) { if let deleting { do { try ComprasService(context, sesion).delete(deleting) } catch { self.error = error.localizedDescription } }; deleting = nil }
                }
        }
    }
    @ToolbarContentBuilder private var addToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if sesion.supervisor { Button { editing = nil; showEditor = true } label: { Image(systemName: "plus") }.accessibilityLabel("Añadir proveedor") }
        }
    }
    func requestDelete(_ offsets: IndexSet) { if sesion.supervisor, let i = offsets.first { deleting = filtered[i] } }
}
struct SupplierEditor: View {
    let supplier: Proveedor?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @State private var nombre = ""
    @State private var ruc = ""
    @State private var error: String?
    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del proveedor") { TextField("Nombre o razón social", text: $nombre); TextField("RUC", text: $ruc).keyboardType(.numberPad) }
                if let error { ErrorNotice(text: error) }
            }.navigationTitle(supplier == nil ? "Nuevo proveedor" : "Editar proveedor").navigationBarTitleDisplayMode(.inline)
                .appToolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                    ToolbarItem(placement: .confirmationAction) { Button("Guardar") {
                        do { try ComprasService(context, sesion).supplier(supplier, nombre: nombre, ruc: ruc); dismiss() }
                        catch { self.error = error.localizedDescription }
                    } }
                }.onAppear { if let supplier { nombre = supplier.nombre; ruc = supplier.ruc } }
        }.tint(Brand.green)
    }
}

struct SupplierRow: View {
    let supplier: Proveedor
    var total: Double { supplier.compras.filter { $0.estado == "Aprobada" }.reduce(0) { $0 + $1.total } }
    var hasDebt: Bool { supplier.compras.contains { $0.esDeuda } }
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack {
                Label(supplier.nombre, systemImage: "building.2.fill").font(.headline)
                Spacer()
                StatusBadge(text: hasDebt ? "Por pagar" : "Al día")
            }
            Text("RUC · \(supplier.ruc)").font(.subheadline).foregroundStyle(.secondary)
            Text("Total comprado: \(Brand.money(total))").font(.subheadline).monospacedDigit()
        }.foregroundStyle(.primary).padding(.vertical, 8)
    }
}
