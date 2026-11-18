import SwiftUI
import SwiftData

enum Brand {
    static let green = Color(red: 8/255, green: 127/255, blue: 118/255)
    static let turquoise = Color(red: 25/255, green: 173/255, blue: 156/255)
    static let amber = Color(red: 240/255, green: 181/255, blue: 76/255)
    static func money(_ value: Double) -> String { "S/ " + value.formatted(.number.precision(.fractionLength(2))) }
}
struct Logo: View {
    var body: some View {
        Image(systemName: "shippingbox.fill").font(.system(size: 42, weight: .semibold))
            .foregroundStyle(.white).frame(width: 88, height: 88)
            .background(LinearGradient(colors: [Brand.green, Brand.turquoise], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 24))
            .accessibilityHidden(true)
    }
}
struct StatusBadge: View {
    let text: String
    var color: Color { text == "Rechazada" || text == "VENCIDA" ? .red : text == "Pendiente" || text == "Por pagar" ? .orange : Brand.green }
    var body: some View { Text(text).font(.caption.weight(.semibold)).foregroundStyle(color).padding(.horizontal, 9).padding(.vertical, 5).background(color.opacity(0.12), in: Capsule()) }
}
struct Metric: View {
    let title: String
    let value: String
    let symbol: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: symbol).font(.subheadline).foregroundStyle(.secondary)
            Text(value).font(.title2.bold()).monospacedDigit().minimumScaleFactor(0.65)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(16).background(.background, in: RoundedRectangle(cornerRadius: 16))
    }
}
struct AccountMenu: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        Menu {
            if let u = sesion.usuario {
                Text(u.nombre); Text("@\(u.usuario) · \(u.rol)")
                Button("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) { sesion.salir() }
            }
        } label: { Image(systemName: "person.crop.circle.fill").font(.title2).foregroundStyle(Brand.green).frame(minWidth: 44, minHeight: 44) }
        .accessibilityLabel("Cuenta y cerrar sesión")
    }
}
struct Screen<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    var body: some View {
        NavigationStack { content.navigationTitle(title).appToolbar { ToolbarItem(placement: .topBarTrailing) { AccountMenu() } } }
    }
}
struct ErrorNotice: View {
    let text: String
    var body: some View { Label(text, systemImage: "exclamationmark.circle.fill").foregroundStyle(.red).font(.callout).accessibilityAddTraits(.updatesFrequently) }
}
struct PurchaseRow: View {
    let c: Compra
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack { Text(c.proveedor?.nombre ?? "Sin proveedor").font(.headline); Spacer(); StatusBadge(text: c.estado) }
            Text("\(c.producto?.nombre ?? "Sin producto") · \(c.cantidad) unidades").foregroundStyle(.secondary)
            HStack { Text(c.fecha, style: .date); Spacer(); Text(Brand.money(c.total)).bold().monospacedDigit() }.font(.subheadline)
            if let motivo = c.motivoRechazo { Label(motivo, systemImage: "text.bubble").font(.callout).foregroundStyle(.red) }
        }.padding(.vertical, 8)
    }
}

extension View {
    func appToolbar<T: ToolbarContent>(@ToolbarContentBuilder content: () -> T) -> some View {
        toolbar(content: content)
    }
}
