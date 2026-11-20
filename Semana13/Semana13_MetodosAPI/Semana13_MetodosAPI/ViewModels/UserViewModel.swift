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

    private let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users")!

    var filteredUsers: [User] {
        guard !searchText.isEmpty else { return users }
        return users.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    func fetchUsers() {
        guard !isBusy, !hasLoaded else { return }
        send(URLRequest(url: usersURL)) { data, code in
            self.users = try JSONDecoder().decode([User].self, from: data)
            self.hasLoaded = true
            self.status = "GET HTTP \(code) · \(self.users.count) usuarios"
        }
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
