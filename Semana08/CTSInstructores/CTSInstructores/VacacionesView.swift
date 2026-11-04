import SwiftUI

struct VacacionesView: View {
    @State private var datos = DatosVacaciones()
    @State private var resultado: ResultadoVacaciones?
    @State private var mensaje: String?
    @FocusState private var campoActivo: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                encabezado
                formulario
                condiciones
                acciones
                if let resultado = resultado {
                    tarjetaResultado(resultado)
                }
            }
            .padding(24)
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .background(Estilo.fondo.ignoresSafeArea())
        .navigationTitle("Calculadora de vacaciones")
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
        .tint(Estilo.violeta)
        .onChange(of: datos) { _, _ in invalidarResultado() }
    }

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Descanso y beneficios", systemImage: "calendar.badge.clock")
                .font(.title2.bold())
                .foregroundStyle(Estilo.violeta)
            Text("Calcula bajo el supuesto del régimen general privado, con remuneración fija y jornadas de 5 o 6 días. No incluye regímenes especiales ni vacaciones adelantadas, vendidas o ya pagadas.")
                .font(.callout)
                .foregroundStyle(Estilo.azul)
        }
    }

    private var formulario: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Datos del trabajador").font(.title2.bold()).foregroundStyle(Estilo.azul)
            campo("Nombre del trabajador", ejemplo: "Nombres y apellidos", texto: $datos.nombre,
                  teclado: .default)
            campo("Remuneración mensual computable (S/)", ejemplo: "Ejemplo: 2400.00",
                  texto: $datos.remuneracion)
            ayuda("Incluye los conceptos legales aplicables, como asignación familiar. No se suman automáticamente ni se reciben de otro formulario.")
            Text("Tipo de cálculo").font(.headline)
            Picker("Tipo de cálculo", selection: $datos.tipo) {
                ForEach(TipoVacaciones.allCases, id: \.self) { tipo in
                    Text(tipo.rawValue).tag(tipo)
                }
            }
            .pickerStyle(.menu)
            .frame(minHeight: 44)
            campo("Meses completos computables", ejemplo: "De 0 a 12", texto: $datos.meses,
                  teclado: .numberPad)
            campo("Días adicionales computables", ejemplo: "De 0 a 29", texto: $datos.dias,
                  teclado: .numberPad)
            ayuda("Un solo período anual. Con 12 meses, los días deben ser 0. Las truncas corresponden al período incompleto, desde el último aniversario; no suman años pendientes.")
            campo("Horas semanales", ejemplo: "Ejemplo: 40", texto: $datos.horas)
            Picker("Días trabajados por semana", selection: $datos.diasSemanales) {
                Text("5 días").tag(5)
                Text("6 días").tag(6)
            }
            .pickerStyle(.segmented)
            ayuda("El promedio diario se obtiene dividiendo las horas semanales entre los días de trabajo. Esta calculadora se limita a un promedio mínimo de 4 horas.")
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private var condiciones: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Condiciones del ejemplo", systemImage: "info.circle")
                .font(.headline).foregroundStyle(Estilo.azul)
            if datos.tipo == .descanso {
                Toggle("Declaro cumplir el año de servicios y el récord vacacional exigible", isOn: $datos.cumpleRecord)
                ayuda("No basta con escribir 12 meses. El récord general requiere 210 días efectivos para semanas de 5 días, o 260 para 6 días. Se declara que el descanso completo está pendiente, sin anticipos ni pagos previos.")
            } else if datos.tipo == .truncas {
                Toggle("Declaro que existe cese y que el período no fue gozado, adelantado ni pagado", isOn: $datos.existeCese)
                ayuda("Se requiere al menos un mes de servicios. Solo se estima el período anual incompleto; las vacaciones ganadas y no gozadas son un caso distinto.")
            } else {
                ayuda("La provisión mensual es remuneración ÷ 12. No depende del período declarado ni significa un pago adicional mensual o una liquidación legal.")
            }
            ayuda("Una liquidación real puede requerir fechas, ausencias y otros antecedentes. El monto presentado es bruto referencial; no calcula descuentos, indemnizaciones ni saldo de vacaciones previas.")
            Link("SUNAFIL · Requisitos de vacaciones", destination: URL(string: "https://www.gob.pe/institucion/sunafil/noticias/889227-pensando-en-salir-de-vacaciones-sunafil-te-explica-como-acceder-a-este-derecho")!)
                .font(.callout)
            Link("MTPE · Guía del descanso vacacional", destination: URL(string: "https://cdn.www.gob.pe/uploads/document/file/2925494/guia_para_el_descanso_vacacional.pdf")!)
                .font(.callout)
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private var acciones: some View {
        VStack(alignment: .leading, spacing: 14) {
            if let mensaje = mensaje {
                Label(mensaje, systemImage: "exclamationmark.circle")
                    .font(.callout).foregroundStyle(Estilo.azul)
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white, in: RoundedRectangle(cornerRadius: 16))
            }
            Button(action: calcular) {
                Label("Calcular vacaciones", systemImage: "calculator")
                    .font(.headline).frame(maxWidth: .infinity, minHeight: 48)
            }
            .buttonStyle(.borderedProminent)
            Button("Limpiar datos", action: limpiar)
                .frame(maxWidth: .infinity, minHeight: 44)
                .font(.body.weight(.semibold))
        }
    }

    private func tarjetaResultado(_ valor: ResultadoVacaciones) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Resultado referencial").font(.title2.bold()).foregroundStyle(Estilo.azul)
            Text(datos.nombre.trimmingCharacters(in: .whitespacesAndNewlines)).font(.headline)
            Text(valor.tipo.rawValue)
            Text("Remuneración utilizada: \(moneda(valor.remuneracion))")
            Text("Tiempo declarado: \(valor.meses) meses y \(valor.dias) días")
            Text("Promedio diario: \(valor.promedioDiario.formatted(.number.precision(.fractionLength(0...2)))) horas")
            Text(moneda(valor.monto))
                .font(.system(.largeTitle, design: .rounded).bold())
                .foregroundStyle(.white)
                .padding(22)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Estilo.turquesa, in: RoundedRectangle(cornerRadius: 18))
            if valor.tipo == .descanso {
                Text("Descanso completo: 1 × \(moneda(valor.remuneracion)) = \(moneda(valor.monto))")
                ayuda("Representa la remuneración de 30 días naturales de descanso bajo los requisitos declarados, no un pago extra sobre el sueldo habitual.")
            } else if valor.tipo == .truncas {
                Text("\(moneda(valor.remuneracion)) × (\(valor.meses) ÷ 12 + \(valor.dias) ÷ 360) = \(moneda(valor.monto))")
                ayuda("Importe proporcional bruto del período incompleto al cese, bajo las condiciones declaradas. No representa toda la liquidación.")
            } else {
                Text("\(moneda(valor.remuneracion)) ÷ 12 = \(moneda(valor.monto))")
                ayuda("Provisión contable mensual estimada. El tiempo ingresado no interviene en esta fórmula; no es un pago adicional al trabajador.")
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private func campo(_ titulo: String, ejemplo: String, texto: Binding<String>,
                       teclado: UIKeyboardType = .decimalPad) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo).font(.subheadline.weight(.medium))
            TextField(ejemplo, text: texto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(teclado)
                .textInputAutocapitalization(teclado == .default ? .words : .never)
                .focused($campoActivo)
                .accessibilityLabel(titulo)
        }
    }

    private func ayuda(_ texto: String) -> some View {
        Text(texto).font(.callout).foregroundStyle(Estilo.azul.opacity(0.85))
            .fixedSize(horizontal: false, vertical: true)
    }

    private func calcular() {
        campoActivo = false
        invalidarResultado()
        mensaje = CalculoVacaciones.validar(datos)
        if mensaje == nil {
            mensaje = CalculoVacaciones.avisoCondiciones(datos)
            if mensaje == nil {
                resultado = CalculoVacaciones.estimar(datos)
                if resultado == nil { mensaje = "No se pudo obtener un importe finito. Revisa los datos." }
            }
        }
    }

    private func invalidarResultado() {
        resultado = nil
        mensaje = nil
    }

    private func limpiar() {
        datos = DatosVacaciones()
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
}

