import Combine
import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published var searchText = ""
    @Published private(set) var status = ""
    @Published private(set) var errorMessage: String?
    @Published private(set) var isBusy = false
    @Published private(set) var hasLoaded = false

    private var nextLocalID = -1
    private let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users")!

    var filteredUsers: [User] {
        guard !searchText.isEmpty else { return users }
        return users.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    func fetchUsers() async {
        guard !isBusy, !hasLoaded else { return }
        isBusy = true
        errorMessage = nil
        defer { isBusy = false }
        do {
            let (data, response) = try await URLSession.shared.data(from: usersURL)
            let code = try Self.statusCode(response)
            users = try JSONDecoder().decode([User].self, from: data)
            hasLoaded = true
            status = "GET HTTP \(code) · \(users.count) usuarios"
        } catch {
            if !Task.isCancelled {
                errorMessage = "GET: \(error.localizedDescription)"
            }
        }
    }

    func clearError() {
        errorMessage = nil
    }

    func createUser(name: String, email: String, onSuccess: () -> Void) async {
        guard !isBusy else { return }
        isBusy = true
        errorMessage = nil
        defer { isBusy = false }

        let user = User(id: 0, name: name, email: email)
        do {
            let request = try userRequest(method: "POST", url: usersURL, user: user)
            let (data, response) = try await URLSession.shared.data(for: request)
            let code = try Self.statusCode(response)
            let created = try JSONDecoder().decode(User.self, from: data)
            let local = User(id: nextLocalID, name: created.name, email: created.email)
            nextLocalID -= 1
            users.insert(local, at: 0)
            searchText = ""
            status = "POST HTTP \(code) · Alta local: \(local.name)"
            onSuccess()
        } catch {
            errorMessage = "POST: \(error.localizedDescription)"
        }
    }

    func updateUser(user: User, onSuccess: @escaping () -> Void) {
        let url = usersURL.appendingPathComponent(String(user.id))
        do {
            let request = try userRequest(method: "PUT", url: url, user: user)
            send(request) { _, code in
                guard let index = self.users.firstIndex(where: { $0.id == user.id }) else { return }
                self.users[index] = user
                self.searchText = ""
                self.status = "PUT HTTP \(code) · Edición local: \(user.name)"
                onSuccess()
            }
        } catch {
            errorMessage = "PUT: \(error.localizedDescription)"
        }
    }

    func deleteUser(id: Int) {
        guard let user = users.first(where: { $0.id == id }) else { return }
        var request = URLRequest(url: usersURL.appendingPathComponent(String(id)))
        request.httpMethod = "DELETE"
        send(request) { _, code in
            self.users.removeAll { $0.id == id }
            self.status = "DELETE HTTP \(code) · Baja local: \(user.name)"
        }
    }

    private func userRequest(method: String, url: URL, user: User) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user)
        return request
    }

    private func send(_ request: URLRequest, apply: @escaping (Data, Int) throws -> Void) {
        guard !isBusy else { return }
        isBusy = true
        errorMessage = nil
        let method = request.httpMethod ?? "GET"
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self else { return }
                defer { self.isBusy = false }
                do {
                    if let error { throw error }
                    let code = try Self.statusCode(response)
                    try apply(data ?? Data(), code)
                } catch {
                    self.errorMessage = "\(method): \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private static func statusCode(_ response: URLResponse?) throws -> Int {
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard (200..<300).contains(response.statusCode) else {
            throw NSError(domain: "JSONPlaceholder", code: response.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: "HTTP \(response.statusCode)"])
        }
        return response.statusCode
    }
}
