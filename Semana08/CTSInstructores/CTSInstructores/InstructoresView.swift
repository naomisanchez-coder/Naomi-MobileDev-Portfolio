import SwiftUI

struct InstructoresView: View {
    @State private var nombre = ""
    @State private var horas = ""
    @State private var error: String?
    @State private var sueldo: Double?
    @State private var sistema: SistemaPensiones = .onp
    @State private var afp: AdministradoraAFP = .habitat
    @State private var comision: TipoComision = .flujo
    @State private var considerarGratificaciones = true
    @FocusState private var campoActivo: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                encabezado
                formulario
                if let sueldo = sueldo {
                    let aportes = CalculoInstructor.prevision(bruto: sueldo, sistema: sistema,
                                                              afp: afp, comision: comision)
                    resultado(sueldo)
                    resumenPrevisional(sueldo, aportes: aportes)
                    resumenTributario(sueldo, aportes: aportes)
                }
            }
            .padding(24)
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .background(Estilo.fondo.ignoresSafeArea())
        .navigationTitle("Pago de instructores")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(Estilo.fondo, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Listo") { campoActivo = false }
            }
        }
        .onChange(of: horas) { _, _ in invalidarResultado() }
        .onChange(of: nombre) { _, _ in invalidarResultado() }
        .onChange(of: sistema) { _, _ in invalidarResultado() }
        .onChange(of: afp) { _, _ in invalidarResultado() }
        .onChange(of: comision) { _, _ in invalidarResultado() }
        .onChange(of: considerarGratificaciones) { _, _ in invalidarResultado() }
    }

    private var encabezado: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "person.2.fill")
                .font(.title)
                .foregroundStyle(Estilo.turquesa)
                .padding(14)
                .background(Estilo.turquesa.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
                .accessibilityHidden(true)
            Text("Calcula tu remuneración mensual según las horas trabajadas.")
                .font(.body)
                .foregroundStyle(Estilo.azul)
        }
    }

    private var formulario: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Datos del instructor")
                .font(.title2.bold())
                .foregroundStyle(Estilo.azul)

            VStack(alignment: .leading, spacing: 8) {
                Text("Nombre del instructor")
                    .font(.subheadline.weight(.medium))
                TextField("Ingresa tu nombre", text: $nombre)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .focused($campoActivo)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityLabel("Nombre del instructor")
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Horas trabajadas por semana")
                    .font(.subheadline.weight(.medium))
                TextField("Ejemplo: 12.5", text: $horas)
                    .keyboardType(.decimalPad)
                    .focused($campoActivo)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityLabel("Horas trabajadas por semana")
                Text("Admite decimales (12.5 = 12 h 30 min). Máximo: 23 h.")
                    .font(.callout)
                    .foregroundStyle(Estilo.azul.opacity(0.85))
            }

            VStack(alignment: .leading, spacing: 10) {
                Label("Parámetros del ejercicio", systemImage: "info.circle")
                    .font(.subheadline.bold())
                Text("Pago por hora: S/ 50.00")
                Text("Máximo semanal: 23 horas")
                Text("Semanas consideradas: 4")
            }
            .font(.subheadline)
            .foregroundStyle(Estilo.azul)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.fondo, in: RoundedRectangle(cornerRadius: 14))

            seleccionPrevisional
            supuestoTributario

            if let error = error {
                Label(error, systemImage: "exclamationmark.circle.fill")
                    .font(.subheadline)
                    .foregroundStyle(.red)
                    .accessibilityIdentifier("errorHoras")
            }

            Button(action: calcular) {
                Label("Calcular sueldo", systemImage: "calculator")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 48)
            }
            .buttonStyle(.borderedProminent)
            .tint(Estilo.turquesa)

            Button("Limpiar datos", action: limpiar)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity, minHeight: 44)
                .foregroundStyle(Estilo.azul)
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
        .shadow(color: Estilo.azul.opacity(0.05), radius: 8, y: 4)
    }

    private var seleccionPrevisional: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Sistema de pensiones", systemImage: "shield.lefthalf.filled")
                .font(.headline)
                .foregroundStyle(Estilo.azul)
            Picker("Sistema de pensiones", selection: $sistema) {
                ForEach(SistemaPensiones.allCases, id: \.self) { opcion in
                    Text(opcion.rawValue).tag(opcion)
                }
            }
            .pickerStyle(.segmented)

            if sistema == .afp {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Administradora")
                        .font(.subheadline.weight(.medium))
                    Picker("Administradora", selection: $afp) {
                        ForEach(AdministradoraAFP.allCases, id: \.self) { opcion in
                            Text(opcion.rawValue).tag(opcion)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(minHeight: 44)
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("Tipo de comisión")
                        .font(.subheadline.weight(.medium))
                    Picker("Tipo de comisión", selection: $comision) {
                        ForEach(TipoComision.allCases, id: \.self) { opcion in
                            Text(opcion.rawValue).tag(opcion)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(minHeight: 44)
                }
                Text("Tasas AFP: octubre de 2026. No se actualizan automáticamente.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                if comision == .saldo {
                    Text("La comisión sobre remuneración es 0. Existe una comisión anual sobre el saldo administrado que esta calculadora no estima.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Link("Fuente oficial: SBS", destination: URL(string: "https://www.sbs.gob.pe/app/spp/empleadores/comisiones_spp/Paginas/comision_prima.aspx")!)
                    .font(.footnote)
            }
        }
        .tint(Estilo.turquesa)
    }

    private func resumenPrevisional(_ bruto: Double, aportes: ResumenPrevisional) -> some View {
        return VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 14) {
                Label("Resumen previsional", systemImage: "shield.lefthalf.filled")
                    .font(.title2.bold())
                    .foregroundStyle(Estilo.azul)
                Text("Sistema seleccionado: \(sistema.rawValue)")
                    .font(.headline)
                if sistema == .afp {
                    Text("AFP: \(afp.rawValue)")
                    Text(comision.rawValue)
                    Text("Aporte obligatorio (10 %): \(moneda(aportes.aporte))")
                    Text("Prima de seguro (1.37 %): \(moneda(aportes.seguro))")
                    Text("Comisión mensual sobre remuneración: \(moneda(aportes.comision))")
                    if comision == .flujo {
                        Text("Tasa de comisión: \(numero(afp.tasaFlujo * 100)) %")
                            .font(.footnote)
                    } else {
                        Text("Existe una comisión anual sobre el saldo administrado que no se está estimando en esta calculadora.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    Text("Tasas AFP de octubre de 2026. No se actualizan automáticamente.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    Text("Aporte obligatorio ONP (13 %): \(moneda(aportes.aporte))")
                }
                Divider()
                Text("Total de descuento previsional: \(moneda(aportes.total))")
                    .font(.headline)
            }
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 22))

            VStack(alignment: .leading, spacing: 12) {
                Label("EsSalud · Empleador", systemImage: "cross.case")
                    .font(.headline)
                    .foregroundStyle(Estilo.azul)
                Text("9 % del sueldo bruto: \(moneda(aportes.essalud))")
                Text("Aporte del empleador. No se descuenta al instructor")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 22))

            VStack(alignment: .leading, spacing: 12) {
                Text("Remuneración después de aportes previsionales")
                    .font(.headline)
                Text(moneda(aportes.remuneracion))
                    .font(.largeTitle.bold())
                Text("\(moneda(bruto)) − \(moneda(aportes.total)) = \(moneda(aportes.remuneracion))")
                    .font(.subheadline)
                Text("Importe previo a la retención de quinta categoría, si corresponde")
                    .font(.footnote)
            }
            .foregroundStyle(.white)
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.azul, in: RoundedRectangle(cornerRadius: 22))
        }
    }

    private var supuestoTributario: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Proyección tributaria 2026")
                .font(.headline)
                .foregroundStyle(Estilo.azul)
            Toggle("Incluir gratificaciones anuales", isOn: $considerarGratificaciones)
                .tint(Estilo.turquesa)
            Text("Considera dos gratificaciones completas y su bonificación del 9 % para estimar el impuesto anual.")
                .font(.callout)
                .foregroundStyle(Estilo.azul.opacity(0.85))
            Text("Simulación con sueldo constante y un empleador. Retención referencial de enero a marzo de 2026.")
                .font(.callout)
                .foregroundStyle(Estilo.azul.opacity(0.85))
            Text("La opción no determina automáticamente el derecho a gratificaciones.")
                .font(.callout)
                .foregroundStyle(.secondary)

            // Sin binding: comienza cerrado y no cambia los datos del cálculo.
            DisclosureGroup("Ver supuestos del cálculo") {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Trabajo dependiente sujeto a quinta categoría durante doce meses. Sin otros ingresos, retenciones anteriores ni cambios salariales.")
                    Text("Escenario ordinario de enero a marzo de 2026, sin retención extraordinaria adicional del mes. La retención real depende del mes y de los antecedentes del trabajador.")
                    Text("Con la opción activada se proyectan 12 sueldos, 2 gratificaciones completas y el 9 % de cada gratificación. Desactivada, solo se consideran 12 sueldos.")
                    Text("La bonificación extraordinaria es distinta del aporte mensual de EsSalud del empleador.")
                }
                .font(.callout)
                .foregroundStyle(Estilo.azul.opacity(0.85))
                .padding(.top, 10)
            }
            .tint(Estilo.azul)
        }
    }

    private func resumenTributario(_ bruto: Double, aportes: ResumenPrevisional) -> some View {
        let tributo = CalculoQuinta.proyectar(sueldo: bruto,
                                            gratificaciones: considerarGratificaciones)
        let neto = CalculoQuinta.netoReferencial(bruto: bruto, descuentoPrevisional: aportes.total,
                                                retencion: tributo.retencionMensual)

        return VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 14) {
                Label("Impuesto a la Renta — Quinta categoría", systemImage: "doc.text")
                    .font(.title2.bold())
                    .foregroundStyle(Estilo.azul)
                Text("Año tributario 2026")
                    .font(.headline)
                Text("UIT: \(moneda(CalculoQuinta.uit))")
                Text("Deducción anual (7 UIT): \(moneda(CalculoQuinta.deduccion))")
                Text(considerarGratificaciones
                     ? "Supuesto: 12 sueldos + 2 gratificaciones completas + bonificación del 9 % de cada gratificación."
                     : "Supuesto: solamente 12 remuneraciones mensuales.")
                    .font(.subheadline)
                Divider()
                Text("Ingresos anuales proyectados: \(moneda(tributo.ingresos))")
                Text("Renta imponible anual: \(moneda(tributo.rentaImponible))")
                Text("Impuesto anual estimado: \(moneda(tributo.impuestoAnual))")
                Text("Retención mensual referencial enero-marzo: \(moneda(tributo.retencionMensual))")
                    .font(.headline)
                Text("Impuesto anual ÷ 12: referencia exclusiva de enero–marzo para este supuesto.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text("La retención real varía con el mes, los ingresos y las retenciones previas.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Link("Fuente oficial: SUNAT", destination: URL(string: "https://personas.sunat.gob.pe/trabajador-dependiente/como-me-deben-hacer-retencion-impuesto")!)
                    .font(.footnote)
            }
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 22))

            VStack(alignment: .leading, spacing: 14) {
                Text("Remuneración neta referencial")
                    .font(.title2.bold())
                Text(moneda(neto))
                    .font(.system(.largeTitle, design: .rounded).bold())
                    .padding(.vertical, 6)
                Text("Sueldo bruto: \(moneda(bruto))")
                Text("Aporte previsional: − \(moneda(aportes.total))")
                Text("Retención referencial: − \(moneda(tributo.retencionMensual))")
                Text("\(moneda(bruto)) − \(moneda(aportes.total)) − \(moneda(tributo.retencionMensual)) = \(moneda(neto))")
                    .font(.subheadline)
                Text("Estimación para el escenario indicado. EsSalud no se descuenta al instructor.")
                    .font(.footnote)
            }
            .foregroundStyle(.white)
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.turquesa, in: RoundedRectangle(cornerRadius: 22))
        }
    }

    private func resultado(_ sueldo: Double) -> some View {
        // Solo se presenta tras validar. Los cambios en los campos lo ocultan.
        let horasSemanales = CalculoInstructor.convertir(horas) ?? 0
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespacesAndNewlines)

        return VStack(alignment: .leading, spacing: 18) {
            Label("Resultado del cálculo", systemImage: "checkmark.circle")
                .font(.title2.bold())
                .foregroundStyle(Estilo.azul)
            if !nombreLimpio.isEmpty {
                Text(nombreLimpio)
                    .font(.headline)
            }
            Text("Horas semanales: \(numero(horasSemanales))")
            Text("Horas mensuales estimadas: \(numero(horasSemanales * 4))")
            Text("Pago por hora: S/ 50.00")

            VStack(alignment: .leading, spacing: 8) {
                Text("Sueldo bruto mensual")
                    .font(.headline)
                Text(moneda(sueldo))
                    .font(.largeTitle.bold())
                    .accessibilityIdentifier("sueldoBruto")
            }
            .foregroundStyle(.white)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.turquesa, in: RoundedRectangle(cornerRadius: 18))

            Text("\(numero(horasSemanales)) × 50 × 4 = \(moneda(sueldo))")
                .font(.body.weight(.medium))
            Text("Cálculo académico basado en cuatro semanas por mes.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private func calcular() {
        campoActivo = false
        sueldo = nil
        error = CalculoInstructor.validarNombre(nombre) ?? CalculoInstructor.validar(horas)
        if error == nil, let valor = CalculoInstructor.convertir(horas) {
            sueldo = CalculoInstructor.sueldoBruto(horas: valor)
        }
    }

    private func invalidarResultado() {
        sueldo = nil
        error = nil
    }

    private func limpiar() {
        nombre = ""
        horas = ""
        sistema = .onp
        afp = .habitat
        comision = .flujo
        considerarGratificaciones = true
        invalidarResultado()
        campoActivo = false
    }

    private func moneda(_ valor: Double) -> String {
        let formato = NumberFormatter()
        formato.locale = Locale(identifier: "en_US")
        formato.numberStyle = .decimal
        formato.minimumFractionDigits = 2
        formato.maximumFractionDigits = 2
        return "S/ " + (formato.string(from: NSNumber(value: valor)) ?? "0.00")
    }

    private func numero(_ valor: Double) -> String {
        valor.formatted(.number.locale(Locale(identifier: "es_PE"))
            .precision(.fractionLength(0...10)))
    }
}

