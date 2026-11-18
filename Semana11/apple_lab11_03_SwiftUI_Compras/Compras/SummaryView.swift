import SwiftUI
import SwiftData
import Charts

struct SummaryView: View {
    @Environment(Sesion.self) private var sesion
    @Query private var products: [Producto]
    @Query(sort: \Compra.fecha, order: .reverse) private var purchases: [Compra]
    @Query(sort: \Proveedor.nombre) private var suppliers: [Proveedor]
    var approved: [Compra] { purchases.filter { $0.estado == "Aprobada" } }
    var pending: [Compra] { purchases.filter { $0.estado == "Pendiente" } }
    var totals: [(supplier: Proveedor, total: Double)] {
        suppliers.map { p in (p, p.compras.filter { $0.estado == "Aprobada" }.reduce(0) { $0 + $1.total }) }.sorted { $0.total > $1.total }
    }
    var body: some View {
        Screen(title: "Resumen") {
            if sesion.supervisor {
                List {
                    Section {
                        Metric(title: "Valor del inventario", value: Brand.money(products.reduce(0) { $0 + Double($1.stock) * $1.costoPromedio }), symbol: "shippingbox.fill")
                        Metric(title: "Crédito fiscal · IGV aprobado", value: Brand.money(approved.reduce(0) { $0 + $1.igv }), symbol: "doc.text")
                        Metric(title: "Cuentas por pagar", value: Brand.money(purchases.filter(\.esDeuda).reduce(0) { $0 + $1.total }), symbol: "calendar.badge.clock")
                        Metric(title: "Por aprobar · \(pending.count) compras", value: Brand.money(pending.reduce(0) { $0 + $1.total }), symbol: "checkmark.shield")
                    }.listRowInsets(EdgeInsets())
                    Section("Total comprado por proveedor") {
                        if totals.allSatisfy({ $0.total == 0 }) { ContentUnavailableView("Aún sin compras aprobadas", systemImage: "chart.bar.xaxis") }
                        else {
                            Chart(totals, id: \.supplier.persistentModelID) { row in
                                BarMark(x: .value("Total", row.total), y: .value("Proveedor", row.supplier.nombre)).foregroundStyle(Brand.green)
                            }.frame(height: CGFloat(max(160, totals.count * 48))).accessibilityLabel("Totales de compras aprobadas por proveedor")
                            ForEach(totals, id: \.supplier.persistentModelID) { row in LabeledContent(row.supplier.nombre, value: Brand.money(row.total)).font(.subheadline) }
                        }
                    }
                    Section("Todas las compras · \(purchases.count)") {
                        if purchases.isEmpty { Text("Las operaciones de tu equipo aparecerán aquí.").foregroundStyle(.secondary) }
                        ForEach(purchases) { c in
                            VStack(alignment: .leading) {
                                PurchaseRow(c: c)
                                Text("Solicitó: \(c.comprador?.nombre ?? "") · \(c.alCredito ? "Crédito" : "Contado")\(c.pagada ? " · Pagada" : "")").font(.caption).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            } else { ContentUnavailableView("Acceso de supervisor", systemImage: "lock") }
        }
    }
}
