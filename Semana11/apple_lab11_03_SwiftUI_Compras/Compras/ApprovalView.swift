import SwiftUI
import SwiftData

struct ApprovalView: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" }, sort: \Compra.fecha) private var pending: [Compra]
    @State private var rejecting: Compra?
    @State private var approving: Compra?
    @State private var reason = ""
    @State private var error: String?
    var body: some View {
        Screen(title: "Aprobar") {
            List {
                if !sesion.supervisor { ContentUnavailableView("Acceso de supervisor", systemImage: "lock") }
                else {
                    if pending.isEmpty { ContentUnavailableView("Todo al día", systemImage: "checkmark.shield", description: Text("No hay compras pendientes de aprobación.")) }
                    ForEach(pending) { c in
                        Section {
                            PurchaseRow(c: c)
                            Label("Solicitó: \(c.comprador?.nombre ?? "Sin comprador")", systemImage: "person").font(.subheadline)
                            Text("\(c.cantidad) × \(Brand.money(c.costoUnitario)) · IGV \(Brand.money(c.igv))").font(.caption).foregroundStyle(.secondary)
                            Text(c.alCredito ? "Crédito · vence \(c.vence.formatted(date: .abbreviated, time: .omitted))" : "Contado").font(.caption)
                            if let p = c.producto, let preview = try? ComprasService.projection(p, cantidad: c.cantidad, costo: c.costoUnitario) {
                                VStack(alignment: .leading, spacing: 7) {
                                    Label("Si apruebas", systemImage: "arrow.up.right.circle").font(.subheadline.bold())
                                    Text("Stock: \(p.stock) → \(preview.stock)")
                                    Text("Costo: \(Brand.money(p.costoPromedio)) → \(Brand.money(preview.costo))")
                                }.font(.callout).foregroundStyle(Brand.emphasis).padding(.vertical, 8)
                            }
                            HStack {
                                Button("Rechazar", role: .destructive) { reason = ""; rejecting = c }.buttonStyle(.bordered)
                                Spacer()
                                Button("Aprobar") { approving = c }.buttonStyle(.borderedProminent).accessibilityIdentifier("aprobar.compra")
                            }
                        }
                    }
                }
                if let error { ErrorNotice(text: error) }
            }
            .alert("Rechazar compra", isPresented: Binding(get: { rejecting != nil }, set: { if !$0 { rejecting = nil } })) {
                TextField("Motivo obligatorio", text: $reason)
                Button("Cancelar", role: .cancel) { rejecting = nil }
                Button("Rechazar", role: .destructive) { if let rejecting { perform { try $0.reject(rejecting, motivo: reason) } }; rejecting = nil }
            } message: { Text("El comprador podrá consultar este motivo.") }
            .confirmationDialog("¿Aprobar la compra y actualizar el inventario?", isPresented: Binding(get: { approving != nil }, set: { if !$0 { approving = nil } }), titleVisibility: .visible) {
                Button("Aprobar compra") { if let approving { perform { try $0.approve(approving) } }; approving = nil }
            }
        }
    }
    func perform(_ operation: (ComprasService) throws -> Void) { do { try operation(ComprasService(context, sesion)); error = nil } catch { self.error = error.localizedDescription } }
}
