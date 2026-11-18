import SwiftUI
import SwiftData
import UIKit

enum Brand {
    static let green = Color(red: 8/255, green: 127/255, blue: 118/255)
    static let turquoise = Color(red: 25/255, green: 173/255, blue: 156/255)
    static let background = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? .systemGroupedBackground : UIColor(red: 246/255, green: 248/255, blue: 250/255, alpha: 1)
    })
    static let card = Color(uiColor: .secondarySystemGroupedBackground)
    static let ink = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? .label : UIColor(red: 36/255, green: 52/255, blue: 73/255, alpha: 1)
    })
    static let emphasis = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 25/255, green: 173/255, blue: 156/255, alpha: 1) : UIColor(red: 8/255, green: 127/255, blue: 118/255, alpha: 1)
    })
    static let warning = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 240/255, green: 181/255, blue: 76/255, alpha: 1) : UIColor(red: 128/255, green: 84/255, blue: 0, alpha: 1)
    })
    static let danger = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 1, green: 0.62, blue: 0.58, alpha: 1) : UIColor(red: 0.70, green: 0.10, blue: 0.08, alpha: 1)
    })
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
    var color: Color { text == "Rechazada" || text == "VENCIDA" ? Brand.danger : text == "Pendiente" || text == "Por pagar" ? Brand.warning : Brand.emphasis }
    var body: some View { Text(text).font(.caption.weight(.semibold)).foregroundStyle(color).padding(.horizontal, 9).padding(.vertical, 5).background(color.opacity(0.12), in: Capsule()) }
}
struct Metric: View {
    let title: String
    let value: String
    let symbol: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: symbol).font(.subheadline).foregroundStyle(.secondary)
            Text(value).foregroundStyle(Brand.ink).font(.title2.bold()).monospacedDigit().minimumScaleFactor(0.65)
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
    var body: some View { Label(text, systemImage: "exclamationmark.circle.fill").foregroundStyle(Brand.danger).font(.callout).accessibilityAddTraits(.updatesFrequently) }
}
struct PurchaseRow: View {
    let c: Compra
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                IconTile(symbol: "doc.text", color: c.estado == "Rechazada" ? Brand.danger : c.estado == "Pendiente" ? Brand.warning : Brand.emphasis)
                VStack(alignment: .leading, spacing: 5) {
                    Text(c.proveedor?.nombre ?? "Sin proveedor").font(.headline).foregroundStyle(Brand.ink)
                    Text(c.producto?.nombre ?? "Sin producto").font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
            }
            HStack { StatusBadge(text: c.estado); Spacer(); Text("\(c.cantidad) unidades").font(.caption.bold()).foregroundStyle(.secondary) }
            Divider()
            HStack(alignment: .bottom) {
                Label { Text(c.fecha, style: .date) } icon: { Image(systemName: "calendar") }.font(.caption).foregroundStyle(.secondary)
                Spacer()
                Text(Brand.money(c.total)).font(.title3.bold()).monospacedDigit().foregroundStyle(Brand.ink)
            }
            if let motivo = c.motivoRechazo { Label(motivo, systemImage: "text.bubble").font(.callout).foregroundStyle(Brand.danger).padding(12).frame(maxWidth: .infinity, alignment: .leading).background(Brand.danger.opacity(0.06), in: RoundedRectangle(cornerRadius: 12)) }
        }.padding(.vertical, 4)
    }
}

extension View {
    func appToolbar<T: ToolbarContent>(@ToolbarContentBuilder content: () -> T) -> some View {
        toolbar(content: content)
    }
}

// Presentación compartida: no consulta ni modifica modelos.
struct SurfaceCard: ViewModifier {
    var accent: Color = Brand.green
    func body(content: Content) -> some View {
        content.padding(20).frame(maxWidth: .infinity, alignment: .leading)
            .background(Brand.card, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(accent.opacity(0.10), lineWidth: 1))
            .shadow(color: .black.opacity(0.045), radius: 12, x: 0, y: 5)
    }
}
struct VisualHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String
    let symbol: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(eyebrow.uppercased()).font(.caption.bold()).tracking(1.5)
                Spacer()
                Image(systemName: symbol).font(.title2).accessibilityHidden(true)
            }.foregroundStyle(Brand.emphasis)
            Text(title).font(.title2.bold()).foregroundStyle(Brand.ink)
            Text(subtitle).font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
        }.modifier(SurfaceCard())
    }
}
struct IconTile: View {
    let symbol: String
    var color: Color = Brand.emphasis
    var body: some View {
        Image(systemName: symbol).font(.title3.weight(.semibold)).foregroundStyle(color)
            .frame(width: 46, height: 46).background(color.opacity(0.10), in: RoundedRectangle(cornerRadius: 14)).accessibilityHidden(true)
    }
}
struct PrimaryActionStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.headline).foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(LinearGradient(colors: [Brand.green, Brand.green.opacity(0.88)], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 16))
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}
struct EmptyPanel: View {
    let title: String
    let message: String
    let symbol: String
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: symbol).font(.system(size: 36)).foregroundStyle(Brand.emphasis)
                .padding(22).background(Brand.emphasis.opacity(0.08), in: Circle())
            Text(title).font(.title3.bold()).foregroundStyle(Brand.ink)
            Text(message).font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }.frame(maxWidth: .infinity).padding(.vertical, 24).modifier(SurfaceCard())
    }
}
extension View {
    func surfaceCard(accent: Color = Brand.green) -> some View { modifier(SurfaceCard(accent: accent)) }
    func floatingRow() -> some View {
        listRowBackground(Color.clear).listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
    }
    func catalogBackground() -> some View {
        scrollContentBackground(.hidden).background(Brand.background).listStyle(.plain)
    }
}
