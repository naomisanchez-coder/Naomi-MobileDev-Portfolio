//
//  DetalleViewController.swift
//  CasoIntegrador_Tienda
//
//  Created by NAOMI SANCHEZ on 7/10/26.
//

// Desarrollado por: NAOMI SANCHEZ
import UIKit

class DetalleViewController: UIViewController {

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!

    var producto: Producto!
    var carrito: CarritoModel!
    var cantidadSeleccionada: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        if let prod = producto {
            self.title = prod.nombre
            lblNombre.text = prod.nombre
            lblPrecio.text = String(format: "S/ %.2f", prod.precio)
            lblStock.text = "\(prod.stock)"
            actualizarCantidad()
        }
    }

    @IBAction func btnDisminuirTapped(_ sender: UIButton) {
        if cantidadSeleccionada > 1 {
            cantidadSeleccionada -= 1
            actualizarCantidad()
        }
    }

    @IBAction func btnAumentarTapped(_ sender: UIButton) {
        cantidadSeleccionada += 1
        actualizarCantidad()
    }

    private func actualizarCantidad() {
        lblCantidad.text = "\(cantidadSeleccionada)"
    }

    @IBAction func btnAgregarCarritoTapped(_ sender: UIButton) {
        let exito = carrito.agregar(producto: producto, cantidad: cantidadSeleccionada)
        if exito {
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(
                title: "Stock Insuficiente",
                message: "No hay suficiente stock disponible para agregar este producto.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
