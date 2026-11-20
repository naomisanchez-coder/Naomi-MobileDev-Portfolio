import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false

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

                if viewModel.hasLoaded {
                    Button {
                        viewModel.clearError()
                        showingForm = true
                    } label: {
                        Label("Agregar Usuario", systemImage: "plus")
                    }
                    .padding()
                    .disabled(viewModel.isBusy)
                }

                if !viewModel.hasLoaded && !viewModel.isBusy {
                    Button("Reintentar", action: viewModel.fetchUsers).padding()
                }
            }
            .navigationTitle("Usuarios")
            .onAppear(perform: viewModel.fetchUsers)
            .sheet(isPresented: $showingForm) {
                UserFormView(viewModel: viewModel, name: "", email: "", isEditing: false) { name, email in
                    viewModel.createUser(name: name, email: email) {
                        showingForm = false
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
