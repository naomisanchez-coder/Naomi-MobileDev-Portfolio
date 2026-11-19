import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var formScrollView: UIScrollView!
    @IBOutlet private weak var principalField: UITextField!
    @IBOutlet private weak var annualRateField: UITextField!
    @IBOutlet private weak var yearsField: UITextField!
    @IBOutlet private weak var monthlyResultLabel: UILabel!
    @IBOutlet private weak var totalResultLabel: UILabel!

    private weak var activeField: UITextField?
    private var viewportHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        formScrollView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor).isActive = true

        let keyboardToolbar = UIToolbar()
        keyboardToolbar.items = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissKeyboard))
        ]
        keyboardToolbar.sizeToFit()

        for field in [principalField, annualRateField, yearsField].compactMap({ $0 }) {
            field.delegate = self
            field.inputAccessoryView = keyboardToolbar
            field.addTarget(self, action: #selector(clearResults), for: .editingChanged)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = formScrollView.bounds.height
        guard height != viewportHeight else { return }
        viewportHeight = height
        revealActiveField()
    }

    @IBAction private func calculateLoan(_ sender: UIButton) {
        dismissKeyboard()
        clearResults()

        do {
            let input = try LoanInput(principal: principalField.text, annualRate: annualRateField.text, years: yearsField.text)
            guard let result = LoanCalculator.calculate(principal: input.principal, annualPercent: input.annualPercent, years: input.years) else {
                throw LoanInput.ValidationError.outOfRange
            }

            monthlyResultLabel.text = formatAmount(result.monthly)
            totalResultLabel.text = formatAmount(result.total)
            UIAccessibility.post(notification: .announcement,
                                 argument: "Cuota mensual: \(formatAmount(result.monthly)). Monto total a pagar: \(formatAmount(result.total)).")
        } catch {
            let alert = UIAlertController(title: "Revisa los datos", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alert, animated: true)
        }
    }

    private func formatAmount(_ value: Double) -> String {
        String(format: "S/ %.2f", locale: Locale(identifier: "en_US_POSIX"), value)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func clearResults() {
        monthlyResultLabel.text = "—"
        totalResultLabel.text = "—"
    }

    private func revealActiveField() {
        guard let field = activeField else { return }
        let visibleTarget = field.convert(field.bounds, to: formScrollView).insetBy(dx: 0, dy: -8)
        formScrollView.scrollRectToVisible(visibleTarget, animated: false)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        revealActiveField()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeField === textField {
            activeField = nil
        }
    }
}
