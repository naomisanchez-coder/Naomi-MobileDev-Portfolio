# Laboratorio 13 · Consumir API desde una aplicación

## Objetivo

Consumir un servicio REST desde SwiftUI con MVVM. El laboratorio cubre consulta y búsqueda, operaciones de escritura y migración a async/await.

## Proyectos y ejecución

Abre el proyecto en Xcode 26.6, elige su esquema con el mismo nombre, selecciona un simulador con iOS 17 o posterior y pulsa **⌘R**. La API requiere conexión a internet.

- [Semana13_API.xcodeproj](Semana13_API/Semana13_API.xcodeproj) contiene la actividad 01.
- [Semana13_MetodosAPI.xcodeproj](Semana13_MetodosAPI/Semana13_MetodosAPI.xcodeproj) contiene la versión async/await de la actividad 03. La versión de la actividad 02 con `dataTask` se conserva en el [commit `ff6e3d5`](https://github.com/naomisanchez-coder/Naomi-MobileDev-Portfolio/tree/ff6e3d565309cd84514e79be28647148145856fd/Semana13/Semana13_MetodosAPI).

## Servicio y persistencia

Las aplicaciones usan [JSONPlaceholder](https://jsonplaceholder.typicode.com/guide/) en `/users`. El servicio simula POST, PUT y DELETE. La aplicación muestra el estado HTTP real y aplica el resultado en memoria durante la sesión. Al volver a iniciar la app, el GET recupera los datos de ejemplo originales. Las altas de prueba reciben una identidad local única para evitar colisiones cuando el servicio devuelve el mismo ID simulado. El deslizamiento para editar o eliminar se ofrece en las filas que tienen un ID original válido para el servidor.

## Evidencias

### Actividad 01

- [01-lista-cargada.png](evidencias/actividad-01/01-lista-cargada.png) · GET 200 y lista completa de diez usuarios.
- [02-busqueda-aplicada.png](evidencias/actividad-01/02-busqueda-aplicada.png) · Búsqueda “gRaHaM” con una coincidencia.

### Actividad 02

- [02-formulario-alta.png](evidencias/actividad-02/02-formulario-alta.png) · Formulario con los datos de Ana Laboratorio.
- [03-resultado-post.png](evidencias/actividad-02/03-resultado-post.png) · POST 201 y Ana Laboratorio en la lista local.
- [04-formulario-edicion.png](evidencias/actividad-02/04-formulario-edicion.png) · Formulario del registro original de Leanne Graham con el nuevo nombre.
- [05-resultado-put.png](evidencias/actividad-02/05-resultado-put.png) · PUT 200 y el nombre Leanne Actualizada.
- [06-resultado-delete.png](evidencias/actividad-02/06-resultado-delete.png) · DELETE 200 y lista local sin Ervin Howell.

### Actividad 03

- [01-lista-get.png](evidencias/actividad-03/01-lista-get.png) · GET 200 y lista con nombres y correos.
- [02-formulario-alta.png](evidencias/actividad-03/02-formulario-alta.png) · Formulario con los datos de Ana Laboratorio.
- [03-resultado-post.png](evidencias/actividad-03/03-resultado-post.png) · POST 201 y Ana Laboratorio en la lista local.
- [04-formulario-edicion.png](evidencias/actividad-03/04-formulario-edicion.png) · Formulario del registro original de Leanne Graham con el nuevo nombre.
- [05-resultado-put.png](evidencias/actividad-03/05-resultado-put.png) · PUT 200 y el nombre Leanne Actualizada.
- [06-resultado-delete.png](evidencias/actividad-03/06-resultado-delete.png) · DELETE 200 y lista local sin Ervin Howell.

Código de la migración en la actividad 03. [UserViewModel.swift](Semana13_MetodosAPI/Semana13_MetodosAPI/ViewModels/UserViewModel.swift) · [ContentView.swift](Semana13_MetodosAPI/Semana13_MetodosAPI/View/ContentView.swift).

## Comprobaciones realizadas

Los dos proyectos se compilaron para iPhone 17e con iOS 26.5. Las pruebas de interfaz se ejecutaron con XCUITest desde copias temporales de los proyectos y apuntaron al servicio real.

- Actividad 01. Primero se ejecutó el listado sin filtro. Después se comprobó el GET HTTP 200, la coincidencia de “gRaHaM” y el retorno de la lista completa al borrar la búsqueda.
- Actividad 02. Se verificó que el formulario rechazara campos vacíos y un correo incompleto. POST devolvió HTTP 201, PUT HTTP 200 y DELETE HTTP 200. PUT usó el registro original de Leanne Graham y DELETE el de Ervin Howell. Se comprobaron los efectos visibles en memoria.
- Actividad 03. Se repitieron GET, POST, PUT y DELETE desde la versión async/await y se comprobaron los mismos códigos HTTP, la validación, la precarga del formulario y los cambios de la lista.
