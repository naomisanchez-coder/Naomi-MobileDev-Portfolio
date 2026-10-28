import SwiftUI

struct CTSView: View {
    @State private var datos = DatosCTS()
    @State private var resultado: ResultadoCTS?
    @State private var mensaje: String?
    @FocusState private var campoActivo: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                encabezado
                datosTrabajador
                periodo
                jornada
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
        .navigationTitle("Calculadora CTS")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Listo") { campoActivo = false }
            }
        }
        // Cualquier edición invalida la estimación y los avisos anteriores.
        .onChange(of: datos) { _, _ in invalidarResultado() }
    }

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "calculator")
                .font(.largeTitle)
                .foregroundStyle(Estilo.azul)
                .padding(16)
                .background(.white, in: RoundedRectangle(cornerRadius: 18))
                .accessibilityHidden(true)
            Text("Calculadora CTS")
                .font(.largeTitle.bold())
                .foregroundStyle(Estilo.azul)
            Text("Calcula tu compensación según tu remuneración y tiempo de servicios.")
                .foregroundStyle(.secondary)
            Text("Estimación para el régimen laboral general de la actividad privada del Perú. No comprende otros regímenes ni situaciones excepcionales.")
                .font(.footnote)
                .foregroundStyle(Estilo.azul)
        }
    }

    private var datosTrabajador: some View {
        VStack(alignment: .leading, spacing: 18) {
            titulo("Datos del trabajador", simbolo: "person.text.rectangle")
            campo("Nombre del trabajador", ejemplo: "Nombres y apellidos", texto: $datos.nombre,
                  decimal: false)
            campo("Remuneración mensual computable (S/)", ejemplo: "Ejemplo: 2400.00",
                  texto: $datos.sueldo)
            campo("Gratificación computable percibida en el semestre (S/)",
                  ejemplo: "Ingresa el importe, incluso si es 0", texto: $datos.gratificacion)
            Text("Ingresa la gratificación efectivamente computable según el período. No se supone igual al sueldo; no incluyas el aporte EsSalud ni la bonificación extraordinaria.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Text("Se supone remuneración fija. No se añaden automáticamente asignación familiar, horas extras regulares ni otros conceptos computables: si corresponden, incorpóralos en la remuneración ingresada.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private var periodo: some View {
        VStack(alignment: .leading, spacing: 18) {
            titulo("Período computable", simbolo: "calendar")
            campo("Meses completos computables", ejemplo: "De 0 a 6", texto: $datos.meses,
                  entero: true)
            campo("Días adicionales computables", ejemplo: "De 0 a 29", texto: $datos.dias,
                  entero: true)
            Text("Ingresa tiempo efectivamente computable del semestre, no tiempo calendario sin revisar. El total debe ser mayor que cero y no superar seis meses.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Text("Se requiere al menos un mes de prestación efectiva. Si al cierre del semestre aún no se completa un mes, el cálculo y depósito se acumulan al siguiente período; aquí se mostrará una explicación sin monto de depósito inmediato.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private var jornada: some View {
        VStack(alignment: .leading, spacing: 18) {
            titulo("Jornada laboral", simbolo: "clock")
            campo("Horas trabajadas por semana", ejemplo: "Ejemplo: 20 o 23.5", texto: $datos.horas)
            Text("Días de trabajo por semana")
                .font(.subheadline.weight(.medium))
            Picker("Días de trabajo por semana", selection: $datos.diasSemanales) {
                Text("5 días").tag(5)
                Text("6 días").tag(6)
            }
            .pickerStyle(.segmented)
            Text("Para esta distribución de 5 o 6 días, el promedio diario es horas semanales ÷ días semanales. Debe alcanzar al menos 4 horas. La elegibilidad no depende únicamente de trabajar 23 horas semanales.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private var acciones: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let mensaje = mensaje {
                Label(mensaje, systemImage: "info.circle")
                    .font(.subheadline)
                    .foregroundStyle(Estilo.azul)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white, in: RoundedRectangle(cornerRadius: 16))
            }
            Button(action: calcular) {
                Label("Calcular CTS", systemImage: "calculator")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 48)
            }
            .buttonStyle(.borderedProminent)
            .tint(Estilo.azul)
            Button("Limpiar datos", action: limpiar)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity, minHeight: 44)
                .foregroundStyle(Estilo.azul)
        }
    }

    private func tarjetaResultado(_ valor: ResultadoCTS) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            titulo("Resultado de la estimación", simbolo: "checkmark.circle")
            Text(datos.nombre.trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.headline)
            Text("Remuneración ingresada: \(moneda(valor.sueldo))")
            Text("Gratificación computable: \(moneda(valor.gratificacion))")
            Text("Sexta parte de la gratificación: \(moneda(valor.sexto))")
            Text("Remuneración computable total: \(moneda(valor.computable))")
            Text("Período: \(valor.meses) meses completos y \(valor.dias) días adicionales")
            Text("Promedio diario: \(numero(valor.promedioDiario)) horas")

            VStack(alignment: .leading, spacing: 10) {
                Text("CTS estimada")
                    .font(.headline)
                Text(moneda(valor.cts))
                    .font(.largeTitle.bold())
            }
            .foregroundStyle(.white)
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.turquesa, in: RoundedRectangle(cornerRadius: 20))

            Text("Desarrollo del cálculo")
                .font(.headline)
            Text("Remuneración computable = \(moneda(valor.sueldo)) + \(moneda(valor.gratificacion)) ÷ 6 = \(moneda(valor.computable))")
            Text("CTS = (\(numero(valor.sueldo)) + \(numero(valor.gratificacion)) ÷ 6) × (\(valor.meses) ÷ 12 + \(valor.dias) ÷ 360) ≈ \(moneda(valor.cts))")
            Text("Los importes se presentan con dos decimales; el cálculo conserva la precisión interna.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Text("Estimación bajo los supuestos ingresados. El depósito real depende de los conceptos remunerativos, el tiempo computable y las condiciones laborales aplicables.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
    }

    private func titulo(_ texto: String, simbolo: String) -> some View {
        Label(texto, systemImage: simbolo)
            .font(.title2.bold())
            .foregroundStyle(Estilo.azul)
    }

    private func campo(_ titulo: String, ejemplo: String, texto: Binding<String>,
                       decimal: Bool = true, entero: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo).font(.subheadline.weight(.medium))
            TextField(ejemplo, text: texto)
                .textFieldStyle(.roundedBorder)
                .keyboardType(entero ? .numberPad : (decimal ? .decimalPad : .default))
                .textInputAutocapitalization(decimal ? .never : .words)
                .autocorrectionDisabled(decimal)
                .focused($campoActivo)
                .accessibilityLabel(titulo)
        }
    }

    private func calcular() {
        campoActivo = false
        resultado = nil
        mensaje = CalculoCTS.validar(datos)
        if mensaje == nil {
            mensaje = CalculoCTS.avisoElegibilidad(datos)
            if mensaje == nil {
                resultado = CalculoCTS.estimar(datos)
                if resultado == nil {
                    mensaje = "Los importes ingresados son demasiado grandes para calcular."
                }
            }
        }
    }

    private func invalidarResultado() {
        resultado = nil
        mensaje = nil
    }

    private func limpiar() {
        datos = DatosCTS()
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
        valor.formatted(.number.locale(Locale(identifier: "en_US"))
            .grouping(.never).precision(.fractionLength(0...10)))
    }
}

