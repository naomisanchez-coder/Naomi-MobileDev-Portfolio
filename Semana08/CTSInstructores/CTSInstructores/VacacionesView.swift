import SwiftUI

struct VacacionesView: View {
    var body: some View {
        PresentacionSeccion(
            titulo: "Calculadora de vacaciones",
            simbolo: "calendar.badge.clock",
            descripcion: "Estima tu remuneración vacacional y conoce tus beneficios. En la siguiente etapa se incorporarán los datos y las condiciones del cálculo.",
            color: Estilo.violeta
        )
    }
}

#Preview {
    NavigationStack {
        VacacionesView()
    }
}