enum SistemaPensiones: String, CaseIterable {
    case onp = "ONP"
    case afp = "AFP"
}

enum AdministradoraAFP: String, CaseIterable {
    case habitat = "Habitat"
    case integra = "Integra"
    case prima = "Prima"
    case profuturo = "Profuturo"

    // SBS, mes de devengue octubre de 2026. Tasas fijas del ejercicio.
    var tasaFlujo: Double {
        switch self {
        case .habitat: return 0.0147
        case .integra: return 0.0155
        case .prima: return 0.0160
        case .profuturo: return 0.0169
        }
    }
}

enum TipoComision: String, CaseIterable {
    case flujo = "Comisión sobre flujo"
    case saldo = "Comisión sobre saldo"
}

struct ResumenPrevisional {
    let bruto: Double
    let aporte: Double
    let seguro: Double
    let comision: Double

    var total: Double { aporte + seguro + comision }
    var essalud: Double { bruto * 0.09 }
    var remuneracion: Double { bruto - total }
}

// Funciones puras y sencillas que permiten comprobar las reglas del ejercicio.
enum CalculoInstructor {
    // Base académica: sueldo bruto positivo, hasta S/ 4,600.
    // SBS: https://www.sbs.gob.pe/app/spp/empleadores/comisiones_spp/Paginas/comision_prima.aspx
    static func prevision(bruto: Double, sistema: SistemaPensiones,
                          afp: AdministradoraAFP, comision: TipoComision) -> ResumenPrevisional {
        if sistema == .onp {
            return ResumenPrevisional(bruto: bruto, aporte: bruto * 0.13,
                                      seguro: 0, comision: 0)
        }
        let comisionMensual = comision == .flujo ? bruto * afp.tasaFlujo : 0
        return ResumenPrevisional(bruto: bruto, aporte: bruto * 0.10,
                                  seguro: bruto * 0.0137, comision: comisionMensual)
    }

