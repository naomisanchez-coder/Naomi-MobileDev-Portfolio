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
                VStack(spacing: 24) {
                    Logo().padding(.top, 44)
                    VStack(spacing: 8) { Text("Compras Tecsup").font(.largeTitle.bold()).foregroundStyle(Brand.ink); Text("Tu inventario, bajo control").foregroundStyle(.secondary) }
                    VStack(alignment: .leading, spacing: 18) {
                        Text("Usuario").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                        TextField("Usuario", text: $usuario, prompt: Text("Ingresa tu usuario").foregroundStyle(.secondary)).foregroundStyle(Brand.ink).textContentType(.username).textInputAutocapitalization(.never).autocorrectionDisabled().accessibilityIdentifier("login.usuario")
                        Divider()
                        Text("Clave").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                        SecureField("Clave", text: $clave, prompt: Text("Ingresa tu clave").foregroundStyle(.secondary)).foregroundStyle(Brand.ink).textContentType(.password).accessibilityIdentifier("login.clave")
                    }.padding(20).background(Brand.card, in: RoundedRectangle(cornerRadius: 18))
                    if let error { ErrorNotice(text: error) }
                    Button {
                        do { try ComprasService(context, sesion).login(usuario: usuario, clave: clave); clave = "" }
                        catch { self.error = "Usuario o clave incorrectos"; clave = "" }
                    } label: { Text("Ingresar").frame(maxWidth: .infinity).padding(.vertical, 8) }
                    .buttonStyle(.borderedProminent).disabled(usuario.isEmpty || clave.isEmpty).accessibilityIdentifier("login.ingresar")
                    NavigationLink("Crear cuenta") { RegisterView() }.foregroundStyle(Brand.emphasis)
                    Label("Datos locales en este dispositivo", systemImage: "iphone.gen3").font(.footnote).foregroundStyle(.secondary)
                }.frame(maxWidth: 480).padding(24).frame(maxWidth: .infinity)
            }.background(Brand.background).tint(Brand.green)
        }
    }
}
