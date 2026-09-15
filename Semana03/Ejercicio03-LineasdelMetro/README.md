# Sistema de Información — Metro de Lima 🚇

Aplicación de consola desarrollada en **Swift (Playground)** que permite consultar información clave sobre las estaciones, líneas y conexiones del Metro de Lima. Forma parte del ejercicio de la **Semana 03** del curso, en el marco de un módulo de información para usuarios del Metropolitano pensado para los **Juegos Panamericanos**.

## Contexto

El sistema resuelve consultas del tipo:
- "¿Cuáles son las estaciones de la Línea 3?"
- "¿La estación La Cultura tiene ascensor y conecta con el Metropolitano?"
- "Quiero ir al Estadio Nacional, ¿qué línea tomo y con qué conecto?"

Los datos de estaciones, líneas, tarifas y estado operativo corresponden a información real del sistema (Línea 1 operativa, Línea 2 con su tramo Evitamiento–Mercado Santa Anita operativo, Línea 3 aún proyectada). Los datos de accesibilidad (ascensores) y vías cercanas se modelaron como datos de ejemplo para un grupo representativo de estaciones, con fines académicos.

## Requerimientos funcionales

| # | Requerimiento | Función |
|---|---|---|
| RF1 | Consultar todas las estaciones de una línea | `mostrarEstacionesDeLinea(_:)` |
| RF2 | Consultar el detalle completo de una estación (línea, color, ascensor, vías cercanas, conexión al Metropolitano, transbordos) | `mostrarDetalleEstacion(_:)` |
| RF3 | Calcular la tarifa de un viaje entre dos estaciones | `calcularTarifa(origen:destino:)` |
| RF4 | Estimar el tiempo de llegada entre dos estaciones | `calcularTiempoEstimado(origen:destino:)` |
| RF5 | Listar las estaciones accesibles (con ascensor) | `mostrarEstacionesAccesibles()` |
| RF6 | Listar las estaciones con conexión al Metropolitano | `mostrarConexionesMetropolitano()` |
| RF7 | Listar los puntos de transbordo entre líneas | `mostrarTransbordos()` |
| RF8 | Sugerir la ruta hacia un punto de interés (ej. Estadio Nacional) | `sugerirRutaAPuntoInteres(_:)` |

Todas las opciones son accesibles desde un **menú interactivo de consola** (`while` + `switch`) que se ejecuta al correr el programa.

## Estructura de datos

El modelo se construyó únicamente con las colecciones vistas hasta la Semana 03 (Arrays, Diccionarios y Sets), sin `struct`, `class` ni `enum`:

- **Arrays**: `estacionesLinea1`, `estacionesLinea2`, `estacionesLinea3` — orden real de recorrido de cada línea.
- **Diccionarios**: agrupación por línea, línea de cada estación, color/estado/tarifa por línea, ascensores, vías cercanas, transbordos entre líneas y puntos de interés (9 en total).
- **Set**: `estacionesConMetropolitano` — estaciones con conexión directa al Metropolitano.

## Cómo ejecutarlo

**Desde Xcode:**
1. Abrir `LineasMetro.playground`.
2. Correr con ▶ (nota: el menú con `readLine()` no funciona en el panel de resultados de Xcode, solo desde terminal).

**Desde terminal (macOS):**
```bash
swift Semana03/Ejercicio03-LineasdelMetro/LineasMetro.playground/Contents.swift
```

## Tecnologías

- Swift (Playground)
- Sin dependencias externas

## Historial de commits (Semana 03)

1. `feat(semana03): modelar Estacion, Linea y datos base del Metro de Lima`
2. `refactor(semana03): simplificar modelo a Arrays, Diccionarios y Sets`
3. `feat(semana03): agregar busqueda por linea y detalle de estacion`
4. `feat(semana03): agregar tarifa, tiempo estimado, accesibilidad y transbordos`
5. `feat(semana03): implementar menu interactivo de consola`
6. `docs(semana03): agregar README con requerimientos funcionales`

## Autora

Naomi Sánchez — [naomisanchez-coder](https://github.com/naomisanchez-coder)
