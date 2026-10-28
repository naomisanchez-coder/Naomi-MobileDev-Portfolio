import SwiftUI

struct InformacionLaboralView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                encabezado
                cts
                gratificaciones
                vacaciones
                instructores
                aportes
                Text("Orientación educativa sobre el régimen general privado. El derecho y el importe real dependen del régimen, la jornada, los conceptos computables y las condiciones de cada trabajador. Consulta las fuentes oficiales vigentes.")
                    .font(.callout)
                    .foregroundStyle(Estilo.azul)
                    .padding(20)
                    .background(Estilo.violeta.opacity(0.08), in: RoundedRectangle(cornerRadius: 18))
            }
            .padding(24)
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .background(Estilo.fondo.ignoresSafeArea())
        .navigationTitle("Información laboral")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .tint(Estilo.violeta)
    }

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "book.closed.fill")
                .font(.largeTitle)
                .foregroundStyle(Estilo.violeta)
                .padding(18)
                .background(.white, in: RoundedRectangle(cornerRadius: 18))
                .accessibilityHidden(true)
            Text("Información laboral")
                .font(.largeTitle.bold())
                .foregroundStyle(Estilo.azul)
            Text("Comprende tus beneficios y las fórmulas de la aplicación.")
                .foregroundStyle(.secondary)
            Label("Aprende antes de calcular", systemImage: "lightbulb")
                .font(.callout.weight(.medium))
                .foregroundStyle(Estilo.turquesa)
        }
    }

    private var cts: some View {
        tarjeta("CTS", subtitulo: "Compensación por Tiempo de Servicios", simbolo: "shield.lefthalf.filled") {
            Text("Beneficio que protege económicamente al trabajador ante el desempleo.")
            Text("Se deposita en mayo y noviembre.")
            Text("En el régimen general privado se requiere una jornada promedio mínima de cuatro horas diarias y cumplir las demás condiciones legales.")
            Text("Se exige un mes completo de servicios. Si no se alcanza al cierre del semestre, la fracción se acumula al siguiente período.")
            formula("Remuneración computable = Sueldo computable + Gratificación computable ÷ 6")
            formula("CTS = Remuneración computable × (Meses ÷ 12 + Días ÷ 360)")
            Text("Otros conceptos computables pueden integrar la remuneración ingresada. La gratificación computable excluye la bonificación extraordinaria.")
                .foregroundStyle(.secondary)
            fuente("MTPE · Derecho a CTS", url: "https://www.gob.pe/institucion/mtpe/noticias/1383535-mtpe-trabajadores-del-regimen-privado-que-laboren-4-horas-diarias-en-promedio-tienen-derecho-a-cts")
        }
    }

    private var gratificaciones: some View {
        tarjeta("Gratificaciones", subtitulo: "Fiestas Patrias y Navidad", simbolo: "gift") {
            Text("Se pagan en julio y diciembre, según las condiciones laborales.")
            Text("Si corresponde una gratificación completa, equivale a una remuneración computable.")
            Text("Si corresponde una gratificación proporcional, se consideran los meses calendario completos del semestre: enero–junio o julio–diciembre.")
            formula("Gratificación proporcional = Remuneración computable × Meses completos ÷ 6")
            Text("Bonificación extraordinaria: EsSalud, 9 %; EPS, 6.75 %. Es adicional y distinta del aporte mensual de salud del empleador.")
            formula("Bonificación extraordinaria = Gratificación × Tasa aplicable")
            Text("El derecho depende del régimen y las condiciones laborales. La app simula gratificaciones y bono del 9 % solo si se activa el supuesto; no calcula EPS.")
                .foregroundStyle(.secondary)
            fuente("SUNAFIL · Gratificaciones", url: "https://www.gob.pe/institucion/sunafil/noticias/1413450-mas-de-9-000-denuncias-recibio-la-sunafil-por-falta-de-pago-de-la-gratificacion")
        }
    }

    private var vacaciones: some View {
        tarjeta("Vacaciones", subtitulo: "Descanso remunerado", simbolo: "sun.max") {
            Text("En el régimen general privado pueden corresponder 30 días naturales de descanso remunerado al cumplir un año de servicios, el récord vacacional y la jornada mínima aplicable.")
            Text("Remuneración vacacional: pago correspondiente al descanso.")
            Text("Vacaciones truncas: pago proporcional que puede corresponder al finalizar la relación laboral.")
            Text("Provisión contable: estimación del costo del beneficio; no es un pago adicional mensual.")
            formula("Provisión mensual aproximada = Remuneración mensual ÷ 12")
            Text("Referencia contable, no una liquidación legal completa.")
                .foregroundStyle(.secondary)
            fuente("SUNAFIL · Derecho a vacaciones", url: "https://www.gob.pe/institucion/sunafil/noticias/889227-pensando-en-salir-de-vacaciones-sunafil-te-explica-como-acceder-a-este-derecho")
            fuente("SUNAFIL · Beneficios al cese", url: "https://www.gob.pe/institucion/sunafil/noticias/661238-liquidacion-de-beneficios-6-datos-que-debes-saber-si-renunciaste-o-te-cesaron-del-trabajo")
        }
    }

    private var instructores: some View {
        tarjeta("Pago de instructores", subtitulo: "Parámetros de la actividad", simbolo: "person.2") {
            formula("Sueldo bruto = Horas semanales × S/ 50 × 4")
            Text("La tarifa de S/ 50 por hora, el máximo de 23 horas semanales y las cuatro semanas por mes son parámetros fijados por el docente. No son reglas laborales universales.")
            Text("Se aceptan horas decimales: 12.5 horas equivalen a 12 horas y 30 minutos. El resultado bruto se calcula antes de los descuentos.")
            Text("Las operaciones interactivas permanecen en Pago de instructores y Calculadora CTS.")
                .foregroundStyle(.secondary)
        }
    }

    private var aportes: some View {
        tarjeta("Descuentos y aportes", subtitulo: "Identifica quién los asume", simbolo: "doc.text") {
            Text("ONP: el aporte del trabajador es el 13 % de la remuneración asegurable.")
            Text("AFP: el descuento reúne aporte obligatorio, prima de seguro y comisión correspondiente. La app usa las tasas fijas de octubre de 2026. Con comisión sobre saldo, no estima la comisión anual del fondo ni añade una comisión sobre el sueldo.")
            Text("EsSalud: en el ejemplo académico se calcula el 9 % del bruto a cargo del empleador; no se resta de la remuneración del instructor.")
            Text("Quinta categoría: se proyectan los ingresos anuales, se deducen 7 UIT y se aplican tasas progresivas solo a la porción de renta de cada tramo.")
            formula("Neto referencial = Sueldo bruto − Descuento previsional − Retención referencial")
            Text("La división del impuesto anual entre 12 en la app corresponde únicamente al supuesto ordinario de enero–marzo de 2026, con sueldo constante, un empleador y sin otros ingresos ni retenciones previas. No es una retención exacta para cualquier mes.")
            Text("Las tasas tributarias y previsionales pueden cambiar. Los parámetros de esta app no se actualizan automáticamente.")
                .foregroundStyle(.secondary)
            fuente("ONP · Aportes al SNP", url: "https://www.gob.pe/institucion/onp/noticias/1190488-como-saber-si-tu-empleador-esta-pagando-tus-aportes-al-snp")
            fuente("SUNAT · EsSalud y ONP", url: "https://ww1.sunat.gob.pe/ol-ti-itmoddatruc/TIENEEMP.html")
            fuente("SBS · Comisiones y primas AFP", url: "https://www.sbs.gob.pe/app/spp/empleadores/comisiones_spp/Paginas/comision_prima.aspx")
            fuente("SUNAT · Quinta categoría", url: "https://personas.sunat.gob.pe/trabajador-dependiente/como-me-deben-hacer-retencion-impuesto")
        }
    }

    // Un mismo contenedor mantiene el estilo de todas las secciones estáticas.
    private func tarjeta<Contenido: View>(_ titulo: String, subtitulo: String, simbolo: String,
                                          @ViewBuilder contenido: () -> Contenido) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: simbolo)
                .font(.title2)
                .foregroundStyle(Estilo.violeta)
                .padding(12)
                .background(Estilo.violeta.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                .accessibilityHidden(true)
            Text(titulo)
                .font(.title2.bold())
                .foregroundStyle(Estilo.azul)
                .accessibilityAddTraits(.isHeader)
            Text(subtitulo)
                .font(.headline)
                .foregroundStyle(Estilo.violeta)
            contenido()
        }
        .font(.body)
        .foregroundStyle(Estilo.azul)
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 22))
        .shadow(color: Estilo.azul.opacity(0.04), radius: 8, y: 4)
    }

    private func formula(_ texto: String) -> some View {
        Text(texto)
            .font(.body.weight(.medium))
            .foregroundStyle(Estilo.azul)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.fondo, in: RoundedRectangle(cornerRadius: 14))
    }

    private func fuente(_ titulo: String, url: String) -> some View {
        Group {
            if let destino = URL(string: url) {
                Link(destination: destino) {
                    Label(titulo, systemImage: "arrow.up.right.square")
                        .font(.callout.weight(.medium))
                        .padding(.vertical, 10)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        InformacionLaboralView()
    }
}
