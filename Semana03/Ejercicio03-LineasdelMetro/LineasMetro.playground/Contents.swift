import Foundation

// ================================================================
// Reconstruimos el modelo usando SOLO Arrays, Diccionarios y Sets
// (lo visto hasta la Semana 3).
// ================================================================

// MARK: - Arrays: estaciones de cada línea en orden de recorrido
let estacionesLinea1: [String] = [
    "Villa El Salvador", "Parque Industrial", "Pumacahua", "Villa María",
    "María Auxiliadora", "San Juan", "Atocongo", "Jorge Chávez", "Ayacucho",
    "Cabitos", "Angamos", "San Borja Sur", "La Cultura", "Arriola", "Gamarra",
    "Miguel Grau", "El Ángel", "Presbítero Maestro", "Caja de Agua",
    "Pirámide del Sol", "Los Jardines", "Los Postes", "San Carlos",
    "San Martín", "Santa Rosa", "Bayóvar"
]

let estacionesLinea2: [String] = [
    "28 de Julio", "Evitamiento", "Óvalo Santa Anita",
    "Colectora Industrial", "Hermilio Valdizán", "Mercado Santa Anita"
]

let estacionesLinea3: [String] = [
    "El Álamo", "Huandoy", "2 de Octubre", "Villa Sol", "Naranjal",
    "Carlos Izaguirre", "Tomás Valle", "Tacna", "Garcilaso de la Vega",
    "Parque de la Reserva", "Huaca Pucllana",
    "Parque Central de Miraflores", "Los Héroes"
]

// MARK: - Diccionario 1: nombre de línea -> array de sus estaciones
// Resuelve RF1: "¿Cuáles son las estaciones de la línea 3?"
let estacionesPorLinea: [String: [String]] = [
    "Línea 1": estacionesLinea1,
    "Línea 2": estacionesLinea2,
    "Línea 3": estacionesLinea3
]

// MARK: - Diccionario 2: nombre de estación -> línea a la que pertenece
// Lo llenamos con un bucle for recorriendo el diccionario anterior
// (esto es justo lo que vimos en Semana 2: bucles + Semana 3: diccionarios).
func construirLineaDeEstacion() -> [String: String] {
    var resultado: [String: String] = [:]
    for (linea, estaciones) in estacionesPorLinea {
        for estacion in estaciones {
            resultado[estacion] = linea
        }
    }
    return resultado
}

let lineaDeEstacion: [String: String] = construirLineaDeEstacion()

// MARK: - Diccionarios 3, 4 y 5: información general de cada línea
let colorLinea: [String: String] = [
    "Línea 1": "Verde", "Línea 2": "Amarillo", "Línea 3": "Azul Celeste"
]
let estadoLinea: [String: String] = [
    "Línea 1": "Operativa", "Línea 2": "En construcción", "Línea 3": "Proyectada"
]
let tarifaLinea: [String: Double] = [
    "Línea 1": 1.50, "Línea 2": 1.40, "Línea 3": 0.0
]

// MARK: - Diccionario 6: ¿qué estaciones tienen ascensor?
// Solo un grupo representativo tiene el dato marcado (no es data oficial
// verificada estación por estación, es de ejemplo para el ejercicio).
let estacionesConAscensor: [String: Bool] = [
    "Villa El Salvador": true, "Atocongo": true, "Angamos": true,
    "La Cultura": true, "Gamarra": true, "Bayóvar": true,
    "Evitamiento": true, "Mercado Santa Anita": true
]

// MARK: - Diccionario 7: vías cercanas por estación
let viasCercanas: [String: [String]] = [
    "Villa El Salvador": ["Av. Pastor Sevilla", "Av. Central"],
    "Atocongo": ["Av. Los Héroes", "Panamericana Sur"],
    "Angamos": ["Av. Angamos Este", "Av. Aviación"],
    "La Cultura": ["Av. Javier Prado Este", "Av. Aviación"],
    "Gamarra": ["Jr. Gamarra", "Av. Aviación"],
    "Bayóvar": ["Av. Próceres de la Independencia"]
]

