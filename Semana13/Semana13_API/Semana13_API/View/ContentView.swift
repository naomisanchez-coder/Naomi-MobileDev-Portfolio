import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            Text("Usuarios")
                .navigationTitle("Usuarios - API")
        }
        .navigationViewStyle(.stack)
    }
}
