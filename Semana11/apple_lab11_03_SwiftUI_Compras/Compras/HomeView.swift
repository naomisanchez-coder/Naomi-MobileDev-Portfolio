import SwiftUI
struct HomeView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        TabView { ProductsView().tabItem { Label("Productos", systemImage: "shippingbox") } }.tint(Brand.green)
    }
}
