# Sistema de Información - Metro de Lima

Aplicación de consola en Swift que permite a los usuarios consultar información sobre las líneas, estaciones y conexiones del Metro de Lima con el Metropolitano.

## Requerimientos Funcionales

1. **Consultar estaciones por línea**: el usuario ingresa el nombre de una línea (ej. "Línea 1") y el sistema devuelve la lista de estaciones que la componen.
2. **Consultar detalle de una estación**: el usuario ingresa el nombre de una estación y el sistema devuelve:
   - Línea a la que pertenece
   - Si cuenta con ascensor
   - Vías cercanas
   - Conexión con el Metropolitano (si existe)
3. **Consultar cómo llegar a un destino**: el usuario ingresa una estación/destino y el sistema indica qué línea debe tomar y, de ser el caso, con qué estación del Metropolitano conecta al llegar.
4. **Menú interactivo por consola**: el sistema presenta un menú con las opciones disponibles y procesa la entrada del usuario en un ciclo hasta que este decida salir.
5. **Manejo de datos no encontrados**: si el usuario consulta una línea o estación que no existe en el sistema, se muestra un mensaje indicando que no fue encontrada, en lugar de fallar.

## Modelo de datos

- `Estacion`: estructura con nombre, línea, si tiene ascensor, vías cercanas y conexión al Metropolitano.
- `estaciones`: diccionario `[String: Estacion]` que mapea el nombre de cada estación a sus datos.
- `estacionesPorLinea`: diccionario `[String: [String]]` que mapea cada línea a la lista de nombres de sus estaciones.

## Cómo ejecutar

1. Abrir `LineasMetro.playground` en Xcode (plataforma macOS, para soporte de consola).
2. Ejecutar el Playground (▶️).
3. Por defecto corre en modo simulado (`iniciarAppSimulada`) para pruebas dentro del editor. Para interacción real por teclado, comentar esa línea y descomentar `iniciarAppConsola()`.

## Fuente de datos

Estaciones y líneas basadas en el mapa oficial del Metro de Lima:
https://upload.wikimedia.org/wikipedia/commons/0/05/Lima_Metro_Map.svg

## Autor

Naomi Sánchez - TECSUP
