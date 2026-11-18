# Laboratorio 11 · Semana 11

- **Curso:** Programación en Móviles Avanzado.
- **Tema:** Core Data - SwiftData.
- **Actividad 01:** UIKit + Core Data, implementada; pendiente la comprobación manual del gesto de swipe.
- **Actividad 02:** SwiftUI + SwiftData, implementada; pendiente la comprobación manual del gesto de swipe.

La implementación sigue los pasos 2 al 12 (páginas 4 a 11) de la guía del docente `GLAB-S11-JLEONS-2026-02.pdf`.

## Actividad 01: agenda de contactos

**Objetivo:** guardar, consultar, editar y eliminar contactos locales con UIKit y Core Data, y demostrar consultas con filtros y una relación de uno a muchos.

**Herramientas:** Xcode 26.6 (17F113), Swift, Storyboard, UIKit, Core Data y simulador iPhone 17 Pro con iOS 26.5.

### Estructura

```text
Semana11/
├── README.md
└── apple_lab11_01_UIKit_CoreData/
    ├── apple_lab11_01_UIKit_CoreData.xcodeproj/
    └── apple_lab11_01_UIKit_CoreData/
        ├── AppDelegate.swift
        ├── SceneDelegate.swift
        ├── ViewController.swift
        ├── ViewController+Relacion.swift
        ├── Base.lproj/
        │   ├── Main.storyboard
        │   └── LaunchScreen.storyboard
        ├── Assets.xcassets/
        ├── Info.plist
        └── apple_lab11_01_UIKit_CoreData.xcdatamodeld/
```

### Modelo y persistencia

- `Contacto`: `nombre`, `telefono` y `direccion`, de tipo String opcional.
- `Grupo`: `nombre`, de tipo String opcional.
- `Contacto.grupo`: To One hacia Grupo, inversa `contactos`.
- `Grupo.contactos`: To Many hacia Contacto, inversa `grupo`, Delete Rule Nullify.
- Ambas entidades utilizan Codegen Class Definition; no hay clases de modelo manuales.

Se conserva el `NSPersistentContainer` generado por Xcode con el nombre `apple_lab11_01_UIKit_CoreData`. `conexion()` obtiene su `viewContext`; los cambios se escriben mediante `save()`. `mostrarRutaBaseDeDatos()` imprime la ubicación real del archivo SQLite en cada inicio.

### Interfaz y CRUD

El Navigation Controller es la entrada inicial. La pantalla muestra el título `Lista de Contactos - Tecsup`, el botón Add (+) y una tabla con constraints a la Safe Area. La celda Subtitle tiene identificador `Cell`; muestra nombre y, debajo, teléfono y dirección separados por ` | `.

- **Create:** `agregarContacto(_:)` presenta la alerta con tres campos, valida el nombre, inserta con `NSEntityDescription.insertNewObject`, guarda y recarga la tabla.
- **Read:** `cargarInfoCoreData()` usa `NSFetchRequest<Contacto>` ordenado por nombre.
- **Update:** tocar una fila abre `Editar Contacto`, con los datos actuales; Guardar actualiza el objeto y el contexto.
- **Delete:** `tableView(_:commit:forRowAt:)` llama a `eliminarContacto(at:)`, guarda el borrado y elimina la fila con animación. El gesto de swipe requiere la comprobación manual indicada abajo.

### Fetch requests, filtros y relación

`ViewController+Relacion.swift` contiene `buscarContactos(texto:)` con `nombre CONTAINS[cd] %@` y orden por nombre; el filtro ignora mayúsculas y tildes.

`probarRelacion()` implementa la demostración de la guía: crea Amigos, lo asigna al primer contacto y guarda. Se ejecutó una sola vez con contactos disponibles. `contactosDelGrupo(_:)` consulta mediante `grupo.nombre == %@`.

La versión final no llama automáticamente a estas funciones de demostración. Se retiraron las dos líneas temporales del filtro y las llamadas temporales para demostrar y comprobar la relación. No se agregaron barra de búsqueda ni pantallas para administrar grupos.

### Pruebas realizadas el 4 de noviembre de 2026

| Comprobación | Resultado verificado |
|---|---|
| Compilación de CRUD, filtro, relación y versión final | `BUILD SUCCEEDED` en las cuatro compilaciones |
| Inicio y conexiones Storyboard | App abierta; tabla inicialmente vacía; título y botón + visibles |
| Crear | Tres contactos creados desde la alerta: Juán Pérez, Ana Torres y Zoe Ruiz |
| Orden y celdas | Orden Ana, Juán, Zoe; nombre, teléfono y dirección visibles |
| Persistencia de creación | Los tres contactos permanecieron tras reiniciar el proceso |
| Editar | Juán Pérez cambió a teléfono 900777888 y dirección Lima Centro |
| Borrar | Ana Torres eliminada mediante la acción nativa de accesibilidad Delete de la celda |
| Persistencia de edición y borrado | Tras reiniciar, Juán conservó los cambios y Ana no reapareció; confirmado también leyendo SQLite |
| Filtro | La prueba temporal `buscarContactos(texto: "juan")` mostró solo Juán Pérez y excluyó Zoe Ruiz |
| Relación e inversa | Consola: `El grupo Amigos tiene 1 contacto(s)` |
| Consulta por grupo | `contactosDelGrupo("Amigos").count` devolvió 1 |
| Persistencia de relación y ausencia de duplicados | SQLite final: un único grupo Amigos enlazado a Juán Pérez, después de iniciar la versión sin pruebas temporales |
| Swipe hacia la izquierda | Pendiente de prueba manual: los intentos mediante control automático abrieron la edición; el borrado sí se comprobó por la acción nativa Delete |

