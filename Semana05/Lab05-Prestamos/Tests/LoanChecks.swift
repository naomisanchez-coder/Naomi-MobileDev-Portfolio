@main
enum LoanChecks {
    static func testAmortizedReference() {
        let result = require(LoanCalculator.calculate(principal: 10_000, annualPercent: 12, years: 1))
        expectEqual(result.monthly, 888.4878867834, accuracy: 1e-8)
        expectEqual(result.total, 10_661.8546414010, accuracy: 1e-8)
        expectEqual(result.total, result.monthly * 12)
    }

    static func testZeroInterest() {
        let result = require(LoanCalculator.calculate(principal: 12_000, annualPercent: 0, years: 1))
        expectEqual(result.monthly, 1_000)
        expectEqual(result.total, 12_000)
    }

    static func testVerySmallRate() {
        let result = require(LoanCalculator.calculate(principal: 12_000, annualPercent: 1e-18, years: 1))
        expectEqual(result.monthly, 1_000, accuracy: 1e-8)
        expectEqual(result.total, 12_000, accuracy: 1e-8)
    }

    static func testUnrepresentableCalculations() {
        expectNil(LoanCalculator.calculate(principal: .greatestFiniteMagnitude, annualPercent: 12, years: 1))
        expectNil(LoanCalculator.calculate(principal: .infinity, annualPercent: 12, years: 1))
        expectNil(LoanCalculator.calculate(principal: 10_000, annualPercent: .nan, years: 1))
        expectNil(LoanCalculator.calculate(principal: 10_000, annualPercent: 12, years: Int.max))
        expectNil(LoanCalculator.calculate(principal: .leastNonzeroMagnitude, annualPercent: 0, years: 1))
    }

    static func testDecimalSeparatorsAndOuterWhitespace() throws {
        let comma = try LoanInput(principal: " 10000,50 ", annualRate: "12,5", years: " 1\n")
        let point = try LoanInput(principal: "10000.50", annualRate: "12.5", years: "1")
        expectEqual(comma.principal, 10_000.5)
        expectEqual(comma.annualPercent, 12.5)
        expectEqual(comma.years, 1)
        expectEqual(comma.principal, point.principal)
        expectEqual(comma.annualPercent, point.annualPercent)
    }

    static func testEmptyFields() {
        expectError(try LoanInput(principal: " \n", annualRate: "0", years: "1"))
        expectError(try LoanInput(principal: "1", annualRate: nil, years: "1"))
        expectError(try LoanInput(principal: "1", annualRate: "0", years: " "))
    }

    static func testMalformedFields() {
        for value in ["abc", "1o00", "1,000.00", "1.000,00", "1,2,3", "1 000", "1e3", "NaN", "inf"] {
            expectError(try LoanInput(principal: value, annualRate: "0", years: "1"), value)
            expectError(try LoanInput(principal: "1", annualRate: value, years: "1"), value)
        }
    }

    static func testSignsAndWholeYears() throws {
        for value in ["0", "-1"] {
            expectError(try LoanInput(principal: value, annualRate: "0", years: "1"), value)
        }
        expectError(try LoanInput(principal: "1", annualRate: "-1", years: "1"))
        for term in ["0", "-1", "1.5", "1,5"] {
            expectError(try LoanInput(principal: "1", annualRate: "0", years: term), term)
        }
        expectEqual(try LoanInput(principal: "1", annualRate: "0", years: "1").annualPercent, 0)
    }

    static func testNumericRange() {
        let huge = String(repeating: "9", count: 400)
        let tiny = "0." + String(repeating: "0", count: 400) + "1"
        expectError(try LoanInput(principal: huge, annualRate: "0", years: "1"))
        expectError(try LoanInput(principal: "1", annualRate: tiny, years: "1"))
        expectError(try LoanInput(principal: "1", annualRate: "0", years: huge))
        expectError(try LoanInput(principal: "1", annualRate: "0", years: String(Int.max)))
    }

    static func main() throws {
        testAmortizedReference()
        testZeroInterest()
        testVerySmallRate()
        testUnrepresentableCalculations()
        try testDecimalSeparatorsAndOuterWhitespace()
        testEmptyFields()
        testMalformedFields()
        try testSignsAndWholeYears()
        testNumericRange()
        print("9 casos superados.")
    }

    private static func require<T>(_ value: T?, line: UInt = #line) -> T {
        guard let value else { fatalError("Se esperaba un resultado en la línea \(line).") }
        return value
    }

    private static func expectEqual<T: Equatable>(_ actual: T, _ expected: T, line: UInt = #line) {
        precondition(actual == expected, "Se esperaba \(expected), se obtuvo \(actual) en la línea \(line).")
    }

    private static func expectEqual(_ actual: Double, _ expected: Double, accuracy: Double, line: UInt = #line) {
        precondition(abs(actual - expected) <= accuracy, "Se esperaba \(expected), se obtuvo \(actual) en la línea \(line).")
    }

    private static func expectNil<T>(_ value: T?, line: UInt = #line) {
        precondition(value == nil, "Se esperaba un cálculo rechazado en la línea \(line).")
    }

    private static func expectError(_ input: @autoclosure () throws -> LoanInput, _ example: String = "", line: UInt = #line) {
        do {
            _ = try input()
            fatalError("Se esperaba un error para «\(example)» en la línea \(line).")
        } catch is LoanInput.ValidationError {
            return
        } catch {
            fatalError("Error inesperado en la línea \(line): \(error)")
        }
    }
}
