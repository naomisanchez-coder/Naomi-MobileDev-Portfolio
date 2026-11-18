import SwiftUI
struct HomeView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        VStack(spacing: 24) { Logo(); Text("Bienvenido, \(sesion.usuario?.nombre ?? "")").font(.title2); AccountMenu() }.tint(Brand.green)
    }
}
