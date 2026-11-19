import UIKit

final class Profesor: NSObject {
    let nombre: String
    let cargo: String
    let foto: UIImage?

    init(nombre: String, cargo: String, foto: UIImage?) {
        self.nombre = nombre
        self.cargo = cargo
        self.foto = foto
    }
}
