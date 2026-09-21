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

// --- HERENCIA: ClienteNatural HEREDA todos los datos y el flujo base
//     de Cliente (codigo, direccion, fechaDeRegistro, numeroCuenta,
//     montoMinimoApertura) y AGREGA sus propios datos de persona. ---
class ClienteNatural: Cliente {
    let nombreCompleto: String
    let dni: String

    init(codigo: String, direccion: String, fechaDeRegistro: String,
         numeroCuenta: String, montoMinimoApertura: Double,
         nombreCompleto: String, dni: String) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni
        // Los datos comunes se delegan al init de la clase base
        super.init(codigo: codigo, direccion: direccion, fechaDeRegistro: fechaDeRegistro,
                   numeroCuenta: numeroCuenta, montoMinimoApertura: montoMinimoApertura)
    }

    // override porque ya existe en Cliente y aquí cambiamos su contenido:
    // primero imprimimos los datos propios de persona natural, luego
    // llamamos a super.mostrarDatos() para reutilizar la impresión común.
    override func mostrarDatos() {
        print("👤 Cliente Natural:")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")
        super.mostrarDatos()
    }
}

// --- HERENCIA: ClienteJuridico HEREDA lo mismo que ClienteNatural,
//     pero AGREGA los datos propios de una empresa. ---
class ClienteJuridico: Cliente {
    let razonSocial: String
    let ruc: String
    let representanteLegal: String

    init(codigo: String, direccion: String, fechaDeRegistro: String,
         numeroCuenta: String, montoMinimoApertura: Double,
         razonSocial: String, ruc: String, representanteLegal: String) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal
        super.init(codigo: codigo, direccion: direccion, fechaDeRegistro: fechaDeRegistro,
                   numeroCuenta: numeroCuenta, montoMinimoApertura: montoMinimoApertura)
    }

    override func mostrarDatos() {
        print("🏢 Cliente Jurídico:")
        print("Razón Social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante Legal: \(representanteLegal)")
        super.mostrarDatos()
    }
}