// Un solo conjunto de datos permite invalidar el resultado al editar cualquier campo.
struct DatosCTS: Equatable {
    var nombre = ""
    var sueldo = ""
    var gratificacion = ""
    var meses = "0"
    var dias = "0"
    var horas = ""
    var diasSemanales = 5
}

struct ResultadoCTS {
    let sueldo: Double
    let gratificacion: Double
    let meses: Int
    let dias: Int
    let promedioDiario: Double
    var sexto: Double { gratificacion / 6 }
    var computable: Double { sueldo + sexto }
    var cts: Double { computable * (Double(meses) / 12 + Double(dias) / 360) }
}

enum CalculoCTS {
    static func decimal(_ texto: String) -> Double? {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        guard limpio.range(of: #"^-?[0-9]+([.,][0-9]+)?$"#,
                           options: .regularExpression) != nil,
              let valor = Double(limpio.replacingOccurrences(of: ",", with: ".")),
              valor.isFinite else { return nil }
        return valor
    }

    static func entero(_ texto: String) -> Int? {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        guard limpio.range(of: #"^[0-9]+$"#, options: .regularExpression) != nil else { return nil }
        return Int(limpio)
    }

    static func validar(_ datos: DatosCTS) -> String? {
        if datos.nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Ingresa el nombre del trabajador."
        }
        guard let sueldo = decimal(datos.sueldo), sueldo > 0 else {
            return "Ingresa una remuneración mensual válida y mayor que cero."
        }
        guard let gratificacion = decimal(datos.gratificacion), gratificacion >= 0 else {
            return "Ingresa la gratificación computable: un número válido mayor o igual a cero."
        }
        guard let meses = entero(datos.meses), (0...6).contains(meses) else {
            return "Los meses deben ser un número entero entre 0 y 6."
        }
        guard let dias = entero(datos.dias), (0...29).contains(dias) else {
            return "Los días deben ser un número entero entre 0 y 29."
        }
        if meses * 30 + dias == 0 {
            return "Ingresa un período computable mayor que cero."
        }
        if meses * 30 + dias > 180 {
            return "El período computable no puede superar seis meses."
        }
        guard let horas = decimal(datos.horas), horas > 0 else {
            return "Ingresa una jornada semanal numérica, finita y mayor que cero."
        }
        if datos.diasSemanales != 5 && datos.diasSemanales != 6 {
            return "Esta estimación solo evalúa jornadas distribuidas en 5 o 6 días."
        }
        if horas / Double(datos.diasSemanales) > 24 {
            return "La jornada indicada supera las 24 horas diarias; revisa las horas semanales."
        }
        if !(sueldo + gratificacion / 6).isFinite {
            return "Los importes ingresados son demasiado grandes para calcular."
        }
        return nil
    }

