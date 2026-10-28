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
            Text("Es un beneficio que brinda respaldo económico frente al desempleo.")
            Text("Depósitos: hasta el 15 de mayo por noviembre–abril y hasta el 15 de noviembre por mayo–octubre.")
            Text("En el régimen general privado se exige un promedio mínimo de cuatro horas diarias. Para jornadas de cinco o seis días, se dividen las horas semanales entre los días correspondientes; 23 horas semanales no determinan por sí solas el derecho.")
            Text("Se requiere un mes de prestación efectiva. Si al cierre del semestre no se completa, la fracción se calcula y deposita junto con el siguiente período.")
            formula("Remuneración computable = Sueldo computable + Gratificación computable ÷ 6")
            formula("CTS = Remuneración computable × (Meses ÷ 12 + Días ÷ 360)")
            Text("La app supone remuneración fija. Otros conceptos computables, si corresponden, deben estar incorporados en la remuneración ingresada. La gratificación computable no incluye la bonificación extraordinaria.")
                .foregroundStyle(.secondary)
            fuente("MTPE · Derecho a CTS", url: "https://www.gob.pe/institucion/mtpe/noticias/1383535-mtpe-trabajadores-del-regimen-privado-que-laboren-4-horas-diarias-en-promedio-tienen-derecho-a-cts")
        }
    }

    private var gratificaciones: some View {
        tarjeta("Gratificaciones", subtitulo: "Fiestas Patrias y Navidad", simbolo: "gift") {
            Text("Se pagan en julio y diciembre. Los semestres de referencia son enero–junio y julio–diciembre.")
            Text("La gratificación completa equivale a una remuneración computable si se cumplen las condiciones del semestre. Cuando corresponde un pago proporcional, se consideran los meses calendario completos trabajados, no cualquier fracción de mes.")
            formula("Gratificación proporcional = Remuneración computable × Meses completos ÷ 6")
            Text("La bonificación extraordinaria es adicional: 9 % de la gratificación con EsSalud o 6.75 % con EPS, según corresponda. Es distinta del aporte mensual de salud del empleador.")
            formula("Bonificación extraordinaria = Gratificación × Tasa aplicable")
            Text("Estas referencias no resuelven todos los casos: deben revisarse el régimen, el tiempo computable y los conceptos remunerativos. La app solo simula dos gratificaciones completas y bonificación del 9 % cuando se activa ese supuesto; no calcula EPS ni acredita el derecho al beneficio.")
                .foregroundStyle(.secondary)
            fuente("SUNAFIL · Gratificaciones", url: "https://www.gob.pe/institucion/sunafil/noticias/1413450-mas-de-9-000-denuncias-recibio-la-sunafil-por-falta-de-pago-de-la-gratificacion")
        }
    }

    private var vacaciones: some View {
        tarjeta("Vacaciones", subtitulo: "Descanso remunerado", simbolo: "sun.max") {
            Text("En el régimen general privado, los 30 días naturales de descanso remunerado requieren un año de servicios, el récord vacacional correspondiente y la jornada mínima aplicable. No se extiende automáticamente este plazo a otros regímenes o al tiempo parcial.")
            Text("Remuneración vacacional: es el pago del descanso, equivalente a la remuneración habitual computable según las condiciones del trabajador. Se abona antes de iniciar las vacaciones.")
            Text("Vacaciones truncas: son el pago proporcional que puede corresponder al cese por tiempo trabajado sin completar el período anual, sujeto a los requisitos aplicables. No son lo mismo que disfrutar el descanso anual.")
            Text("Provisión contable: es una estimación periódica del costo del beneficio; no supone un pago mensual adicional al trabajador.")
            formula("Provisión mensual aproximada = Remuneración mensual ÷ 12")
            Text("Esta referencia académica no constituye por sí sola una liquidación legal completa de vacaciones o beneficios al cese.")
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
