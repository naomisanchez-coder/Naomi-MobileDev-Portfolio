import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaProfesores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        let profesor = listaProfesores[indexPath.row]
        cell.textLabel?.text = profesor.nombre
        cell.detailTextLabel?.text = profesor.cargo
        return cell
    }
}
