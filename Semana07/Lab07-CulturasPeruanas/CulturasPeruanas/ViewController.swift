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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "mostrarCultura", sender: culturas[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "mostrarCultura",
              let detalle = segue.destination as? DetalleCulturaViewController,
              let cultura = sender as? Cultura else { return }
        detalle.cultura = cultura
    }
}
