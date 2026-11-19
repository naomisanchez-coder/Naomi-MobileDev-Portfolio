import UIKit

final class CulturaTableViewCell: UITableViewCell {
    @IBOutlet weak var imagenCultura: UIImageView!
    @IBOutlet weak var nombreCultura: UILabel!

    func mostrar(_ cultura: Cultura) {
        nombreCultura.text = cultura.nombre
        imagenCultura.image = UIImage(named: cultura.nombreImagen)
        imagenCultura.isAccessibilityElement = imagenCultura.image != nil
        imagenCultura.accessibilityLabel = cultura.textoAlternativo
        imagenCultura.accessibilityIdentifier = "fila-" + cultura.nombreImagen
    }
}
