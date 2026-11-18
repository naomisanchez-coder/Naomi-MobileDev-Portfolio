import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.modelContext) private var context
    @Environment(Sesion.self) private var sesion
    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var confirmacion = ""
    @State private var rol = Rol.comprador
    @State private var error: String?
    @State private var duplicado = false
    var body: some View {
        Form {
            Section { VisualHeader(eyebrow: "Tu nueva cuenta", title: "Crea tu espacio de compras", subtitle: "Configura tu perfil y empieza a trabajar con tu equipo.", symbol: "person.badge.plus") }.floatingRow()
            Section { Label("Datos personales", systemImage: "person.text.rectangle").font(.subheadline.bold()).foregroundStyle(Brand.emphasis)
                TextField("Nombre completo", text: $nombre).textContentType(.name)
                TextField("Usuario único", text: $usuario).textContentType(.username).textInputAutocapitalization(.never).autocorrectionDisabled()
                    .onChange(of: usuario) { _, value in duplicado = (try? ComprasService(context, sesion).exists(value)) ?? false }
                if duplicado { ErrorNotice(text: "Este usuario ya existe.") }
            }
            Section("Protege tu cuenta") {
                Label("Acceso seguro", systemImage: "lock.shield").font(.subheadline.bold()).foregroundStyle(Brand.emphasis)
                SecureField("Clave · mínimo 6 caracteres", text: $clave).textContentType(.newPassword)
                SecureField("Confirmar clave", text: $confirmacion).textContentType(.newPassword)
            }
            Section {
                Picker("Tu rol", selection: $rol) { ForEach(Rol.allCases, id: \.self) { Text($0.rawValue).tag($0) } }.pickerStyle(.segmented)
            } header: { Text("Tu rol") } footer: { Text("Registro académico local. Al registrarte entrarás directamente con las pestañas de tu rol.") }
            if let error { Section { ErrorNotice(text: error) } }
            Section {
                Button("Registrarme") {
                    do { try ComprasService(context, sesion).register(nombre: nombre, usuario: usuario, clave: clave, confirmacion: confirmacion, rol: rol); clave = ""; confirmacion = "" }
                    catch { self.error = error.localizedDescription }
                }.buttonStyle(PrimaryActionStyle()).frame(maxWidth: .infinity).disabled(duplicado)
            }
        }.scrollContentBackground(.hidden).background(Brand.background).navigationTitle("Crear cuenta").navigationBarTitleDisplayMode(.inline).tint(Brand.green)
    }
}
