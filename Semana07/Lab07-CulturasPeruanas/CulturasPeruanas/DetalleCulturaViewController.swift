import UIKit

final class DetalleCulturaViewController: UIViewController {
    @IBOutlet private weak var nombreLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var descripcionLabel: UILabel!
    @IBOutlet private weak var imagenView: UIImageView!

    var cultura: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cultura else { return }

        nombreLabel.text = cultura.nombre
        regionLabel.text = "Región: \(cultura.region)"
        descripcionLabel.text = cultura.descripcion
        imagenView.image = UIImage(named: cultura.nombreImagen)
        imagenView.isAccessibilityElement = imagenView.image != nil
        imagenView.accessibilityLabel = cultura.textoAlternativo
        imagenView.accessibilityIdentifier = "detalle-" + cultura.nombreImagen
    }
}
