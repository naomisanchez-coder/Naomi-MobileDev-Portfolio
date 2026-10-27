import SwiftUI

struct InstructoresView: View {
    var body: some View {
        PresentacionSeccion(
            titulo: "Pago de instructores",
            simbolo: "person.2.fill",
            descripcion: "En esta sección podrás consultar los componentes del pago de instructores a partir de las horas de trabajo y las condiciones aplicables. La funcionalidad se incorporará en una próxima etapa.",
            color: Estilo.turquesa
        )
    }
}

#Preview {
    NavigationStack {
        InstructoresView()
    }
}