    // Supuesto fijo: régimen general privado, tiempo de servicios computable declarado.
    // MTPE: promedio diario >= 4 en semanas de 5 o 6 días y mínimo un mes efectivo.
    static func avisoElegibilidad(_ datos: DatosCTS) -> String? {
        guard validar(datos) == nil, let horas = decimal(datos.horas),
              let meses = entero(datos.meses) else { return nil }
        if horas / Double(datos.diasSemanales) < 4 {
            return "Con la jornada indicada no se cumple el promedio mínimo de cuatro horas diarias para CTS en el régimen general privado."
        }
        if meses < 1 {
            return "El período indicado es menor de un mes completo. El derecho requiere un mes de prestación efectiva. Si al cierre del semestre no se completa ese mes, la fracción se calcula y deposita junto con el siguiente período. No se presenta como depósito inmediato."
        }
        return nil
    }

    static func estimar(_ datos: DatosCTS) -> ResultadoCTS? {
        guard validar(datos) == nil, avisoElegibilidad(datos) == nil,
              let sueldo = decimal(datos.sueldo), let gratificacion = decimal(datos.gratificacion),
              let meses = entero(datos.meses), let dias = entero(datos.dias),
              let horas = decimal(datos.horas) else { return nil }
        let resultado = ResultadoCTS(sueldo: sueldo, gratificacion: gratificacion,
                                     meses: meses, dias: dias,
                                     promedioDiario: horas / Double(datos.diasSemanales))
        return resultado.cts.isFinite ? resultado : nil
    }
}

#Preview {
    NavigationStack {
        CTSView()
    }
}
