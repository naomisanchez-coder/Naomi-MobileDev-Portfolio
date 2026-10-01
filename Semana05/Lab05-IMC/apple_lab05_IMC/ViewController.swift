//
//  ViewController.swift
//  apple_lab05_IMC
//
//  Created by NAOMI SANCHEZ on 23/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPeso: UITextField!
    @IBOutlet weak var txtEstatura: UITextField!
    @IBOutlet weak var lblResultado: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calcularIMC(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let pesoTexto = txtPeso.text, let peso = Double(pesoTexto),
              let estaturaTexto = txtEstatura.text, let estatura = Double(estaturaTexto),
              estatura > 0 else {
            lblResultado.text = "Por favor, ingresa un peso y estatura válidos."
            return
        }
        
        let imc = peso / (estatura * estatura)
        
        var diagnostico = ""
        switch imc {
        case ..<18.5:
            diagnostico = "Bajo peso"
        case 18.5..<25.0:
            diagnostico = "Peso normal"
        case 25.0..<30.0:
            diagnostico = "Sobrepeso"
        default:
            diagnostico = "Obesidad"
        }
        
        lblResultado.text = String(format: "Tu IMC es: %.2f\nDiagnóstico: %@", imc, diagnostico)
    }
}
