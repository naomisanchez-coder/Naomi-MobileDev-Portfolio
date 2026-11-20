import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                Text(user.name)
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
            .navigationTitle("Usuarios - API")
            .onAppear(perform: viewModel.fetchUsers)
        }
        .navigationViewStyle(.stack)
    }
}
