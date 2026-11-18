import SwiftUI
struct HomeView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        TabView {
            if sesion.supervisor { ApprovalView().tabItem { Label("Aprobar", systemImage: "checkmark.shield") } }
            if sesion.supervisor { PayablesView().tabItem { Label("Por pagar", systemImage: "calendar.badge.clock") } }
            ProductsView().tabItem { Label("Productos", systemImage: "shippingbox") }
            SuppliersView().tabItem { Label("Proveedores", systemImage: "building.2") }
            if !sesion.supervisor { NewPurchaseView().tabItem { Label("Compra", systemImage: "cart.badge.plus") } }
            if !sesion.supervisor { MyPurchasesView().tabItem { Label("Mis compras", systemImage: "receipt") } }
        }.tint(Brand.green)
    }
}
