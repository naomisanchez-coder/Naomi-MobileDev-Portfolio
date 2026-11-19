import SwiftUI
import SwiftData

struct PayablesView: View {
    @Environment(Sesion.self) private var sesion
    @Query(filter: #Predicate<Compra> { $0.estado == "Aprobada" && $0.alCredito }, sort: \Compra.vence) private var credits: [Compra]
    @State private var filter = "Pendientes"
    @State private var search = ""
    var body: some View {
        Screen(title: "Por pagar") {
            if sesion.supervisor {
                VStack(spacing: 0) {
                    VisualHeader(eyebrow: "Tesorería", title: "Tus compromisos, organizados", subtitle: "Revisa vencimientos y registra cada pago con confianza.", symbol: "calendar.badge.clock").padding(.horizontal, 16)
                    Picker("Estado de pago", selection: $filter) { ForEach(["Pendientes", "Vencidas", "Pagadas"], id: \.self) { Text($0) } }.pickerStyle(.segmented).padding()
                    PayablesList(filter: filter, search: search)
                }.background(Brand.background).searchable(text: $search, prompt: "Buscar proveedor")
                    .safeAreaInset(edge: .bottom) {
                        HStack { Text("Total por pagar").foregroundStyle(.secondary); Spacer(); Text(Brand.money(credits.filter(\.esDeuda).reduce(0) { $0 + $1.total })).bold().monospacedDigit() }
                            .padding().background(.regularMaterial)
                    }
            } else { ContentUnavailableView("Acceso de supervisor", systemImage: "lock") }
        }
    }
}
struct PayablesList: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @Environment(\.scenePhase) private var scenePhase
    @Query private var credits: [Compra]
    let search: String
    let filter: String
    @State private var now = Date.now
    @State private var paying: Compra?
    @State private var error: String?
    init(filter: String, search: String) {
        self.search = search; self.filter = filter
        let paid = filter == "Pagadas"
        _credits = Query(filter: #Predicate<Compra> { $0.estado == "Aprobada" && $0.alCredito && $0.pagada == paid }, sort: \Compra.vence)
    }
    var visible: [Compra] {
        credits.filter { (filter != "Vencidas" || $0.vencida(en: now)) && (search.isEmpty || ($0.proveedor?.nombre.localizedStandardContains(search) ?? false)) }
    }
    var body: some View {
        List {
            if visible.isEmpty { EmptyPanel(title: "Sin cuentas en este filtro", message: "Solo las compras aprobadas a crédito aparecen aquí.", symbol: "checkmark.circle").floatingRow() }
            ForEach(visible) { c in
                VStack(alignment: .leading, spacing: 8) {
                    HStack { Text(c.proveedor?.nombre ?? "Sin proveedor").font(.headline); Spacer(); Text(Brand.money(c.total)).bold().monospacedDigit() }
                    Text("\(c.producto?.nombre ?? "") · \(c.cantidad) unidades").font(.subheadline).foregroundStyle(.secondary)
                    HStack {
                        Text("Vence \(c.vence.formatted(date: .abbreviated, time: .omitted))").font(.caption)
                        Spacer()
                        StatusBadge(text: c.pagada ? "Pagada" : c.vencida(en: now) ? "VENCIDA" : "Por pagar")
                    }
                    if c.esDeuda { Button("Pagar compra") { paying = c }.buttonStyle(PrimaryActionStyle()) }
                }.surfaceCard(accent: c.vencida(en: now) ? Brand.danger : Brand.green).floatingRow().swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    if c.esDeuda && sesion.supervisor { Button("Pagar", systemImage: "checkmark") { paying = c }.tint(Brand.green) }
                }
            }
            if let error { ErrorNotice(text: error) }
        }.catalogBackground()
        .confirmationDialog("¿Confirmar el pago?", isPresented: Binding(get: { paying != nil }, set: { if !$0 { paying = nil } }), titleVisibility: .visible) {
            Button("Confirmar pago") { if let paying { do { try ComprasService(context, sesion).pay(paying); error = nil } catch { self.error = error.localizedDescription } }; paying = nil }
        } message: { Text(paying.map { "\($0.proveedor?.nombre ?? "") · \(Brand.money($0.total))" } ?? "") }
        .onAppear { now = .now }
        .onChange(of: scenePhase) { _, phase in if phase == .active { now = .now } }
        .task { while !Task.isCancelled { now = .now; try? await Task.sleep(for: .seconds(60)) } }
    }
}
