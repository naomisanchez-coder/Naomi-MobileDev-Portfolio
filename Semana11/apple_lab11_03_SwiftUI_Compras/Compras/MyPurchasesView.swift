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
                Section { Picker("Estado", selection: $filter) { ForEach(["Todas", "Pendientes", "Rechazadas"], id: \.self) { Text($0) } }.pickerStyle(.segmented) }
                Section {
                    if visible.isEmpty { ContentUnavailableView("Sin compras", systemImage: "receipt", description: Text("Aquí verás tus compras y la respuesta del supervisor.")) }
                    ForEach(visible) { c in
                        VStack(alignment: .leading, spacing: 6) {
                            PurchaseRow(c: c)
                            Text(c.alCredito ? "Crédito 30 días · \(c.pagada ? "Pagada" : c.estado == "Aprobada" ? "Por pagar" : "Sin deuda")" : "Contado")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}
