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
                Section {
                    UserHeader(title: isEditing ? "Editar usuario" : "Nuevo usuario",
                               icon: isEditing ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.plus")
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)

                Section {
                    VStack(alignment: .leading, spacing: 5) {
                        Label("Nombre", systemImage: "person").font(.caption.weight(.semibold))
                        TextField("Nombre", text: $name)
                            .accessibilityIdentifier("form-name")
                    }
                    .padding(.vertical, 4)

                    VStack(alignment: .leading, spacing: 5) {
                        Label("Correo electrónico", systemImage: "envelope").font(.caption.weight(.semibold))
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .accessibilityIdentifier("form-email")
                    }
                    .padding(.vertical, 4)
                }
                .listRowBackground(UserStyle.surface)

                if viewModel.isBusy {
                    ProgressView("Guardando…")
                } else if let message = viewModel.errorMessage {
                    UserNotice(text: message, isError: true)
                }
            }
            .scrollContentBackground(.hidden)
            .background(UserStyle.background.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                        .tint(UserStyle.indigo)
                        .disabled(viewModel.isBusy)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { onSubmit(cleanName, cleanEmail) }
                        .buttonStyle(.borderedProminent)
                        .tint(UserStyle.teal)
                        .disabled(!isValid || viewModel.isBusy)
                }
            }
        }
        .navigationViewStyle(.stack)
        .interactiveDismissDisabled(viewModel.isBusy)
    }
}