// MARK: - Set: estaciones que conectan con el Metropolitano
// Usamos un Set (no un Array) porque solo nos importa "¿está o no está?",
// no el orden ni los duplicados.
let estacionesConMetropolitano: Set<String> = ["La Cultura"]

// MARK: - Diccionario 8: estaciones de transbordo entre líneas
let conexionesEntreLineas: [String: [String]] = [
    "28 de Julio": ["Línea 1", "Línea 2"],
    "Cabitos": ["Línea 1", "Línea 3"],
    "Los Héroes": ["Línea 1", "Línea 3"]
]

// ================================================================
// FUNCIONES DE CONSULTA
// ================================================================

// MARK: - RF1: estaciones de una línea
// Recibe el nombre de la línea y muestra todas sus estaciones en orden.
func mostrarEstacionesDeLinea(_ nombreLinea: String) {
    // Buscamos en el diccionario; si la clave no existe, "estaciones" será nil
    guard let estaciones = estacionesPorLinea[nombreLinea] else {
        print("No existe la \(nombreLinea) en el sistema.")
        return
    }

    print("Estaciones de \(nombreLinea) (\(estadoLinea[nombreLinea] ?? "?")):")
    // Recorremos el array con un for y mostramos el número de orden junto al nombre
    for (indice, estacion) in estaciones.enumerated() {
        print("  \(indice + 1). \(estacion)")
    }
}

// MARK: - RF2: detalle completo de una estación
// Recibe el nombre de una estación y muestra toda su información.
func mostrarDetalleEstacion(_ nombreEstacion: String) {
    // Si la estación no está en el diccionario, avisamos y salimos de la función
    guard let linea = lineaDeEstacion[nombreEstacion] else {
        print("La estación '\(nombreEstacion)' no existe en el sistema.")
        return
    }

    print("Estación: \(nombreEstacion)")
    print("  Línea: \(linea) (\(colorLinea[linea] ?? "?"))")

    // El diccionario de ascensores no tiene TODAS las estaciones como clave,
    // así que si no aparece, asumimos "false" con el operador ??
    let tieneAscensor = estacionesConAscensor[nombreEstacion] ?? false
    print("  Ascensor: \(tieneAscensor ? "Sí" : "No registrado")")

    // Igual con las vías cercanas: si no hay dato, mostramos un array vacío
    let vias = viasCercanas[nombreEstacion] ?? []
    if vias.isEmpty {
        print("  Vías cercanas: sin datos registrados")
    } else {
        print("  Vías cercanas: \(vias.joined(separator: ", "))")
    }

    // El Set responde directo con true/false si la estación está en él
    let conectaMetro = estacionesConMetropolitano.contains(nombreEstacion)
    print("  Conexión con Metropolitano: \(conectaMetro ? "Sí" : "No")")

    // Revisamos si esta estación aparece como punto de transbordo entre líneas
    if let otrasLineas = conexionesEntreLineas[nombreEstacion] {
        print("  Transbordo con: \(otrasLineas.joined(separator: ", "))")
    }
}

// MARK: - Ejemplos de uso (esto sí lo dejamos, es la demo del ejercicio)
mostrarEstacionesDeLinea("Línea 3")
print("")
mostrarDetalleEstacion("La Cultura")
print("")
mostrarDetalleEstacion("Angamos")
print("")
mostrarDetalleEstacion("Estación Inventada")

// ================================================================
// AGREGANDO MAS DATOS NECESARIOS
// ================================================================

// MARK: - Diccionario: minutos promedio entre estaciones consecutivas, por línea
// Se calcula dividiendo el tiempo total real de recorrido entre su N° de estaciones.
let tiempoPromedioPorEstacion: [String: Double] = [
    "Línea 1": 54.0 / 26.0,   // Línea 1 completa: 54 min / 26 estaciones ≈ 2.08 min
    "Línea 2": 12.0 / 5.0,    // Tramo operativo: ≈12 min / 5 estaciones ≈ 2.4 min
    "Línea 3": 0.0            // Aún no opera, no hay tiempo real que usar
]

