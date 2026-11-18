import SwiftUI
import SwiftData

@main struct ComprasApp: App {
    @State private var sesion = Sesion()
    private let container: ModelContainer?
    private let failure: String?
    init() {
        do { container = try Store.container(); failure = nil }
        catch { container = nil; failure = error.localizedDescription }
    }
    var body: some Scene {
        WindowGroup {
            if let container {
                LoginView().modelContainer(container).environment(sesion)
            } else {
                ContentUnavailableView("No se pudo abrir Compras", systemImage: "externaldrive.badge.exclamationmark", description: Text(failure ?? "Vuelve a abrir la app. No se borraron datos."))
            }
        }
    }
}
