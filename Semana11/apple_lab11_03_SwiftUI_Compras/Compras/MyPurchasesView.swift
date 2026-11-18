import SwiftUI
import SwiftData

struct MyPurchasesView: View {
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Compra.fecha, order: .reverse) private var purchases: [Compra]
    @State private var filter = "Todas"
    var visible: [Compra] {
        purchases.filter { $0.comprador?.persistentModelID == sesion.usuario?.persistentModelID && (filter == "Todas" || $0.estado == (filter == "Pendientes" ? "Pendiente" : "Rechazada")) }
    }
    var body: some View {
        Screen(title: "Mis compras") {
            List {
                Section { VisualHeader(eyebrow: "Tu actividad", title: "Cada compra, en seguimiento", subtitle: "Consulta el estado de tus solicitudes y la respuesta del supervisor.", symbol: "receipt") }.floatingRow()
                Section { Picker("Estado", selection: $filter) { ForEach(["Todas", "Pendientes", "Rechazadas"], id: \.self) { Text($0) } }.pickerStyle(.segmented).padding(.vertical, 8) }.floatingRow()
                Section {
                    if visible.isEmpty { EmptyPanel(title: "Sin compras", message: "Aquí verás tus compras y la respuesta del supervisor.", symbol: "receipt").floatingRow() }
                    ForEach(visible) { c in
                        VStack(alignment: .leading, spacing: 6) {
                            PurchaseRow(c: c)
                            Text(c.alCredito ? "Crédito 30 días · \(c.pagada ? "Pagada" : c.estado == "Aprobada" ? "Por pagar" : "Sin deuda")" : "Contado")
                                .font(.caption).foregroundStyle(.secondary)
                        }.surfaceCard(accent: c.estado == "Rechazada" ? Brand.danger : Brand.green).floatingRow()
                    }
                }
            }.catalogBackground()
        }
    }
}