// ================================================================
// RF3: calcular tarifa de un viaje
// ================================================================
func calcularTarifa(origen: String, destino: String) {
    // Buscamos a qué línea pertenece cada estación
    guard let lineaOrigen = lineaDeEstacion[origen] else {
        print("La estación de origen '\(origen)' no existe.")
        return
    }
    guard let lineaDestino = lineaDeEstacion[destino] else {
        print("La estación de destino '\(destino)' no existe.")
        return
    }

    if lineaOrigen == lineaDestino {
        // Viaje dentro de la misma línea: se paga una sola tarifa
        let tarifa = tarifaLinea[lineaOrigen] ?? 0.0
        print("Tarifa \(origen) -> \(destino) (\(lineaOrigen)): S/ \(tarifa)")
    } else {
        // Viaje entre dos líneas: en Lima aún no hay integración tarifaria,
        // así que se paga cada línea por separado
        let tarifaOrigen = tarifaLinea[lineaOrigen] ?? 0.0
        let tarifaDestino = tarifaLinea[lineaDestino] ?? 0.0
        let total = tarifaOrigen + tarifaDestino
        print("Tarifa \(origen) -> \(destino) (\(lineaOrigen) + \(lineaDestino), sin integración): S/ \(total)")
    }
}

// ================================================================
// RF4: estimar tiempo de llegada
// ================================================================
func calcularTiempoEstimado(origen: String, destino: String) {
    guard let lineaOrigen = lineaDeEstacion[origen],
          let lineaDestino = lineaDeEstacion[destino] else {
        print("Una de las dos estaciones no existe en el sistema.")
        return
    }

    // Solo calculamos tiempo cuando ambas estaciones están en la misma línea:
    // calcular tiempo con transbordo de por medio requeriría datos que aún no tenemos.
    if lineaOrigen == lineaDestino {
        guard let estaciones = estacionesPorLinea[lineaOrigen],
              let indiceOrigen = estaciones.firstIndex(of: origen),
              let indiceDestino = estaciones.firstIndex(of: destino) else {
            print("No se pudo calcular el tiempo.")
            return
        }
        // Distancia en número de estaciones (positiva, sin importar la dirección)
        let numeroEstaciones = abs(indiceDestino - indiceOrigen)
        let tiempo = Double(numeroEstaciones) * (tiempoPromedioPorEstacion[lineaOrigen] ?? 0.0)
        print("Tiempo estimado \(origen) -> \(destino): \(String(format: "%.1f", tiempo)) min (\(numeroEstaciones) estaciones)")
    } else {
        print("\(origen) y \(destino) están en líneas distintas (\(lineaOrigen) y \(lineaDestino).")
        print("Se requiere transbordo — revisa las estaciones de conexión con mostrarTransbordos().")
    }
}

// ================================================================
// RF5: estaciones accesibles (con ascensor)
// ================================================================
func mostrarEstacionesAccesibles() {
    print("Estaciones con ascensor registrado:")
    // Recorremos el diccionario y filtramos solo las que tienen valor true
    for (estacion, tieneAscensor) in estacionesConAscensor where tieneAscensor {
        let linea = lineaDeEstacion[estacion] ?? "?"
        print("  - \(estacion) (\(linea))")
    }
}

// ================================================================
// RF6: estaciones con conexión al Metropolitano
// ================================================================
func mostrarConexionesMetropolitano() {
    print("Estaciones con conexión al Metropolitano:")
    // Recorremos el Set (no tiene orden garantizado, pero aquí solo hay una)
    for estacion in estacionesConMetropolitano {
        let linea = lineaDeEstacion[estacion] ?? "?"
        print("  - \(estacion) (\(linea))")
    }
}

// ================================================================
// RF7: estaciones de transbordo entre líneas
// ================================================================
func mostrarTransbordos() {
    print("Puntos de transbordo entre líneas:")
    for (estacion, lineas) in conexionesEntreLineas {
        print("  - \(estacion): conecta \(lineas.joined(separator: " y "))")
    }
}

// MARK: - Ejemplos de uso
calcularTarifa(origen: "Villa El Salvador", destino: "Bayóvar")
calcularTarifa(origen: "Angamos", destino: "Evitamiento")
print("")
calcularTiempoEstimado(origen: "Villa El Salvador", destino: "La Cultura")
print("")
mostrarEstacionesAccesibles()
print("")
mostrarConexionesMetropolitano()
print("")
mostrarTransbordos()
