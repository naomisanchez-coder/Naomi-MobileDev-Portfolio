import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.06)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Image(systemName: "person.crop.rectangle.badge.checkmark")
                        .font(.system(size: 52, weight: .medium))
                        .foregroundStyle(.blue)
                        .padding(28)
                        .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 24))
                        .accessibilityHidden(true)

                    VStack(spacing: 12) {
                        Text("CTS Instructores")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color(red: 0.08, green: 0.20, blue: 0.40))

                        Text("Calculadora de CTS y beneficios laborales.")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    Label("Proyecto académico — Semana 08.", systemImage: "graduationcap")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                        .padding(16)
                        .background(.blue.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
                }
                .multilineTextAlignment(.center)
                .padding(28)
                .frame(maxWidth: 500)
                .background(.white, in: RoundedRectangle(cornerRadius: 24))
                .padding(24)
                .frame(maxWidth: .infinity)
            }
            .defaultScrollAnchor(.center)
        }
    }
}

#Preview {
    ContentView()
}
