import SwiftUI
struct HomeView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        TabView {
            ProductsView().tabItem { Label("Productos", systemImage: "shippingbox") }
            SuppliersView().tabItem { Label("Proveedores", systemImage: "building.2") }
        }.tint(Brand.green)
    }
}
