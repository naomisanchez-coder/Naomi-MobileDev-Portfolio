import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var databaseService = DatabaseService()
    @State private var newMessage = ""
    @State private var signOutError = false
    @FocusState private var composerFocused: Bool

    private var currentEmail: String { Auth.auth().currentUser?.email ?? "" }
    private var canSend: Bool { !newMessage.isEmpty }

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 18) {
                        Label("Un espacio para compartir ideas", systemImage: "bubble.left.and.bubble.right")
                            .font(.caption)
                            .foregroundStyle(LabTheme.secondaryText)
                            .padding(.vertical, 8)
                        if databaseService.messages.isEmpty {
                            emptyConversation
                        }
                        ForEach(databaseService.messages) { message in
                            MessageBubble(message: message, isOwn: message.userEmail == currentEmail)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, LabTheme.pagePadding)
                    .padding(.vertical, 20)
                }
                .defaultScrollAnchor(.bottom)
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: databaseService.messages.count) { _, _ in
                    if let last = databaseService.messages.last {
                        withAnimation(.easeOut(duration: 0.2)) {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: composerFocused) { _, focused in
                    if focused, let last = databaseService.messages.last {
                        withAnimation(.easeOut(duration: 0.2)) {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
        }
        .background(LabTheme.background.ignoresSafeArea())
        .safeAreaInset(edge: .bottom, spacing: 0) { composer }
        .onAppear { databaseService.startListening() }
        .alert("No pudimos cerrar la sesión", isPresented: $signOutError) {
            Button("Entendido", role: .cancel) { }
        } message: {
            Text("Inténtalo de nuevo en un momento.")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("LAB 14 · CONECTA")
                        .font(.caption2.weight(.bold))
                        .tracking(1.5)
                        .foregroundStyle(LabTheme.turquoise)
                    Text("Mensajes")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(LabTheme.navy)
                }
                Spacer(minLength: 8)
                Button {
                    composerFocused = false
                    do { try Auth.auth().signOut() }
                    catch { signOutError = true }
                } label: {
                    Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(LabTheme.coral)
                        .padding(.horizontal, 12)
                        .frame(minHeight: 44)
                        .background(LabTheme.coralSoft, in: RoundedRectangle(cornerRadius: 13))
                }
                .buttonStyle(.plain)
            }
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(LabTheme.green)
                Text(currentEmail)
                    .foregroundStyle(LabTheme.secondaryText)
                    .lineLimit(2)
                    .textSelection(.enabled)
            }
            .font(.footnote)
            .accessibilityLabel("Sesión activa: \(currentEmail)")
        }
        .padding(LabTheme.pagePadding)
        .background(LabTheme.surface)
        .overlay(alignment: .bottom) { Divider().overlay(LabTheme.border) }
    }

    private var emptyConversation: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(.system(size: 38))
                .foregroundStyle(LabTheme.turquoise)
                .frame(width: 88, height: 88)
                .background(LabTheme.turquoiseSoft, in: Circle())
            Text("La conversación empieza contigo")
                .font(.title3.weight(.bold))
                .foregroundStyle(LabTheme.navy)
            Text("Escribe el primer mensaje y comparte una idea con tu grupo.")
                .font(.subheadline)
                .foregroundStyle(LabTheme.secondaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
    }

    private var composer: some View {
        HStack(alignment: .bottom, spacing: 12) {
            TextField("Escribe un mensaje…", text: $newMessage, axis: .vertical)
                .font(.body)
                .foregroundStyle(LabTheme.navy)
                .lineLimit(1...4)
                .focused($composerFocused)
                .padding(14)
                .frame(minHeight: 50)
                .background(LabTheme.background, in: RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(composerFocused ? LabTheme.turquoise : LabTheme.border,
                                lineWidth: composerFocused ? 2 : 1)
                }
                .accessibilityLabel("Escribe un mensaje")
            Button {
                guard canSend else { return }
                databaseService.addMessage(text: newMessage)
                newMessage = ""
            } label: {
                HStack(spacing: 7) {
                    Text("Enviar")
                    Image(systemName: "arrow.up")
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .frame(minHeight: 50)
                .background(canSend ? LabTheme.navy : LabTheme.secondaryText,
                            in: RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .disabled(!canSend)
            .opacity(canSend ? 1 : 0.6)
            .accessibilityLabel("Enviar mensaje")
        }
        .frame(maxWidth: 760)
        .padding(.horizontal, LabTheme.pagePadding)
        .padding(.top, 14)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity)
        .background(LabTheme.surface)
        .overlay(alignment: .top) { Divider().overlay(LabTheme.border) }
    }
}

private struct MessageBubble: View {
    let message: Message
    let isOwn: Bool

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if isOwn { Spacer(minLength: 36) }
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    Image(systemName: isOwn ? "arrow.up.right" : "arrow.down.left")
                    Text(isOwn ? "Tú" : "Recibido")
                        .fontWeight(.semibold)
                }
                .font(.caption)
                .foregroundStyle(isOwn ? LabTheme.turquoiseSoft : LabTheme.turquoise)
                Text(message.text)
                    .font(.body)
                    .lineSpacing(3)
                    .foregroundStyle(isOwn ? .white : LabTheme.navy)
                    .textSelection(.enabled)
                VStack(alignment: .leading, spacing: 5) {
                    Text(message.userEmail)
                        .lineLimit(2)
                    Text(message.timestamp, style: .time)
                }
                .font(.caption2)
                .foregroundStyle(isOwn ? Color.white.opacity(0.85) : LabTheme.secondaryText)
            }
            .padding(16)
            .background(isOwn ? LabTheme.navy : LabTheme.surface,
                        in: RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isOwn ? .clear : LabTheme.border, lineWidth: 1)
            }
            .frame(maxWidth: 600, alignment: isOwn ? .trailing : .leading)
            .accessibilityElement(children: .combine)
            if !isOwn { Spacer(minLength: 36) }
        }
        .frame(maxWidth: .infinity, alignment: isOwn ? .trailing : .leading)
    }
}
