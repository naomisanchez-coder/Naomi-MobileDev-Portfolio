import Foundation

// MARK: - Modelo de una compra a crédito
struct CompraCredito {
    let producto: String
    let precioUnitario: Double
    let cantidad: Int
    let planMeses: Int              // 6, 12 o 24
    let mesPagoAdelantado: Int      // 0 = ninguno
    let montoAdicional: Double
    let fechaInicio: String         // "dd/MM/yyyy"
}

struct Cuota {
    let mes: Int
    let fecha: String
    let montoInicial: Double
    let pago: Double
    let restaPorPagar: Double
}

struct ResultadoPlan {
    let montoTotalCompra: Double
    let porcentajeInteres: Double
    let montoInteres: Double
    let montoFinanciado: Double
    let cuotaRegular: Double
    let cuotas: [Cuota]
    let mesesPagados: Int
    let totalPagado: Double
}

// MARK: - Reglas de negocio
func tasaInteres(paraPlan meses: Int) -> Double {
    switch meses {
    case 6:  return 0.20
    case 12: return 0.40
    case 24: return 0.60
    default: return 0.0
    }
}

enum ErrorPlanPago: Error, CustomStringConvertible {
    case planInvalido(Int)
    case mesAdelantadoInvalido(Int, Int)

    var description: String {
        switch self {
        case .planInvalido(let meses):
            return "ERROR: El plan de pago de \(meses) meses no es válido. Debe elegir 6, 12 o 24."
        case .mesAdelantadoInvalido(let mes, let planMeses):
            return "ERROR: El mes de pago adelantado (\(mes)) debe estar entre 1 y \(planMeses), o ser 0 si no aplica."
        }
    }
}

func validar(_ compra: CompraCredito) throws {
    guard [6, 12, 24].contains(compra.planMeses) else {
        throw ErrorPlanPago.planInvalido(compra.planMeses)
    }
    guard compra.mesPagoAdelantado == 0 ||
          (compra.mesPagoAdelantado >= 1 && compra.mesPagoAdelantado <= compra.planMeses) else {
        throw ErrorPlanPago.mesAdelantadoInvalido(compra.mesPagoAdelantado, compra.planMeses)
    }
}

func fmt(_ valor: Double) -> String { String(format: "%.2f", valor) }

// MARK: - Cálculo del plan de pagos
func calcularPlan(_ compra: CompraCredito, aplicarAdelanto: Bool = true) -> ResultadoPlan {
    let montoTotalCompra = compra.precioUnitario * Double(compra.cantidad)
    let porcentaje = tasaInteres(paraPlan: compra.planMeses)
    let montoInteres = montoTotalCompra * porcentaje
    let montoFinanciado = montoTotalCompra + montoInteres
    let cuotaRegular = montoFinanciado / Double(compra.planMeses)

    let formateador = DateFormatter()
    formateador.dateFormat = "dd/MM/yyyy"
    var fechaActual = formateador.date(from: compra.fechaInicio) ?? Date()

    var saldoPendiente = montoFinanciado
    var cuotas: [Cuota] = []
    var totalPagado = 0.0

    for mes in 1...compra.planMeses {
        if saldoPendiente <= 0 { break }
        let montoInicial = saldoPendiente
        var pagoEsteMes = cuotaRegular
        if aplicarAdelanto && mes == compra.mesPagoAdelantado {
            pagoEsteMes += compra.montoAdicional
        }
        if pagoEsteMes > montoInicial { pagoEsteMes = montoInicial }

        let resta = montoInicial - pagoEsteMes
        cuotas.append(Cuota(mes: mes, fecha: formateador.string(from: fechaActual),
                             montoInicial: montoInicial, pago: pagoEsteMes,
                             restaPorPagar: max(0, resta)))
        totalPagado += pagoEsteMes
        saldoPendiente = resta

        if let nuevaFecha = Calendar.current.date(byAdding: .month, value: 1, to: fechaActual) {
            fechaActual = nuevaFecha
        }
    }

    return ResultadoPlan(montoTotalCompra: montoTotalCompra, porcentajeInteres: porcentaje,
                          montoInteres: montoInteres, montoFinanciado: montoFinanciado,
                          cuotaRegular: cuotaRegular, cuotas: cuotas,
                          mesesPagados: cuotas.count, totalPagado: totalPagado)
}

// MARK: - Impresión
func imprimir(_ resultado: ResultadoPlan, producto: String, planMeses: Int, titulo: String) {
    print(String(repeating: "=", count: 83))
    print(titulo.uppercased())
    print(String(repeating: "=", count: 83))
    print("Producto: \(producto) | Plan: \(planMeses) meses")
    print("Monto Compra: S/.\(fmt(resultado.montoTotalCompra)) | Interés (\(Int(resultado.porcentajeInteres*100))%): S/.\(fmt(resultado.montoInteres))")
    print("Monto Financiado: S/.\(fmt(resultado.montoFinanciado)) | Cuota Regular: S/.\(fmt(resultado.cuotaRegular))")
    print(String(repeating: "-", count: 83))
    print("MES\tFECHA\t\tMONTO INICIAL\tPAGO TOTAL\tRESTA POR PAGAR")
    print(String(repeating: "-", count: 83))
    for c in resultado.cuotas {
        print("\(c.mes)\t\(c.fecha)\tS/.\(fmt(c.montoInicial))\tS/.\(fmt(c.pago))\tS/.\(fmt(c.restaPorPagar))")
    }
    print(String(repeating: "-", count: 83))
    print("Meses Pagados: \(resultado.mesesPagados) de \(planMeses) | Total Pagado: S/.\(fmt(resultado.totalPagado))")
    print(String(repeating: "=", count: 83) + "\n")
}

// MARK: - Caso de prueba (por ahora uno solo, sin validación todavía)
func procesarCompra(_ compra: CompraCredito) {
    do {
        try validar(compra)
        let resultado = calcularPlan(compra)
        imprimir(resultado, producto: compra.producto, planMeses: compra.planMeses,
                 titulo: "Plan de pago — \(compra.producto)")
    } catch {
        print((error as? ErrorPlanPago)?.description ?? "\(error)")
        print()
    }
}

let compra1 = CompraCredito(producto: "Laptop Pro", precioUnitario: 3500.00, cantidad: 1,
                             planMeses: 12, mesPagoAdelantado: 3, montoAdicional: 1000.00,
                             fechaInicio: "26/09/2026")
procesarCompra(compra1)

