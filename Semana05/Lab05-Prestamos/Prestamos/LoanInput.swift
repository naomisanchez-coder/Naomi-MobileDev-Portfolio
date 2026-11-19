import Foundation

struct LoanInput {
    let principal: Double
    let annualPercent: Double
    let years: Int

    enum ValidationError: LocalizedError {
        case empty(String)
        case decimal(String)
        case principal
        case annualRate
        case years
        case outOfRange

        var errorDescription: String? {
            switch self {
            case .empty(let field):
                return "Completa el campo «\(field)»."
            case .decimal(let field):
                return "Ingresa un número válido en «\(field)». Usa un punto o una coma para los decimales, sin separadores de miles."
            case .principal:
                return "El capital inicial debe ser mayor que cero."
            case .annualRate:
                return "La tasa de interés anual debe ser cero o mayor."
            case .years:
                return "Ingresa un plazo en años enteros mayor que cero."
            case .outOfRange:
                return "Los valores están fuera del rango de cálculo. Prueba con montos, tasas o plazos más cercanos a los ejemplos."
            }
        }
    }

    init(principal: String?, annualRate: String?, years: String?) throws {
        self.principal = try Self.decimal(principal, field: "Capital inicial")
        guard self.principal > 0 else { throw ValidationError.principal }

        annualPercent = try Self.decimal(annualRate, field: "Tasa de interés anual")
        guard annualPercent >= 0 else { throw ValidationError.annualRate }

        let term = try Self.required(years, field: "Plazo en años")
        guard term.range(of: #"\A[+-]?[0-9]+\z"#, options: .regularExpression) != nil else {
            throw ValidationError.years
        }
        guard let yearCount = Int(term), yearCount <= Int.max / 12 else {
            throw ValidationError.outOfRange
        }
        guard yearCount > 0 else { throw ValidationError.years }
        self.years = yearCount
    }

    private static func required(_ raw: String?, field: String) throws -> String {
        let text = (raw ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { throw ValidationError.empty(field) }
        return text
    }

    private static func decimal(_ raw: String?, field: String) throws -> Double {
        let text = try required(raw, field: field)
        guard text.range(of: #"\A[+-]?[0-9]+([.,][0-9]+)?\z"#, options: .regularExpression) != nil else {
            throw ValidationError.decimal(field)
        }
        guard let value = Double(text.replacingOccurrences(of: ",", with: ".")),
              value.isFinite,
              value != 0 || !text.contains(where: { ("1"..."9").contains($0) }) else {
            throw ValidationError.outOfRange
        }
        return value
    }
}
