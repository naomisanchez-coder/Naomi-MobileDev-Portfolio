//
//  DatosClienteViewController.swift
//  CasoIntegrador_Tienda
//
//  Created by NAOMI SANCHEZ on 7/10/26.
//

// Desarrollado por: NAOMI SANCHEZ
import UIKit

class DatosClienteViewController: UIViewController {

    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtDni: UITextField!

    var carrito: CarritoModel!
    let cliente = ClienteModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Datos del cliente"
    }

    @IBAction func btnConfirmarCompraTapped(_ sender: UIButton) {
        guard let apellidos = txtApellidos.text, !apellidos.isEmpty,
              let nombres = txtNombres.text, !nombres.isEmpty,
              let dni = txtDni.text, !dni.isEmpty else {
            mostrarAlerta(mensaje: "Todos los campos son obligatorios.")
            return
        }

        if dni.count != 8 || Int(dni) == nil {
            mostrarAlerta(mensaje: "El DNI debe tener exactamente 8 dígitos.")
            return
        }

        cliente.apellido = apellidos
        cliente.nombre = nombres
        cliente.dni = dni

        performSegue(withIdentifier: "verBoleta", sender: nil)
    }

    private func mostrarAlerta(mensaje: String) {
        let alert = UIAlertController(title: "Validación", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verBoleta" {
            let destino = segue.destination as! BoletaViewController
            destino.carrito = carrito
            destino.cliente = cliente
        }
    }
}
