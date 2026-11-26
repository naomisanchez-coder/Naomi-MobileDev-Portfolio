import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                UserHeader(title: "Usuarios", icon: "person.crop.rectangle.stack.fill")
                    .padding(.horizontal, 16)
                UserSearch(text: $viewModel.searchText)
                    .padding(.horizontal, 16)

                if viewModel.isBusy {
                    ProgressView("Procesando…").padding(.vertical, 6)
                } else if let error = viewModel.errorMessage {
                    UserNotice(text: error, isError: true).padding(.horizontal, 16)
                } else if !viewModel.status.isEmpty {
                    UserNotice(text: viewModel.status).padding(.horizontal, 16)
                }

                List(viewModel.filteredUsers) { user in
                    HStack(spacing: 12) {
                        UserBadge(name: user.name)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(user.name).font(.headline)
                            Text(user.email).font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                    .listRowBackground(UserStyle.surface)
                    .accessibilityIdentifier("user-\(user.id)")
                    .swipeActions(allowsFullSwipe: false) {
                        if user.id > 0 {
                            Button {
                                Task { await viewModel.deleteUser(id: user.id) }
                            } label: {
                                Label("Eliminar", systemImage: "trash")
                            }
                            .tint(UserStyle.coral)
                            .disabled(viewModel.isBusy)

                            Button {
                                viewModel.clearError()
                                editingUser = user
                                showingForm = true
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(UserStyle.indigo)
                            .disabled(viewModel.isBusy)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.interactively)

                if viewModel.hasLoaded {
                    Button {
                        viewModel.clearError()
                        editingUser = nil
                        showingForm = true
                    } label: {
                        Label("Agregar Usuario", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(UserStyle.teal)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .disabled(viewModel.isBusy)
                }

                if !viewModel.hasLoaded && !viewModel.isBusy {
                    Button("Reintentar") {
                        Task { await viewModel.fetchUsers() }
                    }
                    .padding()
                }
            }
            .padding(.top, 8)
            .background(UserStyle.background.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .task { await viewModel.fetchUsers() }
            .sheet(isPresented: $showingForm) {
                let user = editingUser
                UserFormView(viewModel: viewModel, name: user?.name ?? "", email: user?.email ?? "", isEditing: user != nil) { name, email in
                    Task {
                        let saved: Bool
                        if let user {
                            saved = await viewModel.updateUser(user: User(id: user.id, name: name, email: email))
                        } else {
                            saved = await viewModel.createUser(name: name, email: email)
                        }
                        if saved { showingForm = false }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
