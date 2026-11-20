import Combine
import Foundation

final class UserViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var status = ""
    @Published private(set) var isLoading = false

    @Published var searchText = ""

    var filteredUsers: [User] {
        guard !searchText.isEmpty else { return users }
        return users.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    func fetchUsers() {
        guard !isLoading, users.isEmpty,
              let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        isLoading = true
        status = ""
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let result = Result {
                if let error { throw error }
                guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
                guard (200..<300).contains(response.statusCode) else {
                    throw NSError(domain: "JSONPlaceholder", code: response.statusCode,
                                  userInfo: [NSLocalizedDescriptionKey: "GET HTTP \(response.statusCode)"])
                }
                guard let data else { throw URLError(.zeroByteResource) }
                return (try JSONDecoder().decode([User].self, from: data), response.statusCode)
            }

            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false
                switch result {
                case let .success((users, code)):
                    self.users = users
                    self.status = "GET HTTP \(code) · \(users.count) usuarios"
                case let .failure(error):
                    self.status = "Error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
