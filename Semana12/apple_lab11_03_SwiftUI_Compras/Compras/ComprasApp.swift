import SwiftUI
import SwiftData

@main struct ComprasApp: App {
    @State private var sesion = Sesion()
    private let container: ModelContainer?
    private let failure: String?
    init() {
        do {
            #if DEBUG
            let testing = ProcessInfo.processInfo.arguments.contains("--ui-testing")
            #else
            let testing = false
            #endif
            container = try Store.container(memory: testing); failure = nil
        }
        catch { container = nil; failure = error.localizedDescription }
    }
    private var testColorScheme: ColorScheme? {
        #if DEBUG
        ProcessInfo.processInfo.arguments.contains("--ui-dark") ? .dark : nil
        #else
        nil
        #endif
    }
    var body: some Scene {
        WindowGroup {
            if let container {
                Group { if sesion.usuario != nil { HomeView() } else { LoginView() } }
                    .modelContainer(container).environment(sesion).preferredColorScheme(testColorScheme)
            } else {
                ContentUnavailableView("No se pudo abrir Compras", systemImage: "externaldrive.badge.exclamationmark", description: Text(failure ?? "Vuelve a abrir la app. No se borraron datos."))
            }
        }
    }
}