Quedaron dos contactos de prueba y el grupo Amigos en el simulador local; estos datos SQLite no forman parte del repositorio.

### Compatibilidad con la guía

No fueron necesarias correcciones de lógica por incompatibilidad con Xcode. Se aplicó sangría y se unieron las cadenas y expresiones partidas por la maquetación del PDF. Se mantuvieron los nombres, textos, operaciones y comportamiento del docente. El contenedor de AppDelegate se conservó.

### Revisión manual

Abre `apple_lab11_01_UIKit_CoreData/apple_lab11_01_UIKit_CoreData.xcodeproj`, selecciona el esquema homónimo y iPhone 17 Pro, y pulsa Run (⌘R). Usa + para crear, toca una fila para editar y desliza una fila a la izquierda para comprobar que aparece Delete. Tras borrar un contacto de prueba, detén y ejecuta nuevamente para comprobar su ausencia.

## Control de versiones

Los commits de esta actividad incluyen exclusivamente archivos de Semana11 mediante índices Git temporales. Se excluyen `.DS_Store` y `xcuserdata`. Los seis archivos de Semana06 y Semana08 que ya estaban en staging se conservaron exactamente y no se incluyeron en los commits de Semana11. No se modificó ninguna otra semana.

## Actividad 02: SwiftUI + SwiftData (Alumno)

Se desarrollaron los 11 pasos de las páginas 11 a 19. La app registra, lista, edita, elimina y busca alumnos, conserva los datos en SQLite y demuestra la relación Curso–Alumno.

### Tecnologías y estructura

Xcode 26.6 (17F113), SwiftUI, SwiftData y simulador iPhone 17 Pro con iOS 26.5. Proyecto creado con el asistente oficial iOS App, Interface SwiftUI, Language Swift y Storage SwiftData. Abierto en una ventana independiente de Xcode.

```text
apple_lab11_02_SwiftUI_SwiftData/
├── apple_lab11_02_SwiftUI_SwiftData.xcodeproj/
└── apple_lab11_02_SwiftUI_SwiftData/
    ├── apple_lab11_02_SwiftUI_SwiftDataApp.swift
    ├── Alumno.swift
    ├── Curso.swift
    ├── ModelContainerProvider.swift
    ├── ContentView.swift
    ├── NuevoAlumnoView.swift
    ├── EditarAlumnoView.swift
    └── Assets.xcassets/
```

`Item.swift` se conservó durante los pasos 1–5 y se eliminó únicamente en el Paso 7, después de reemplazar ContentView y verificar que ya no lo utilizaba.

### Modelos y contenedor

- `Alumno`: modelo `@Model` con `idAlumno: UUID`, apellido, nombre y DNI de tipo String. En el Paso 11 se agregó `curso: Curso?`.
- `Curso`: modelo `@Model` con nombre y `alumnos: [Alumno]`, relación inversa `\Alumno.curso` y regla `.nullify`.
- `ModelContainerProvider`: singleton `@MainActor` con `Schema([Alumno.self, Curso.self])`, `ModelConfiguration` y `ModelContainer`. Conserva la ruta Application Support y el archivo `AlumnosData.sqlite`; imprime la ruta en consola.
- El archivo principal contiene un solo `@main`, `AlumnosApp`, que conecta el contenedor con `.modelContainer(...)`. El Preview usa ambos modelos en memoria.

### CRUD, búsqueda y persistencia

`NuevoAlumnoView` utiliza NavigationStack, Form, Apellido, Nombre y DNI con teclado numérico. Guardar Alumno queda desactivado si hay campos vacíos; inserta el modelo, ejecuta `modelContext.save()` y cierra la hoja. Cancelar cierra sin guardar.

`ContentView` conserva NavigationSplitView, la lista y el detalle del docente. `@Query(sort: \Alumno.apellido)` mantiene la lista actualizada automáticamente. `.onDelete` elimina los registros y limpia la selección cuando corresponde. La eliminación usa `alumnosFiltrados[index]`, para respetar los índices de las filas visibles.

`EditarAlumnoView` usa `@Bindable`, edita las propiedades del mismo modelo y cierra con Listo. La edición y el borrado conservan el guardado automático de SwiftData indicado en la guía.

