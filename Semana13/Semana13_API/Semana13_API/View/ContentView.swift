import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                UserHeader(title: "Usuarios", icon: "person.2.fill")
                    .padding(.horizontal, 16)
                UserSearch(text: $viewModel.searchText)
                    .padding(.horizontal, 16)

                List(viewModel.filteredUsers) { user in
                    HStack(spacing: 10) {
                        UserBadge(name: user.name)
                        Text(user.name).font(.body.weight(.medium))
                    }
                    .listRowBackground(UserStyle.surface)
                    .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                }
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.interactively)
                .overlay {
                    if !viewModel.searchText.isEmpty && viewModel.filteredUsers.isEmpty && !viewModel.users.isEmpty {
                        ContentUnavailableView("Sin coincidencias", systemImage: "magnifyingglass",
                                               description: Text("Prueba con otro nombre."))
                    }
                }
            }
            .padding(.top, 8)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                VStack(spacing: 6) {
                    if viewModel.isLoading {
                        ProgressView("Cargando usuarios")
                    } else if !viewModel.status.isEmpty {
                        UserNotice(text: viewModel.status, isError: viewModel.users.isEmpty)
                    }
                    if viewModel.users.isEmpty && !viewModel.isLoading {
                        Button("Reintentar", action: viewModel.fetchUsers)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(.background)
            }
            .background(UserStyle.background.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .onAppear(perform: viewModel.fetchUsers)
        }
        .navigationViewStyle(.stack)
    }
}
