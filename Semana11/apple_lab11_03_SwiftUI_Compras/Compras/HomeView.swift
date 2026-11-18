import SwiftUI
struct HomeView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        TabView {
            ProductsView().tabItem { Label("Productos", systemImage: "shippingbox") }
            SuppliersView().tabItem { Label("Proveedores", systemImage: "building.2") }
            if !sesion.supervisor { NewPurchaseView().tabItem { Label("Compra", systemImage: "cart.badge.plus") } }
        }.tint(Brand.green)
    }
}
