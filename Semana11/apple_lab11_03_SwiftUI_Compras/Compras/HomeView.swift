import SwiftUI
struct HomeView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        TabView {
            ProductsView().tabItem { Label("Productos", systemImage: "shippingbox") }
            SuppliersView().tabItem { Label("Proveedores", systemImage: "building.2") }
            if !sesion.supervisor { NewPurchaseView().tabItem { Label("Compra", systemImage: "cart.badge.plus") } }
            if !sesion.supervisor { MyPurchasesView().tabItem { Label("Mis compras", systemImage: "receipt") } }
        }.tint(Brand.green)
    }
}
