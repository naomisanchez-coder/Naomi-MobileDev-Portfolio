import SwiftUI

struct UserFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UserViewModel
    @State var name: String
    @State var email: String
    var isEditing: Bool
    var onSubmit: (String, String) -> Void

    private var cleanName: String { name.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var cleanEmail: String { email.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var isValid: Bool {
        !cleanName.isEmpty && cleanEmail.range(of: #"^[^\s@]+@[^\s@]+\.[^\s@]+$"#, options: .regularExpression) != nil
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $name)
                    .accessibilityIdentifier("form-name")
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier("form-email")
                if viewModel.isBusy {
                    ProgressView("Guardando…")
                } else if let message = viewModel.errorMessage {
                    Text(message).foregroundStyle(.red)
                }
            }
            .navigationTitle(isEditing ? "Editar Usuario" : "Nuevo Usuario")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }.disabled(viewModel.isBusy)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { onSubmit(cleanName, cleanEmail) }
                        .disabled(!isValid || viewModel.isBusy)
                }
            }
        }
        .navigationViewStyle(.stack)
        .interactiveDismissDisabled(viewModel.isBusy)
    }
}
