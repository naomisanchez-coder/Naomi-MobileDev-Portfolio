import Foundation

// MARK: - Modelo

struct Estacion {
    let nombre: String
    let linea: String
    let tieneAscensor: Bool
    let viasCercanas: [String]
    let conexionMetropolitano: String?   // nil si no conecta
}

// MARK: - Diccionario principal: nombre de estación -> datos

let estaciones: [String: Estacion] = [
    "Bayóvar": Estacion(
        nombre: "Bayóvar",
        linea: "Línea 1",
        tieneAscensor: true,
        viasCercanas: ["Av. Pedro Miotta"],
        conexionMetropolitano: nil
    ),
    "Gamarra": Estacion(
        nombre: "Gamarra",
        linea: "Línea 1",
        tieneAscensor: false,
        viasCercanas: ["Av. Aviación", "Jr. Gamarra"],
        conexionMetropolitano: nil
    ),
    "Angamos": Estacion(
        nombre: "Angamos",
        linea: "Línea 1",
        tieneAscensor: true,
        viasCercanas: ["Av. Angamos"],
        conexionMetropolitano: "Estación Angamos (Metropolitano)"
    ),
    "Estadio Nacional": Estacion(
        nombre: "Estadio Nacional",
        linea: "Línea 2",
        tieneAscensor: true,
        viasCercanas: ["Av. Paseo de la República", "Av. 28 de Julio"],
        conexionMetropolitano: "Estación Estadio Nacional (Metropolitano)"
    )
    // Completa aquí el resto de estaciones según el mapa SVG
]

// MARK: - Diccionario: línea -> lista de estaciones

let estacionesPorLinea: [String: [String]] = [
    "Línea 1": ["Bayóvar", "Gamarra", "Angamos"],
    "Línea 2": ["Estadio Nacional"],
    "Línea 3": []   // completar con data real
]

// MARK: - Funciones de consulta

func estacionesDeLinea(_ linea: String) -> [String] {
    return estacionesPorLinea[linea] ?? []
}

func detalleEstacion(_ nombre: String) -> String {
    guard let est = estaciones[nombre] else {
        return "No se encontró la estación \"\(nombre)\"."
    }
    var texto = """
    Estación: \(est.nombre)
    Línea: \(est.linea)
    Ascensor: \(est.tieneAscensor ? "Sí" : "No")
    Vías cercanas: \(est.viasCercanas.joined(separator: ", "))
    """
    texto += "\nConexión Metropolitano: \(est.conexionMetropolitano ?? "No disponible")"
    return texto
}

func comoLlegar(destino: String) -> String {
    guard let est = estaciones[destino] else {
        return "No conozco la estación \"\(destino)\"."
    }
    var respuesta = "Para llegar a \(est.nombre), toma la \(est.linea)."
    if let metro = est.conexionMetropolitano {
        respuesta += " Al llegar, conecta con: \(metro)."
    }
    return respuesta
}

// MARK: - Menú

func mostrarMenu() {
    print("""

    === Consulta Metro de Lima ===
    1. Ver estaciones de una línea
    2. Ver detalle de una estación
    3. Cómo llegar a un destino
    4. Salir
    Elige una opción:
    """)
}

// MARK: - Motor de la app (recibe una función que provee la siguiente entrada)
// Esto es lo que corrige el bucle: la lógica no depende directamente de
// readLine(), sino de un "proveedor de entradas" que se puede intercambiar.

func ejecutarApp(obtenerEntrada: () -> String?) {
    var continuar = true
    while continuar {
        mostrarMenu()
        guard let opcion = obtenerEntrada() else {
            print("No se recibió entrada, terminando.")
            break
        }

        switch opcion {
        case "1":
            print("Ingresa el nombre de la línea (ej. Línea 1):")
            if let linea = obtenerEntrada() {
                let lista = estacionesDeLinea(linea)
                print(lista.isEmpty ? "No hay estaciones registradas para \(linea)." : lista.joined(separator: ", "))
            }
        case "2":
            print("Ingresa el nombre de la estación:")
            if let nombre = obtenerEntrada() {
                print(detalleEstacion(nombre))
            }
        case "3":
            print("¿A qué estación/destino quieres ir?")
            if let destino = obtenerEntrada() {
                print(comoLlegar(destino: destino))
            }
        case "4":
            continuar = false
            print("¡Hasta luego!")
        default:
            print("Opción no válida.")
        }
    }
}

// MARK: - Modo 1: Consola real (usar cuando corras en macOS Command Line Playground)

func iniciarAppConsola() {
    ejecutarApp(obtenerEntrada: { readLine() })
}

// MARK: - Modo 2: Simulado (usar mientras desarrollas/pruebas dentro del editor)

func iniciarAppSimulada(entradas: [String]) {
    var indice = 0
    ejecutarApp(obtenerEntrada: {
        guard indice < entradas.count else { return nil }
        let valor = entradas[indice]
        indice += 1
        return valor
    })
}

// Para probar dentro del editor de Playground (sin bucle infinito):
iniciarAppSimulada(entradas: ["1", "Línea 1", "2", "Gamarra", "3", "Estadio Nacional", "4"])


