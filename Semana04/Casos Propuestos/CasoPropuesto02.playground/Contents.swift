// ===== CASO PROPUESTO 02: CLIENTES DEL BANCO =====
// Temas aplicados: HERENCIA y POLIMORFISMO
// Curso: Programación en Móviles Avanzado

import Foundation

// --- CLASE BASE Cliente: representa a CUALQUIER cliente del banco,
//     sin importar si es una persona natural o una empresa.
//     Es class porque el cliente tiene identidad propia (su cuenta). ---
class Cliente {
    let codigo: String
    let direccion: String
    let fechaDeRegistro: String
    let numeroCuenta: String
    let montoMinimoApertura: Double

    init(codigo: String, direccion: String, fechaDeRegistro: String,
         numeroCuenta: String, montoMinimoApertura: Double) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }

    // Método base que imprime los datos comunes a todo cliente.
    // Cada subclase lo sobreescribe (override) para añadir sus propios
    // datos y volver a llamar a esta versión con super.mostrarDatos().
    func mostrarDatos() {
        print("📋 Código: \(codigo)")
        print("📍 Dirección: \(direccion)")
        print("📅 Fecha de registro: \(fechaDeRegistro)")
        print("🏦 N° Cuenta: \(numeroCuenta)")
        print("💰 Monto mínimo de apertura: S/ \(String(format: "%.2f", montoMinimoApertura))")
    }
}
