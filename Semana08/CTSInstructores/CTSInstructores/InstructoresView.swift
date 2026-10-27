import SwiftUI

struct InstructoresView: View {
    @State private var nombre = ""
    @State private var horas = ""
    @State private var error: String?
    @State private var sueldo: Double?
    @FocusState private var campoActivo: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                encabezado
                formulario
                if let sueldo = sueldo {
                    resultado(sueldo)
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Listo") { campoActivo = false }
            }
        }
        .onChange(of: horas) { _, _ in invalidarResultado() }
        .onChange(of: nombre) { _, _ in invalidarResultado() }
    }

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "person.2.fill")
                .font(.largeTitle)
                .foregroundStyle(Estilo.turquesa)
                .padding(16)
                .background(Estilo.turquesa.opacity(0.10), in: RoundedRectangle(cornerRadius: 18))
                .accessibilityHidden(true)
            Text("Pago de instructores")
                .font(.largeTitle.bold())
                .foregroundStyle(Estilo.azul)
            Text("Calcula tu remuneración mensual según las horas trabajadas.")
                .foregroundStyle(.secondary)
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
                Text("Puedes ingresar horas decimales. Ejemplo: 12.5 = 12 horas y 30 minutos.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text("Obligatorio. Mayor que 0 y hasta 23 horas.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 10) {
                Label("Parámetros del ejercicio", systemImage: "info.circle")
                    .font(.subheadline.bold())
                Text("Pago por hora: S/ 50.00")
                Text("Límite semanal: 23 horas")
                Text("Semanas consideradas: 4")
            }
            .font(.subheadline)
            .foregroundStyle(Estilo.azul)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.fondo, in: RoundedRectangle(cornerRadius: 14))

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

// Funciones puras y sencillas que permiten comprobar las reglas del ejercicio.
enum CalculoInstructor {
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

#Preview {
    NavigationStack {
        InstructoresView()
    }
}
