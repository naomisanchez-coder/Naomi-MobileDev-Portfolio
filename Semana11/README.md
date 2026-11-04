# Laboratorio 11 · Semana 11

- **Curso:** Programación en Móviles Avanzado.
- **Tema:** Core Data - SwiftData.
- **Actividad 01:** UIKit + Core Data, implementada; pendiente la comprobación manual del gesto de swipe.
- **Actividad 02:** SwiftUI + SwiftData, no iniciada.

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
