import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personasArreglo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "miCell", for: indexPath)
        guard let cell = reusableCell as? PersonasTableViewCell else { return reusableCell }

        let nombre = personasArreglo[indexPath.row]
        let imagen = personasImagenarreglo[indexPath.row]
        cell.personaNombre.text = nombre
        cell.PersonaImagen.image = UIImage(named: imagen)
        cell.PersonaImagen.isAccessibilityElement = cell.PersonaImagen.image != nil
        cell.PersonaImagen.accessibilityIdentifier = imagen
        cell.PersonaImagen.accessibilityLabel = "Avatar provisional de \(nombre)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alerta = UIAlertController(
            title: "El Docente que Selecciono es :",
            message: personasArreglo[indexPath.row],
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alerta, animated: true)
    }
}
