//
//  ViewControllerConfirmacionViewController.swift
//  Semana06_02
//
//  Created by NAOMI SANCHEZ on 30/09/26.
//

import UIKit

class ViewControllerConfirmacion: UIViewController {

    // Instanciar la clase ClienteModel
    var pCliente: ClienteModel = ClienteModel()
    
    // Definir los controles
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfDni: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asignar los datos del modelo a los controles
        self.tfApellido.text = pCliente.Apellido
        self.tfNombre.text = pCliente.Nombre
        self.tfDni.text = pCliente.Dni
    }
}

