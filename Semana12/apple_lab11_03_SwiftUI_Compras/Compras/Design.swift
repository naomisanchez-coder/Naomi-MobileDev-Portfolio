import SwiftUI
import SwiftData
import UIKit

enum Brand {
    static let green = Color(red: 31/255, green: 73/255, blue: 151/255)
    static let violet = Color(red: 111/255, green: 91/255, blue: 196/255)
    static let coral = Color(red: 245/255, green: 130/255, blue: 102/255)
    static let turquoise = Color(red: 35/255, green: 204/255, blue: 191/255)
    static let background = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 15/255, green: 23/255, blue: 40/255, alpha: 1) : UIColor(red: 243/255, green: 246/255, blue: 253/255, alpha: 1)
    })
    static let card = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 25/255, green: 36/255, blue: 57/255, alpha: 1) : .white
    })
    static let ink = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? .label : UIColor(red: 36/255, green: 52/255, blue: 73/255, alpha: 1)
    })
    static let emphasis = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark ? UIColor(red: 93/255, green: 219/255, blue: 208/255, alpha: 1) : UIColor(red: 26/255, green: 78/255, blue: 155/255, alpha: 1)
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
    private var tone: Color { symbol.contains("calendar") ? Brand.warning : symbol.contains("doc") ? Brand.violet : Brand.emphasis }
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            IconTile(symbol: symbol, color: tone)
            Text(title).font(.caption.weight(.medium)).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
            Text(value).foregroundStyle(Brand.ink).font(.title2.bold()).monospacedDigit().minimumScaleFactor(0.65)
        }.frame(maxWidth: .infinity, alignment: .leading).surfaceCard(accent: tone)
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
        } label: { Text(String(sesion.usuario?.nombre.prefix(1) ?? "")).font(.headline.bold()).foregroundStyle(Brand.emphasis).frame(width: 44, height: 44).background(Brand.card, in: Circle()).overlay(Circle().stroke(Brand.emphasis.opacity(0.18), lineWidth: 1)) }
        .accessibilityLabel("Cuenta y cerrar sesión")
    }
}
struct Screen<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    var body: some View {
        NavigationStack { content.background(Brand.background).navigationTitle(title).toolbarBackground(Brand.background, for: .navigationBar).appToolbar { ToolbarItem(placement: .topBarTrailing) { AccountMenu() } } }
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
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(LinearGradient(colors: [accent.opacity(0.24), Brand.violet.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1))
            .shadow(color: Brand.green.opacity(0.09), radius: 18, x: 0, y: 8)
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
                IconTile(symbol: symbol, color: Brand.emphasis)
            }.foregroundStyle(Brand.emphasis)
            Text(title).font(.title2.bold()).foregroundStyle(Brand.ink)
            Text(subtitle).font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
        }.padding(4).background(alignment: .topTrailing) {
            Circle().fill(Brand.turquoise.opacity(0.09)).frame(width: 150, height: 150).offset(x: 45, y: -55).accessibilityHidden(true)
        }.clipShape(RoundedRectangle(cornerRadius: 20)).modifier(SurfaceCard())
    }
}
struct IconTile: View {
    let symbol: String
    var color: Color = Brand.emphasis
    var body: some View {
        Image(systemName: symbol).font(.title3.weight(.semibold)).foregroundStyle(color)
            .frame(width: 46, height: 46).background(LinearGradient(colors: [color.opacity(0.16), color.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 14)).overlay(RoundedRectangle(cornerRadius: 14).stroke(color.opacity(0.12), lineWidth: 1)).accessibilityHidden(true)
    }
}
struct PrimaryActionStyle: ButtonStyle {
    @Environment(\.isEnabled) private var enabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.headline).foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(LinearGradient(colors: [Brand.green, Brand.violet], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 16))
            .shadow(color: Brand.green.opacity(enabled ? 0.23 : 0), radius: 10, x: 0, y: 5)
            .opacity(enabled ? (configuration.isPressed ? 0.8 : 1) : 0.45)
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

// Ilustración local decorativa: no representa datos ni operaciones reales.
struct ShoppingHero: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Label("COMPRAS INTELIGENTES", systemImage: "sparkle")
                    .font(.caption.bold()).tracking(1)
                Spacer(minLength: 0)
            }.foregroundStyle(.white.opacity(0.85))
            ZStack {
                Circle().fill(.white.opacity(0.08)).frame(width: 174, height: 174)
                RoundedRectangle(cornerRadius: 28).fill(.white.opacity(0.13))
                    .frame(width: 124, height: 124).rotationEffect(.degrees(-10))
                    .overlay(RoundedRectangle(cornerRadius: 28).stroke(.white.opacity(0.2), lineWidth: 1).rotationEffect(.degrees(-10)))
                Image(systemName: "cart.fill").font(.system(size: 64, weight: .semibold))
                    .foregroundStyle(.white).rotationEffect(.degrees(-8))
                    .shadow(color: .black.opacity(0.15), radius: 10, y: 8)
                heroTile("shippingbox.fill", color: Brand.coral).offset(x: -100, y: 36)
                heroTile("checkmark.seal.fill", color: Brand.turquoise).offset(x: 98, y: -40)
                heroTile("creditcard.fill", color: Brand.violet).offset(x: 100, y: 52)
            }.frame(maxWidth: .infinity).frame(height: 180).accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 7) {
                Text("Todo conectado.\nTodo bajo control.").font(.title2.bold())
                Text("Compras · Inventario · Proveedores").font(.footnote.weight(.medium)).foregroundStyle(.white.opacity(0.85))
            }.foregroundStyle(.white)
        }.padding(24).frame(maxWidth: .infinity, alignment: .leading)
            .background {
                LinearGradient(colors: [Brand.green, Color(red: 37/255, green: 45/255, blue: 101/255), Brand.violet], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .overlay(alignment: .topTrailing) {
                        Circle().fill(Brand.turquoise.opacity(0.28)).frame(width: 220, height: 220).blur(radius: 35).offset(x: 80, y: -80)
                    }
            }.clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(RoundedRectangle(cornerRadius: 30).stroke(.white.opacity(0.16), lineWidth: 1))
            .shadow(color: Brand.green.opacity(0.2), radius: 20, y: 10)
    }
    private func heroTile(_ symbol: String, color: Color) -> some View {
        Image(systemName: symbol).font(.system(size: 25, weight: .semibold))
            .foregroundStyle(.white).frame(width: 56, height: 56)
            .background(color.gradient, in: RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(.white.opacity(0.25), lineWidth: 1))
            .shadow(color: .black.opacity(0.12), radius: 8, y: 5)
    }
}
