import SwiftUI

/// Solo se copia al proyecto histórico para capturar la Actividad 01.
/// No forma parte del target ni del flujo de mensajería actual.
struct AuthenticationWelcomeView: View {
    let email: String
    let signOut: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            HStack {
                LabBrandMark(compact: true)
                Spacer()
            }
            Spacer(minLength: 20)
            VStack(spacing: 22) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 60, weight: .medium))
                    .foregroundStyle(LabTheme.green)
                    .frame(width: 118, height: 118)
                    .background(LabTheme.greenSoft, in: Circle())
                    .accessibilityHidden(true)
                VStack(spacing: 10) {
                    Text("¡Sesión iniciada!")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(LabTheme.navy)
                    Text("Qué bueno tenerte aquí.")
                        .font(.title3)
                        .foregroundStyle(LabTheme.secondaryText)
                }
                VStack(spacing: 10) {
                    Label("Acceso completado", systemImage: "checkmark.shield.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(LabTheme.green)
                    Text(email)
                        .font(.body.weight(.medium))
                        .foregroundStyle(LabTheme.navy)
                        .multilineTextAlignment(.center)
                        .textSelection(.enabled)
                    Text("Tu cuenta está lista para continuar.")
                        .font(.subheadline)
                        .foregroundStyle(LabTheme.secondaryText)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(LabTheme.surface, in: RoundedRectangle(cornerRadius: LabTheme.cardRadius))
                .overlay {
                    RoundedRectangle(cornerRadius: LabTheme.cardRadius)
                        .stroke(LabTheme.border, lineWidth: 1)
                }
            }
            Spacer(minLength: 20)
            Button(action: signOut) {
                Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
            }
            .buttonStyle(LabActionStyle(kind: .destructive))
        }
        .frame(maxWidth: 560)
        .padding(LabTheme.pagePadding)
        .frame(maxWidth: .infinity)
        .background(LabTheme.background.ignoresSafeArea())
    }
}
