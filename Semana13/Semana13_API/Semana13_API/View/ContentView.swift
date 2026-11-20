import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("Buscar usuario por nombre", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier("search")
                    .padding()

                List(viewModel.filteredUsers) { user in
                    Text(user.name)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 6) {
                    if viewModel.isLoading {
                        ProgressView("Cargando usuarios")
                    } else if !viewModel.status.isEmpty {
                        Text(viewModel.status).font(.footnote)
                    }
                    if viewModel.users.isEmpty && !viewModel.isLoading {
                        Button("Reintentar", action: viewModel.fetchUsers)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(.background)
            }
            .navigationTitle("Usuarios")
            .onAppear(perform: viewModel.fetchUsers)
        }
        .navigationViewStyle(.stack)
    }
}