    static func validarNombre(_ nombre: String) -> String? {
        if nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Ingresa el nombre del instructor"
        }
        return nil
    }

    static func convertir(_ texto: String) -> Double? {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        // Se admite un separador decimal, punto o coma, sin separadores de miles.
        guard limpio.range(of: #"^-?[0-9]+([.,][0-9]+)?$"#,
                           options: .regularExpression) != nil,
              let valor = Double(limpio.replacingOccurrences(of: ",", with: ".")),
              valor.isFinite else {
            return nil
        }
        return valor
    }

    static func validar(_ texto: String) -> String? {
        if texto.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Ingresa las horas trabajadas por semana."
        }
        guard let valor = convertir(texto) else {
            return "Ingresa un número válido, por ejemplo 12.5 o 12,5."
        }
        if valor <= 0 {
            return "Las horas deben ser mayores que cero."
        }
        if valor > 23 {
            return "El máximo permitido es 23 horas semanales."
        }
        return nil
    }

    static func sueldoBruto(horas: Double) -> Double {
        horas * 50 * 4
    }
}

struct ProyeccionQuinta {
    let ingresos: Double
    let rentaImponible: Double
    let impuestoAnual: Double
    let retencionMensual: Double
}

enum CalculoQuinta {
    // SUNAT: UIT 2026 y deducción de 7 UIT. Parámetros fijos del ejercicio.
    static let uit = 5500.0
    static let deduccion = 7 * uit

