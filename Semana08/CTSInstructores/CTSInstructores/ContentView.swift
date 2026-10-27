import SwiftUI

// Colores compartidos para mantener la identidad visual en las cuatro vistas.
enum Estilo {
    static let azul = Color(red: 0.10, green: 0.24, blue: 0.48)
    static let fondo = Color(red: 0.94, green: 0.97, blue: 1.00)
    static let turquesa = Color(red: 0.08, green: 0.43, blue: 0.43)
    static let violeta = Color(red: 0.43, green: 0.32, blue: 0.63)
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    encabezado
                    tarjetaCTS

                    VStack(alignment: .leading, spacing: 14) {
                        Text("Explora tus beneficios")
                            .font(.title2.bold())
                            .foregroundStyle(Estilo.azul)

                        NavigationLink {
                            InstructoresView()
                        } label: {
                            TarjetaBeneficio(titulo: "Pago de instructores",
                                             detalle: "Conoce los componentes de tu pago.",
                                             simbolo: "person.2.fill", color: Estilo.turquesa)
                        }

                        NavigationLink {
                            InformacionLaboralView()
                        } label: {
                            TarjetaBeneficio(titulo: "Información laboral",
                                             detalle: "Aprende sobre tus beneficios laborales.",
                                             simbolo: "book.closed.fill", color: Estilo.violeta)
                        }
                    }
                    .buttonStyle(.plain)

                    Label {
                        Text("Los resultados dependerán de las condiciones laborales y la legislación aplicable. Esta aplicación tiene fines educativos.")
                    } icon: {
                        Image(systemName: "info.circle")
                    }
                    .font(.footnote)
                    .foregroundStyle(Estilo.azul.opacity(0.85))
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
                }
                .padding(24)
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
            .background(Estilo.fondo.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
        }
        .tint(Estilo.azul)
    }

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "briefcase.fill")
                .font(.title2)
                .foregroundStyle(Estilo.azul)
                .padding(14)
                .background(.white, in: RoundedRectangle(cornerRadius: 16))
                .accessibilityHidden(true)
            Text("CTS Instructores")
                .font(.largeTitle.bold())
                .foregroundStyle(Estilo.azul)
            Text("Tus cálculos laborales, de forma sencilla")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var tarjetaCTS: some View {
        VStack(alignment: .leading, spacing: 18) {
            Image(systemName: "calculator")
                .font(.largeTitle)
                .accessibilityHidden(true)
            Text("Calculadora CTS")
                .font(.title.bold())
            Text("Conoce la compensación por tiempo de servicios, un beneficio que respalda tu futuro laboral.")
                .font(.body)
            NavigationLink {
                CTSView()
            } label: {
                HStack {
                    Text("Comenzar cálculo")
                        .fontWeight(.semibold)
                    Spacer(minLength: 12)
                    Image(systemName: "arrow.right")
                }
                .padding(18)
                .foregroundStyle(Estilo.azul)
                .background(.white, in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(colors: [Estilo.azul, Color(red: 0.16, green: 0.36, blue: 0.62)],
                           startPoint: .topLeading, endPoint: .bottomTrailing),
            in: RoundedRectangle(cornerRadius: 24)
        )
        .shadow(color: Estilo.azul.opacity(0.12), radius: 12, y: 6)
    }
}

struct TarjetaBeneficio: View {
    let titulo: String
    let detalle: String
    let simbolo: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: simbolo)
                .font(.title2)
                .padding(12)
                .background(color.opacity(0.10), in: RoundedRectangle(cornerRadius: 14))
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 8) {
                Text(titulo)
                    .font(.headline)
                Text(detalle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "chevron.right")
                .font(.footnote.bold())
                .padding(.top, 6)
                .accessibilityHidden(true)
        }
        .foregroundStyle(color)
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(color.opacity(0.15)))
        .shadow(color: color.opacity(0.05), radius: 8, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: 20))
    }
}

// Presentación común de las secciones; aún no contiene formularios ni cálculos.
struct PresentacionSeccion: View {
    let titulo: String
    let simbolo: String
    let descripcion: String
    let color: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: simbolo)
                    .font(.system(size: 44, weight: .medium))
                    .foregroundStyle(color)
                    .padding(24)
                    .background(color.opacity(0.10), in: RoundedRectangle(cornerRadius: 20))
                    .accessibilityHidden(true)
                Text(titulo)
                    .font(.largeTitle.bold())
                    .foregroundStyle(color)
                Text(descripcion)
                    .font(.body)
                    .foregroundStyle(.secondary)
                Label("Proyecto académico — Semana 08", systemImage: "graduationcap")
                    .font(.footnote)
                    .foregroundStyle(color)
            }
            .padding(24)
            .frame(maxWidth: 550, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 24))
            .padding(24)
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .background(Estilo.fondo.ignoresSafeArea())
        .navigationTitle(titulo)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}
