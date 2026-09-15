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
var lineaDeEstacion: [String: String] = [:]
for (linea, estaciones) in estacionesPorLinea {
    for estacion in estaciones {
        lineaDeEstacion[estacion] = linea
    }
}

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

