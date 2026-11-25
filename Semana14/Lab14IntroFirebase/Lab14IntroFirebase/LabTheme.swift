import SwiftUI

/// Paleta y medidas compartidas por las vistas del laboratorio.
enum LabTheme {
    static let navy = Color(hex: 0x153451)
    static let turquoise = Color(hex: 0x087F8C)
    static let turquoiseSoft = Color(hex: 0xE3F3F2)
    static let green = Color(hex: 0x157348)
    static let greenSoft = Color(hex: 0xE8F5ED)
    static let coral = Color(hex: 0xB83B36)
    static let coralSoft = Color(hex: 0xFDEEEE)
    static let background = Color(hex: 0xF3F6FA)
    static let surface = Color.white
    static let secondaryText = Color(hex: 0x53657A)
    static let border = Color(hex: 0xDCE4ED)
    static let pagePadding: CGFloat = 20
    static let cardRadius: CGFloat = 24
}

private extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

struct LabActionStyle: ButtonStyle {
    enum Kind { case primary, secondary, destructive }
    var kind: Kind = .primary
    @Environment(\.isEnabled) private var isEnabled

    private var foreground: Color {
        switch kind {
        case .primary: return .white
        case .secondary: return LabTheme.turquoise
        case .destructive: return LabTheme.coral
        }
    }

    private var background: Color {
        switch kind {
        case .primary: return LabTheme.navy
        case .secondary: return LabTheme.surface
        case .destructive: return LabTheme.coralSoft
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .frame(maxWidth: .infinity, minHeight: 24)
            .padding(.horizontal, 18)
            .padding(.vertical, 15)
            .foregroundStyle(foreground)
            .background(background, in: RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(kind == .secondary ? LabTheme.border : .clear, lineWidth: 1)
            }
            .opacity(isEnabled ? 1 : 0.5)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct LabBrandMark: View {
    var compact = false

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(compact ? .title3 : .title2)
                .foregroundStyle(LabTheme.turquoise)
                .frame(width: compact ? 44 : 56, height: compact ? 44 : 56)
                .background(LabTheme.turquoiseSoft, in: RoundedRectangle(cornerRadius: 17))
            VStack(alignment: .leading, spacing: 3) {
                Text("LAB 14")
                    .font(.caption.weight(.bold))
                    .tracking(2)
                Text("Conecta")
                    .font(compact ? .headline : .title3.weight(.bold))
            }
            .foregroundStyle(LabTheme.navy)
        }
        .accessibilityElement(children: .combine)
    }
}
