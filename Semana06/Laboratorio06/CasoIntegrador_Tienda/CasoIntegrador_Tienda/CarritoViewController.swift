//
//  CarritoViewController.swift
//  CasoIntegrador_Tienda
//
//  Created by NAOMI SANCHEZ on 7/10/26.
//

// Desarrollado por: NAOMI SANCHEZ
import UIKit

class CarritoViewController: UIViewController {

    @IBOutlet weak var lblItemsCarrito: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDescuento: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblTotal: UILabel!

    var carrito: CarritoModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carrito"
        mostrarResumen()
    }

    private func mostrarResumen() {
        var textoItems = ""
        for item in carrito.items {
            textoItems += "\(item.producto.nombre) x\(item.cantidad) \t S/ \(String(format: "%.2f", item.subtotal()))\n"
        }
        lblItemsCarrito.text = textoItems.isEmpty ? "El carrito está vacío" : textoItems

        let sub = carrito.subtotal()
        let desc = carrito.montoDescuento()
        let pctDesc = Int(carrito.porcentajeDescuento() * 100)
        let igv = carrito.igv()
        let tot = carrito.total()

        lblSubtotal.text = String(format: "S/ %.2f", sub)
        lblDescuento.text = String(format: "-S/ %.2f (%d%%)", desc, pctDesc)
        lblIgv.text = String(format: "S/ %.2f", igv)
        lblTotal.text = String(format: "S/ %.2f", tot)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDatosCliente" {
            let destino = segue.destination as! DatosClienteViewController
            destino.carrito = carrito
        }
    }
}
