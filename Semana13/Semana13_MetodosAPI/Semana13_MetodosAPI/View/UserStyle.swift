import SwiftUI

enum UserStyle {
    static let indigo = Color(red: 0.16, green: 0.20, blue: 0.43)
    static let deepBlue = Color(red: 0.09, green: 0.15, blue: 0.31)
    static let teal = Color(red: 0.08, green: 0.42, blue: 0.41)
    static let aqua = Color(red: 0.58, green: 0.95, blue: 0.89)
    static let coral = Color(red: 0.74, green: 0.20, blue: 0.26)
    static let surface = Color(uiColor: .secondarySystemGroupedBackground)
    static let background = LinearGradient(
        colors: [Color.teal.opacity(0.10), Color(uiColor: .systemGroupedBackground)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

struct UserHeader: View {
    let title: String
    let icon: String

    var body: some View {
        Label {
            Text(title).font(.title2.bold()).foregroundStyle(.white)
        } icon: {
            Image(systemName: icon).foregroundStyle(UserStyle.aqua)
        }
        .accessibilityAddTraits(.isHeader)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            LinearGradient(colors: [UserStyle.deepBlue, UserStyle.indigo],
                           startPoint: .leading, endPoint: .trailing),
            in: RoundedRectangle(cornerRadius: 18)
        )
    }
}

struct UserSearch: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary).accessibilityHidden(true)
            TextField("Buscar usuario por nombre", text: $text)
                .autocorrectionDisabled()
                .accessibilityIdentifier("search")
        }
        .padding(12)
        .background(UserStyle.surface, in: RoundedRectangle(cornerRadius: 12))
    }
}

struct UserBadge: View {
    let name: String

    var body: some View {
        let initials = name.split(whereSeparator: \.isWhitespace).prefix(2).compactMap(\.first)
        Text(String(initials).uppercased())
            .font(.caption.bold())
            .foregroundStyle(UserStyle.deepBlue)
            .frame(width: 34, height: 34)
            .background(UserStyle.aqua, in: Circle())
            .accessibilityHidden(true)
    }
}

struct UserNotice: View {
    let text: String
    var isError = false

    var body: some View {
        Label {
            Text(text).foregroundStyle(.primary)
        } icon: {
            Image(systemName: isError ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
                .foregroundStyle(isError ? Color.red : Color.green)
                .accessibilityHidden(true)
        }
        .font(.footnote.weight(.medium))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(UserStyle.surface, in: RoundedRectangle(cornerRadius: 12))
    }
}
