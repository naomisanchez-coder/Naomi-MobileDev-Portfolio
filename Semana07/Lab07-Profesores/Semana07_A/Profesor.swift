import Foundation

final class Profesor: NSObject {
    let nombre: String
    let cargo: String

    init(nombre: String, cargo: String) {
        self.nombre = nombre
        self.cargo = cargo
    }
}
