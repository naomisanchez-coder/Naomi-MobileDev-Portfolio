import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

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
                    .swipeActions(allowsFullSwipe: false) {
                        if user.id > 0 {
                            Button {
                                Task { await viewModel.deleteUser(id: user.id) }
                            } label: {
                                Label("Eliminar", systemImage: "trash")
                            }
                            .tint(.red)
                            .disabled(viewModel.isBusy)

                            Button {
                                viewModel.clearError()
                                editingUser = user
                                showingForm = true
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(.blue)
                            .disabled(viewModel.isBusy)
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)

                if viewModel.hasLoaded {
                    Button {
                        viewModel.clearError()
                        editingUser = nil
                        showingForm = true
                    } label: {
                        Label("Agregar Usuario", systemImage: "plus")
                    }
                    .padding()
                    .disabled(viewModel.isBusy)
                }

                if !viewModel.hasLoaded && !viewModel.isBusy {
                    Button("Reintentar") {
                        Task { await viewModel.fetchUsers() }
                    }
                    .padding()
                }
            }
            .navigationTitle("Usuarios")
            .onAppear { Task { await viewModel.fetchUsers() } }
            .sheet(isPresented: $showingForm) {
                if let user = editingUser {
                    UserFormView(viewModel: viewModel, name: user.name, email: user.email, isEditing: true) { name, email in
                        Task {
                            await viewModel.updateUser(user: User(id: user.id, name: name, email: email)) {
                                showingForm = false
                            }
                        }
                    }
                } else {
                    UserFormView(viewModel: viewModel, name: "", email: "", isEditing: false) { name, email in
                        Task {
                            await viewModel.createUser(name: name, email: email) {
                                showingForm = false
                            }
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
