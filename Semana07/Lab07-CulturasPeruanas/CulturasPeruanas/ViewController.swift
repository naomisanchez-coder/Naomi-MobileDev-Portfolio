import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        culturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "cultura", for: indexPath)
        guard let cell = reusableCell as? CulturaTableViewCell else { return reusableCell }
        cell.mostrar(culturas[indexPath.row])
        return cell
    }
}