La búsqueda por apellido utiliza `localizedCaseInsensitiveContains`; al vaciar el texto vuelve la lista completa. No se agregaron filtros ni validaciones adicionales.

Curso demo conserva la función del docente: crea Programación en Móviles, lo inserta y asigna ese curso a todos los alumnos. El detalle muestra el curso o Sin curso. No se agregaron pantallas de mantenimiento de cursos. El botón crea un nuevo curso en cada pulsación, conforme a la lógica original; durante la prueba se pulsó una sola vez.

### Verificaciones realizadas el 4 de noviembre de 2026

| Prueba | Resultado real |
|---|---|
| Bloques 1, 2, 3 y 4 | Compilación `BUILD SUCCEEDED` antes de cada commit |
| Plantilla oficial | Item y ContentView de SwiftData presentes inicialmente; sin proyecto Git anidado ni carpetas externas duplicadas |
| Inicio y formulario | Lista Alumnos, botón +, campos y Guardar Alumno desactivado con campos vacíos verificados en simulador |
| CREATE y READ | Registrados Garcia/Ana/70000001, Perez/Luis/70000002 y Torres/Rosa/70000003; lista actualizada sin recarga manual y ordenada por apellido |
| Detalle | Nombre, apellido y DNI de Luis visibles al seleccionarlo |
| Persistencia inicial | Los tres alumnos permanecieron después de reiniciar; consola con ruta terminada en AlumnosData.sqlite |
| DELETE | Rosa eliminada mediante la acción nativa de accesibilidad Delete; borrado confirmado en SQLite y en ejecuciones posteriores |
| UPDATE | Ana cambió de Garcia a Garcia Lopez mediante Editar y Listo; lista y detalle actualizados; cambio conservado al reiniciar |
| Búsqueda | PEREZ encontró Perez/Luis; limpiar el texto recuperó Ana y Luis |
| Borrado filtrado | Se eliminó Luis mientras PEREZ era el único resultado; Ana permaneció y Luis no reapareció al reiniciar |
| Migración al esquema con Curso | La app abrió sin error de migración y conservó a Ana; no se eliminó la app ni su base de datos |
| Curso demo | Botón del libro asignó Programación en Móviles; visible en detalle y conservado después de reiniciar |
| Relación 1:N y nullify | Prueba ejecutada en macOS con los mismos archivos Alumno.swift y Curso.swift, en un contenedor temporal en memoria: dos alumnos asociados al curso; al eliminarlo ambos permanecen con curso nil |
| Gesto de swipe | Pendiente de comprobación manual: el control automático no reprodujo el gesto. El borrado normal y filtrado sí se ejecutó mediante Delete nativo |

La prueba de `.nullify` no modificó la base del simulador. Los alumnos y el curso de prueba del simulador no se publican en GitHub. Tras los borrados de prueba quedó Ana Garcia Lopez y un curso Programación en Móviles.

### Corrección técnica indispensable

En el Paso 10, aplicar `.searchable(text: $busqueda, prompt: "Buscar por apellido")` directamente al resultado de `ForEach(...).onDelete(...)` compilaba, pero en iOS 26.5 hacía desaparecer las acciones Delete y los controles de borrado del modo Edit. Se comprobó tanto visualmente como mediante accesibilidad.

Se movió exclusivamente `.searchable` al `List` contenedor, inmediatamente antes de `.navigationTitle`. Se conservaron el estado, el filtro, los textos, el diseño de búsqueda nativo y `alumnosFiltrados[index]`. Tras recompilar, Delete volvió a estar disponible y el borrado filtrado eliminó al alumno correcto. No fueron necesarias otras correcciones al código proporcionado.

En el primer arranque, el sistema informó que Application Support todavía no existía y su recuperación automática creó correctamente el almacenamiento. No fue necesario modificar ModelContainerProvider ni su ruta.

### Evidencias y revisión manual

Abre `apple_lab11_02_SwiftUI_SwiftData/apple_lab11_02_SwiftUI_SwiftData.xcodeproj`, selecciona el esquema del proyecto y iPhone 17 Pro, y pulsa Run (⌘R). Captura:

1. Lista de alumnos con los registros y sus DNI.
2. Nuevo Alumno con los tres campos y el botón Guardar Alumno.
3. Detalle de un alumno.
4. Editar Alumno y el resultado de la edición.
5. Buscador filtrando por apellido y lista restaurada al limpiar.
6. Swipe mostrando Delete y lista después del borrado (comprobación manual pendiente).
7. Detalle con Curso: Programación en Móviles después de pulsar el libro y después de reiniciar.
8. Consola con la ruta AlumnosData.sqlite y compilación exitosa.
9. Historial de los cuatro commits en main.

Los cuatro bloques se publican con índices Git temporales, incluyendo exclusivamente la Actividad 02 y este README. Se conservan la Actividad 01, las demás semanas y el staging ajeno. No se desarrollaron la Parte 3 ni los trabajos adicionales.
