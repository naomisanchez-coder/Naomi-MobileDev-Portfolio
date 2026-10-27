import SwiftUI

struct InformacionLaboralView: View {
    var body: some View {
        PresentacionSeccion(
            titulo: "Información laboral",
            simbolo: "book.closed.fill",
            descripcion: "Aquí encontrarás orientación educativa sobre CTS, gratificaciones y vacaciones. El contenido se revisará según las condiciones laborales y la legislación aplicable.",
            color: Estilo.violeta
        )
    }
}

#Preview {
    NavigationStack {
        InformacionLaboralView()
    }
}