enum TipoVacaciones: String, CaseIterable {
    case descanso = "Descanso completo"
    case truncas = "Truncas al cese"
    case provision = "Provisión contable referencial"
}

struct DatosVacaciones: Equatable {
    var nombre = ""
    var remuneracion = ""
    var meses = "0"
    var dias = "0"
    var horas = ""
    var diasSemanales = 5
    var tipo: TipoVacaciones = .descanso
    var cumpleRecord = false
    var existeCese = false
}

struct ResultadoVacaciones {
    let tipo: TipoVacaciones
    let remuneracion: Double
    let meses: Int
    let dias: Int
    let promedioDiario: Double

    var monto: Double {
        switch tipo {
        case .descanso: return remuneracion
        case .truncas: return remuneracion * (Double(meses) / 12 + Double(dias) / 360)
        case .provision: return remuneracion / 12
        }
    }
}

enum CalculoVacaciones {
    static func decimal(_ texto: String) -> Double? {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        guard limpio.range(of: #"^-?[0-9]+([.,][0-9]+)?$"#, options: .regularExpression) != nil,
              let valor = Double(limpio.replacingOccurrences(of: ",", with: ".")),
              valor.isFinite else { return nil }
        return valor
    }

    static func entero(_ texto: String) -> Int? {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        guard limpio.range(of: #"^[0-9]+$"#, options: .regularExpression) != nil else { return nil }
        return Int(limpio)
    }

    static func validar(_ datos: DatosVacaciones) -> String? {
        if datos.nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Ingresa el nombre del trabajador."
        }
        guard let sueldo = decimal(datos.remuneracion), sueldo > 0 else {
            return "Ingresa una remuneración computable válida y mayor que cero."
        }
        guard let meses = entero(datos.meses), (0...12).contains(meses),
              let dias = entero(datos.dias), (0...29).contains(dias) else {
            return "Ingresa meses enteros de 0 a 12 y días enteros de 0 a 29."
        }
        if meses == 12 && dias != 0 {
            return "Con 12 meses completos, los días adicionales deben ser 0."
        }
        guard let horas = decimal(datos.horas), horas > 0 else {
            return "Ingresa horas semanales numéricas, finitas y mayores que cero."
        }
        if datos.diasSemanales != 5 && datos.diasSemanales != 6 {
            return "Esta calculadora solo considera semanas de 5 o 6 días."
        }
        if horas / Double(datos.diasSemanales) > 24 {
            return "Revisa las horas: el promedio no puede superar 24 horas diarias."
        }
        return nil
    }

    // D.Leg. 713, arts. 10, 15 y 22; D.S. 012-92-TR, art. 23; guía MTPE.
    static func avisoCondiciones(_ datos: DatosVacaciones) -> String? {
        guard validar(datos) == nil, let meses = entero(datos.meses),
              let horas = decimal(datos.horas) else { return nil }
        if horas / Double(datos.diasSemanales) < 4 {
            return "La jornada indicada es a tiempo parcial para este supuesto. SUNAFIL reconoce un tratamiento diferente (6 días de descanso); esta calculadora de 30 días no estima ese caso ni niega ese derecho."
        }
        if datos.tipo == .descanso {
            if meses != 12 || !datos.cumpleRecord {
                return "Para estimar el descanso completo ingresa 12 meses y declara cumplir el año de servicios y el récord vacacional exigible. No se deduce el récord solo del tiempo ingresado."
            }
        } else if datos.tipo == .truncas {
            if meses < 1 {
                return "Las vacaciones truncas requieren al menos un mes completo de servicios."
            }
            if meses == 12 {
                return "Un año completo no es un período trunco en esta calculadora. Revisa las vacaciones ganadas y no gozadas; no se estiman en este modo."
            }
            if !datos.existeCese {
                return "Declara el cese y que el período no fue gozado, adelantado ni pagado antes de estimar vacaciones truncas."
            }
        }
        return nil
    }

    static func estimar(_ datos: DatosVacaciones) -> ResultadoVacaciones? {
        guard validar(datos) == nil, avisoCondiciones(datos) == nil,
              let sueldo = decimal(datos.remuneracion), let meses = entero(datos.meses),
              let dias = entero(datos.dias), let horas = decimal(datos.horas) else { return nil }
        let resultado = ResultadoVacaciones(tipo: datos.tipo, remuneracion: sueldo,
                                             meses: meses, dias: dias,
                                             promedioDiario: horas / Double(datos.diasSemanales))
        return resultado.monto.isFinite ? resultado : nil
    }
}

#Preview {
    NavigationStack {
        VacacionesView()
    }
}
