import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @State private var usuario = ""
    @State private var clave = ""
    @State private var error: String?
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    ShoppingHero()
                    VStack(spacing: 8) { Text("Compras Tecsup").font(.largeTitle.bold()).foregroundStyle(Brand.ink); Text("Bienvenido. Ingresa para continuar con tus compras.").foregroundStyle(.secondary) }
                    VStack(alignment: .leading, spacing: 18) {
                        Label("Usuario", systemImage: "person.crop.circle").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                        TextField("Usuario", text: $usuario, prompt: Text("Ingresa tu usuario").foregroundStyle(.secondary)).foregroundStyle(Brand.ink).textContentType(.username).textInputAutocapitalization(.never).autocorrectionDisabled().accessibilityIdentifier("login.usuario")
                        Divider()
                        Label("Clave", systemImage: "lock.shield").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                        SecureField("Clave", text: $clave, prompt: Text("Ingresa tu clave").foregroundStyle(.secondary)).foregroundStyle(Brand.ink).textContentType(.password).accessibilityIdentifier("login.clave")
                    }.surfaceCard()
                    if let error { ErrorNotice(text: error) }
                    Button {
                        do { try ComprasService(context, sesion).login(usuario: usuario, clave: clave); clave = "" }
                        catch { self.error = "Usuario o clave incorrectos"; clave = "" }
                    } label: { Text("Ingresar").frame(maxWidth: .infinity).padding(.vertical, 8) }
                    .buttonStyle(PrimaryActionStyle()).disabled(usuario.isEmpty || clave.isEmpty).accessibilityIdentifier("login.ingresar")
                    NavigationLink("Crear cuenta") { RegisterView() }.foregroundStyle(Brand.emphasis)
                    Label("Datos locales en este dispositivo", systemImage: "iphone.gen3").font(.footnote).foregroundStyle(.secondary)
                }.frame(maxWidth: 480).padding(24).frame(maxWidth: .infinity)
            }.background {
                LinearGradient(colors: [Brand.emphasis.opacity(0.09), Brand.background, Brand.background], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            }.tint(Brand.green)
        }
    }
}
