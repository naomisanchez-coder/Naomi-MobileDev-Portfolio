import Foundation

struct LoanPayment {
    let monthly: Double
    let total: Double
}

enum LoanCalculator {
    static func calculate(principal: Double, annualPercent: Double, years: Int) -> LoanPayment? {
        guard principal.isFinite, principal > 0,
              annualPercent.isFinite, annualPercent >= 0,
              years > 0, years <= Int.max / 12 else { return nil }

        let payments = Double(years * 12)
        if annualPercent == 0 {
            let monthly = principal / payments
            guard monthly > 0 else { return nil }
            return LoanPayment(monthly: monthly, total: principal)
        }

        let rate = (annualPercent / 100) / 12
        guard rate > 0 else { return nil }

        // Divide by (1 + r)^n and evaluate the resulting denominator without cancellation.
        let denominator = -expm1(-payments * log1p(rate))
        let monthly = principal * (rate / denominator)
        let total = monthly * payments
        guard monthly.isFinite, monthly > 0, total.isFinite else { return nil }
        return LoanPayment(monthly: monthly, total: total)
    }
}
