//
//  ViewController.swift
//  Semana06_02
//
//  Created by NAOMI SANCHEZ on 30/09/26.
//

import UIKit

class ViewController: UIViewController {

    // Outlets para los campos de texto de la primera pantalla
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtDni: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Método que intercepta la transición y envía los datos a la segunda pantalla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? ViewControllerConfirmacion {
            let cliente = ClienteModel()
            cliente.Apellido = txtApellido.text ?? ""
            cliente.Nombre = txtNombre.text ?? ""
            cliente.Dni = txtDni.text ?? ""
            
            // Se le asigna el objeto creado a la propiedad pCliente del segundo controlador
            destino.pCliente = cliente
        }
    }
}

