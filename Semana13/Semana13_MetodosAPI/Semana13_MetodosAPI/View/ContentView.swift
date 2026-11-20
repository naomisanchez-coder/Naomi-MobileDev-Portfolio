import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("Buscar usuario por nombre", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .padding()

                if viewModel.isBusy {
                    ProgressView("Procesando…").padding(.bottom, 8)
                } else if let error = viewModel.errorMessage {
                    Text(error).font(.footnote).foregroundStyle(.red).padding(.horizontal)
                } else if !viewModel.status.isEmpty {
                    Text(viewModel.status).font(.footnote).padding(.horizontal)
                }

                List(viewModel.filteredUsers) { user in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline).foregroundStyle(.secondary)
                    }
                    .accessibilityIdentifier("user-\(user.id)")
                }
                .scrollDismissesKeyboard(.interactively)

                if !viewModel.hasLoaded && !viewModel.isBusy {
                    Button("Reintentar", action: viewModel.fetchUsers).padding()
                }
            }
            .navigationTitle("Usuarios")
            .onAppear(perform: viewModel.fetchUsers)
        }
        .navigationViewStyle(.stack)
    }
}
