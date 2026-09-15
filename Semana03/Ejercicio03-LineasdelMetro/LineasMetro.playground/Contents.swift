import Foundation

// MARK: - MODELO: Estación del Metro
// Representa una estación individual con toda la información que pide el ejercicio.
struct Estacion {
    let nombre: String              // Nombre oficial de la estación
    let linea: String               // A qué línea pertenece (ej. "Línea 1")
    let orden: Int                  // Posición dentro del recorrido (1 = primera estación)
    let distrito: String            // Distrito donde se ubica
    let tieneAscensor: Bool         // Accesibilidad: true si cuenta con ascensor
    let viasCercanas: [String]      // Avenidas / vías cercanas a la estación
    let conectaMetropolitano: Bool  // true si permite transbordo al Metropolitano
}

// MARK: - MODELO: Estado operativo de una línea
// Como Línea 2 está parcialmente operativa y Línea 3 aún no se construye,
// necesitamos distinguir el estado real de cada línea.
enum EstadoLinea: String {
    case operativa = "Operativa"
    case enConstruccion = "En construcción"
    case proyectada = "Proyectada"
}

// MARK: - MODELO: Línea del Metro
struct Linea {
    let nombre: String        // "Línea 1", "Línea 2", "Línea 3"
    let color: String         // Color identificador oficial
    let estado: EstadoLinea   // Operativa / En construcción / Proyectada
    let tarifa: Double        // Tarifa plana en soles (S/). 0.0 si aún no opera
}

// MARK: - Función auxiliar para no repetir el inicializador 80 veces
// Los parámetros con valor por defecto cubren estaciones de las que
// no tenemos data de accesibilidad específica (la mayoría).
func crearEstacion(_ nombre: String, _ linea: String, _ orden: Int,
                    distrito: String = "Lima",
                    ascensor: Bool = false,
                    vias: [String] = [],
                    metropolitano: Bool = false) -> Estacion {
    return Estacion(nombre: nombre, linea: linea, orden: orden, distrito: distrito,
                     tieneAscensor: ascensor, viasCercanas: vias, conectaMetropolitano: metropolitano)
}

// MARK: - DATOS: Línea 1 (operativa, color verde, 26 estaciones reales)
// Recorrido real: Villa El Salvador -> Bayóvar, 34 km, ~54 min, tarifa S/ 1.50
let estacionesLinea1: [Estacion] = [
    crearEstacion("Villa El Salvador", "Línea 1", 1, distrito: "Villa El Salvador",
                   ascensor: true, vias: ["Av. Pastor Sevilla", "Av. Central"]),
    crearEstacion("Parque Industrial", "Línea 1", 2, distrito: "Villa El Salvador"),
    crearEstacion("Pumacahua", "Línea 1", 3, distrito: "Villa María del Triunfo"),
    crearEstacion("Villa María", "Línea 1", 4, distrito: "Villa María del Triunfo"),
    crearEstacion("María Auxiliadora", "Línea 1", 5, distrito: "San Juan de Miraflores"),
    crearEstacion("San Juan", "Línea 1", 6, distrito: "San Juan de Miraflores"),
    crearEstacion("Atocongo", "Línea 1", 7, distrito: "San Juan de Miraflores",
                   ascensor: true, vias: ["Av. Los Héroes", "Panamericana Sur"]),
    crearEstacion("Jorge Chávez", "Línea 1", 8, distrito: "Santiago de Surco"),
    crearEstacion("Ayacucho", "Línea 1", 9, distrito: "Santiago de Surco"),
    crearEstacion("Cabitos", "Línea 1", 10, distrito: "Surquillo",
                   vias: ["Av. Aviación"]),   // Futura conexión con Línea 3
    crearEstacion("Angamos", "Línea 1", 11, distrito: "Surquillo",
                   ascensor: true, vias: ["Av. Angamos Este", "Av. Aviación"]),
    crearEstacion("San Borja Sur", "Línea 1", 12, distrito: "San Borja"),
    crearEstacion("La Cultura", "Línea 1", 13, distrito: "San Borja",
                   ascensor: true, vias: ["Av. Javier Prado Este", "Av. Aviación"],
                   metropolitano: true), // Única estación de L1 con conexión directa al Metropolitano
    crearEstacion("Arriola", "Línea 1", 14, distrito: "La Victoria"),
    crearEstacion("Gamarra", "Línea 1", 15, distrito: "La Victoria",
                   ascensor: true, vias: ["Jr. Gamarra", "Av. Aviación"]),
    crearEstacion("Miguel Grau", "Línea 1", 16, distrito: "Cercado de Lima"),
    crearEstacion("El Ángel", "Línea 1", 17, distrito: "Cercado de Lima"),
    crearEstacion("Presbítero Maestro", "Línea 1", 18, distrito: "El Agustino"),
    crearEstacion("Caja de Agua", "Línea 1", 19, distrito: "San Juan de Lurigancho"),
    crearEstacion("Pirámide del Sol", "Línea 1", 20, distrito: "San Juan de Lurigancho"),
    crearEstacion("Los Jardines", "Línea 1", 21, distrito: "San Juan de Lurigancho"),
    crearEstacion("Los Postes", "Línea 1", 22, distrito: "San Juan de Lurigancho"),
    crearEstacion("San Carlos", "Línea 1", 23, distrito: "San Juan de Lurigancho"),
    crearEstacion("San Martín", "Línea 1", 24, distrito: "San Juan de Lurigancho"),
    crearEstacion("Santa Rosa", "Línea 1", 25, distrito: "San Juan de Lurigancho"),
    crearEstacion("Bayóvar", "Línea 1", 26, distrito: "San Juan de Lurigancho",
                   ascensor: true, vias: ["Av. Próceres de la Independencia"])
]

