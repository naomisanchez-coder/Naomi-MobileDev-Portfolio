//
//  BoletaViewController.swift
//  CasoIntegrador_Tienda
//
//  Created by NAOMI SANCHEZ on 7/10/26.
//

// Desarrollado por: NAOMI SANCHEZ
import UIKit

class BoletaViewController: UIViewController {

    @IBOutlet weak var lblClienteInfo: UILabel!
    @IBOutlet weak var lblDetalleItems: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDescuento: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblTotal: UILabel!

    var carrito: CarritoModel!
    var cliente: ClienteModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarBoleta()
    }

    private func mostrarBoleta() {
        lblClienteInfo.text = "\(cliente.nombre) \(cliente.apellido) (\(carrito.categoriaCliente())) - DNI: \(cliente.dni)"

        var itemsTexto = ""
        for item in carrito.items {
            itemsTexto += "\(item.producto.nombre) x\(item.cantidad) \t S/ \(String(format: "%.2f", item.subtotal()))\n"
        }
        lblDetalleItems.text = itemsTexto

        lblSubtotal.text = String(format: "S/ %.2f", carrito.subtotal())
        let pctDesc = Int(carrito.porcentajeDescuento() * 100)
        lblDescuento.text = String(format: "-S/ %.2f (%d%%)", carrito.montoDescuento(), pctDesc)
        lblIgv.text = String(format: "S/ %.2f", carrito.igv())
        lblTotal.text = String(format: "S/ %.2f", carrito.total())
    }

    @IBAction func btnCerrarTapped(_ sender: UIButton) {
        // Descontar stock de los productos comprados
        for item in carrito.items {
            item.producto.stock -= item.cantidad
        }
        // Vaciar carrito
        carrito.vaciar()

        dismiss(animated: true) {
            // Reto opcional 1 / comportamiento estándar para volver al inicio
            if let navigationController = self.presentingViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
}
