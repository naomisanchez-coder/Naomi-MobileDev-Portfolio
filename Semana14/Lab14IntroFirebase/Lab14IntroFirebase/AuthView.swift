import SwiftUI
import FirebaseAuth
import FirebaseCore

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var showAlert = false
    @State private var alertTitle = "Información"
    @State private var alertMessage = ""
    @State private var isSubmitting = false
    @State private var authStateListener: AuthStateDidChangeListenerHandle?
    @FocusState private var focusedField: Field?
    private enum Field { case email, password }

    var body: some View {
        NavigationStack {
            Group {
                if isSignedIn {
                    MessagesView()
                } else {
                    authenticationForm
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .background(LabTheme.background.ignoresSafeArea())
        }
        .tint(LabTheme.turquoise)
        .preferredColorScheme(.light)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Entendido", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .onAppear { checkAuthState() }
        .onChange(of: isSignedIn) { _, signedIn in
            focusedField = nil
            if !signedIn {
                email = ""
                password = ""
            }
        }
    }

    private var authenticationForm: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                LabBrandMark(compact: focusedField != nil)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tu espacio\npara conectar.")
                        .font(focusedField == nil ? .largeTitle.weight(.bold) : .title2.weight(.bold))
                        .foregroundStyle(LabTheme.navy)
                        .fixedSize(horizontal: false, vertical: true)
                    if focusedField == nil {
                        Text("Comparte ideas y mantén la conversación cerca.")
                            .font(.body)
                            .foregroundStyle(LabTheme.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                VStack(alignment: .leading, spacing: 22) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Accede a tu cuenta")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(LabTheme.navy)
                        Text("Ingresa tu correo y contraseña para continuar.")
                            .font(.subheadline)
                            .foregroundStyle(LabTheme.secondaryText)
                    }
                    VStack(alignment: .leading, spacing: 9) {
                        fieldLabel("Correo electrónico", symbol: "envelope")
                        TextField("nombre@ejemplo.com", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .submitLabel(.next)
                            .focused($focusedField, equals: .email)
                            .onSubmit { focusedField = .password }
                            .modifier(AuthFieldAppearance(active: focusedField == .email))
                            .accessibilityLabel("Correo electrónico")
                    }
                    VStack(alignment: .leading, spacing: 9) {
                        fieldLabel("Contraseña", symbol: "lock")
                        SecureField("Al menos 6 caracteres", text: $password)
                            .textContentType(.password)
                            .submitLabel(.go)
                            .focused($focusedField, equals: .password)
                            .onSubmit { focusedField = nil; signIn() }
                            .modifier(AuthFieldAppearance(active: focusedField == .password))
                            .accessibilityLabel("Contraseña")
                    }
                }
                .padding(22)
                .background(LabTheme.surface, in: RoundedRectangle(cornerRadius: LabTheme.cardRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: LabTheme.cardRadius)
                        .stroke(LabTheme.border, lineWidth: 1)
                }

                if focusedField == nil {
                    Label("Tu sesión, en un espacio seguro", systemImage: "checkmark.shield")
                        .font(.footnote)
                        .foregroundStyle(LabTheme.secondaryText)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: 560)
            .padding(.horizontal, LabTheme.pagePadding)
            .padding(.top, focusedField == nil ? 30 : 12)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity)
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 12) {
                Button {
                    focusedField = nil
                    signIn()
                } label: {
                    HStack(spacing: 10) {
                        if isSubmitting { ProgressView().tint(.white) }
                        Text(isSubmitting ? "Un momento…" : "Iniciar sesión")
                        if !isSubmitting { Image(systemName: "arrow.right") }
                    }
                }
                .buttonStyle(LabActionStyle())
                Button {
                    focusedField = nil
                    signUp()
                } label: {
                    Label("Crear cuenta", systemImage: "person.badge.plus")
                }
                .buttonStyle(LabActionStyle(kind: .secondary))
            }
            .disabled(isSubmitting)
            .frame(maxWidth: 560)
            .padding(.horizontal, LabTheme.pagePadding)
            .padding(.top, 16)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
            .background(LabTheme.surface)
            .overlay(alignment: .top) { Divider().overlay(LabTheme.border) }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Listo") { focusedField = nil }
            }
        }
    }

    private func fieldLabel(_ title: String, symbol: String) -> some View {
        Label(title, systemImage: symbol)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(LabTheme.navy)
    }

    // Se conservan los servicios y métodos de autenticación del laboratorio.
    func signIn() {
        guard !isSubmitting else { return }
        guard !email.isEmpty && !password.isEmpty else {
            present("Completa tu correo electrónico y contraseña.", success: false)
            return
        }
        isSubmitting = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isSubmitting = false
            if let error = error {
                present(authenticationMessage(for: error), success: false)
            } else {
                isSignedIn = true
                present("Iniciaste sesión correctamente.", success: true)
            }
        }
    }

    func signUp() {
        guard !isSubmitting else { return }
        guard !email.isEmpty && !password.isEmpty else {
            present("Completa tu correo electrónico y contraseña.", success: false)
            return
        }
        guard password.count >= 6 else {
            present("Usa una contraseña de al menos 6 caracteres.", success: false)
            return
        }
        isSubmitting = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isSubmitting = false
            if let error = error {
                present(authenticationMessage(for: error), success: false)
            } else {
                isSignedIn = true
                present("Tu cuenta se creó correctamente.", success: true)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
            present("Cerraste tu sesión correctamente.", success: true)
        } catch {
            present(authenticationMessage(for: error), success: false)
        }
    }

    func checkAuthState() {
        guard authStateListener == nil else { return }
        authStateListener = Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.async {
                self.isSignedIn = user != nil
            }
        }
    }

    private func present(_ message: String, success: Bool) {
        alertTitle = success ? "¡Todo listo!" : "Revisa tus datos"
        alertMessage = message
        showAlert = true
    }

    private func authenticationMessage(for error: Error) -> String {
        switch AuthErrorCode(rawValue: (error as NSError).code) {
        case .invalidEmail:
            return "Ingresa una dirección de correo electrónico válida."
        case .invalidCredential, .wrongPassword, .userNotFound:
            return "El correo o la contraseña no son correctos. Revisa tus datos e inténtalo de nuevo."
        case .emailAlreadyInUse:
            return "Este correo ya tiene una cuenta. Usa Iniciar sesión para continuar."
        case .weakPassword:
            return "Elige una contraseña de al menos 6 caracteres."
        case .networkError:
            return "No pudimos conectarnos. Revisa tu conexión e inténtalo de nuevo."
        case .tooManyRequests:
            return "Se realizaron varios intentos. Espera un momento antes de volver a ingresar."
        default:
            return error.localizedDescription
        }
    }
}

private struct AuthFieldAppearance: ViewModifier {
    var active: Bool
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundStyle(LabTheme.navy)
            .padding(15)
            .frame(minHeight: 52)
            .background(LabTheme.background, in: RoundedRectangle(cornerRadius: 13))
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(active ? LabTheme.turquoise : LabTheme.border, lineWidth: active ? 2 : 1)
            }
    }
}

#Preview {
    AuthView()
}