    static func ingresosAnuales(sueldo: Double, gratificaciones: Bool) -> Double {
        guard sueldo.isFinite, sueldo >= 0 else { return 0 }
        let ingresos: Double
        if gratificaciones {
            ingresos = sueldo * 12 + sueldo * 2 + sueldo * 2 * 0.09
        } else {
            ingresos = sueldo * 12
        }
        return ingresos.isFinite ? ingresos : 0
    }

    static func rentaImponible(ingresos: Double) -> Double {
        guard ingresos.isFinite else { return 0 }
        return max(0, ingresos - deduccion)
    }

    static func impuestoAnual(renta: Double) -> Double {
        guard renta.isFinite, renta > 0 else { return 0 }
        // Cada tasa grava solo la parte comprendida en su tramo.
        var impuesto = min(renta, 5 * uit) * 0.08
        if renta > 5 * uit {
            impuesto += min(renta - 5 * uit, 15 * uit) * 0.14
        }
        if renta > 20 * uit {
            impuesto += min(renta - 20 * uit, 15 * uit) * 0.17
        }
        if renta > 35 * uit {
            impuesto += min(renta - 35 * uit, 10 * uit) * 0.20
        }
        if renta > 45 * uit {
            impuesto += (renta - 45 * uit) * 0.30
        }
        return impuesto
    }

    static func retencionEneroMarzo(impuestoAnual: Double) -> Double {
        guard impuestoAnual.isFinite else { return 0 }
        // Solo escenario ordinario enero-marzo, sin ajustes ni retenciones previas.
        return max(0, impuestoAnual) / 12
    }

    static func proyectar(sueldo: Double, gratificaciones: Bool) -> ProyeccionQuinta {
        let ingresos = ingresosAnuales(sueldo: sueldo, gratificaciones: gratificaciones)
        let renta = rentaImponible(ingresos: ingresos)
        let impuesto = impuestoAnual(renta: renta)
        return ProyeccionQuinta(ingresos: ingresos, rentaImponible: renta,
                                impuestoAnual: impuesto,
                                retencionMensual: retencionEneroMarzo(impuestoAnual: impuesto))
    }

    static func netoReferencial(bruto: Double, descuentoPrevisional: Double,
                                retencion: Double) -> Double {
        bruto - descuentoPrevisional - retencion
    }
}

#Preview {
    NavigationStack {
        InstructoresView()
    }
}
