import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var principalField: UITextField!
    @IBOutlet private weak var annualRateField: UITextField!
    @IBOutlet private weak var yearsField: UITextField!
    @IBOutlet private weak var monthlyResultLabel: UILabel!
    @IBOutlet private weak var totalResultLabel: UILabel!

    @IBAction private func calculateLoan(_ sender: UIButton) {
        view.endEditing(true)
        guard let principal = Double(principalField.text ?? ""),
              let rate = Double(annualRateField.text ?? ""),
              let years = Int(yearsField.text ?? ""),
              let result = LoanCalculator.calculate(principal: principal, annualPercent: rate, years: years) else {
            monthlyResultLabel.text = "—"
            totalResultLabel.text = "—"
            let alert = UIAlertController(title: "Revisa los datos", message: "Ingresa valores válidos para calcular el préstamo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alert, animated: true)
            return
        }

        monthlyResultLabel.text = String(format: "S/ %.2f", result.monthly)
        totalResultLabel.text = String(format: "S/ %.2f", result.total)
    }
}
