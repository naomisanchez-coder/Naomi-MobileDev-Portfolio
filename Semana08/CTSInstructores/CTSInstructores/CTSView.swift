import SwiftUI

struct CTSView: View {
    var body: some View {
        PresentacionSeccion(
            titulo: "Calculadora CTS",
            simbolo: "calculator",
            descripcion: "En esta sección podrás estimar tu compensación por tiempo de servicios según los datos de tu relación laboral. Los campos y el cálculo se incorporarán en una próxima etapa.",
            color: Estilo.azul
        )
    }
}

#Preview {
    NavigationStack {
        CTSView()
    }
}