// MARK: - DATOS: Línea 2 (parcialmente operativa - subterránea, color amarillo)
// Solo la Etapa 1A está en servicio (Evitamiento -> Mercado Santa Anita, 5 estaciones).
// El resto de la línea sigue en construcción.
let estacionesLinea2: [Estacion] = [
    crearEstacion("Evitamiento", "Línea 2", 20, distrito: "Ate", ascensor: true),
    crearEstacion("Óvalo Santa Anita", "Línea 2", 21, distrito: "Santa Anita"),
    crearEstacion("Colectora Industrial", "Línea 2", 22, distrito: "Santa Anita"),
    crearEstacion("Hermilio Valdizán", "Línea 2", 23, distrito: "Santa Anita"),
    crearEstacion("Mercado Santa Anita", "Línea 2", 24, distrito: "Santa Anita", ascensor: true),
    crearEstacion("28 de Julio", "Línea 2", 16, distrito: "La Victoria")
    // ↑ Estación clave: aquí se conectará Línea 2 con Línea 1 (ambas en construcción en ese punto)
]

// MARK: - DATOS: Línea 3 (proyectada, aún no construida)
// La incluimos para poder responder "¿cuáles son las estaciones de la línea 3?"
// tal como pide el enunciado, dejando claro que su estado es "Proyectada".
let estacionesLinea3: [Estacion] = [
    crearEstacion("El Álamo", "Línea 3", 1), crearEstacion("Huandoy", "Línea 3", 2),
    crearEstacion("2 de Octubre", "Línea 3", 3), crearEstacion("Villa Sol", "Línea 3", 4),
    crearEstacion("Naranjal", "Línea 3", 5), crearEstacion("Carlos Izaguirre", "Línea 3", 6),
    crearEstacion("Tomás Valle", "Línea 3", 7), crearEstacion("Tacna", "Línea 3", 11),
    crearEstacion("Garcilaso de la Vega", "Línea 3", 12),
    crearEstacion("Parque de la Reserva", "Línea 3", 14),
    crearEstacion("Huaca Pucllana", "Línea 3", 19),
    crearEstacion("Parque Central de Miraflores", "Línea 3", 20),
    crearEstacion("Los Héroes", "Línea 3", 26)
    // ↑ Aquí se conectará con Línea 1 (en la estación Cabitos), cuando ambas se terminen de construir
]

// MARK: - DICCIONARIO 1: todas las estaciones agrupadas por línea
// Clave = nombre de línea, Valor = arreglo de sus estaciones. Resuelve RF1.
let estacionesPorLinea: [String: [Estacion]] = [
    "Línea 1": estacionesLinea1,
    "Línea 2": estacionesLinea2,
    "Línea 3": estacionesLinea3
]

// MARK: - DICCIONARIO 2: búsqueda directa de una estación por su nombre
// Clave = nombre en minúsculas (para que la búsqueda no sea sensible a mayúsculas), Valor = Estacion. Resuelve RF2.
var estacionesPorNombre: [String: Estacion] = [:]
for lista in estacionesPorLinea.values {
    for estacion in lista {
        estacionesPorNombre[estacion.nombre.lowercased()] = estacion
    }
}

// MARK: - DICCIONARIO 3: información general de cada línea (color, estado, tarifa)
let infoLineas: [String: Linea] = [
    "Línea 1": Linea(nombre: "Línea 1", color: "Verde", estado: .operativa, tarifa: 1.50),
    "Línea 2": Linea(nombre: "Línea 2", color: "Amarillo", estado: .enConstruccion, tarifa: 1.40),
    "Línea 3": Linea(nombre: "Línea 3", color: " Azul Celeste", estado: .proyectada, tarifa: 0.0)
]

// MARK: - DICCIONARIO 4: conexiones entre líneas (estaciones de transbordo)
// Clave = nombre de la estación, Valor = líneas con las que conecta (además de la suya).
let conexionesEntreLineas: [String: [String]] = [
    "28 de Julio": ["Línea 1", "Línea 2"],   // Transbordo futuro L1 <-> L2
    "Cabitos": ["Línea 1", "Línea 3"],       // Transbordo futuro L1 <-> L3
    "Los Héroes": ["Línea 1", "Línea 3"]
]

