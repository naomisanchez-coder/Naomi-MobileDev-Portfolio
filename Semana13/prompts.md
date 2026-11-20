# Registro de asistencia con Codex

La usuaria solicitó completar el Laboratorio 13 de Tecsup con dos proyectos SwiftUI independientes y tres avances en orden. Pidió conservar el esquema MVVM, verificar las solicitudes contra JSONPlaceholder en el simulador, guardar capturas reales y publicar commits progresivos únicamente en `origin/main`. Se reservó el historial de la Actividad 02 para consultar su implementación con `dataTask`.

## Ajustes respecto de la guía

- Se mantuvieron los nombres de los archivos, el filtro por subcadena del nombre sin distinguir mayúsculas, `NavigationView`, el formulario modal y las acciones por deslizamiento. Se añadió `import Combine` de forma explícita para `ObservableObject` y `@Published`. El proyecto SwiftUI genera su Info.plist y la configuración de escenas desde Xcode.
- La guía de la Actividad 02 contiene «TO DO» y repite la captura del método POST después de esa indicación. Se implementó PUT mediante `URLRequest`, `JSONEncoder` y `dataTask`, siguiendo el patrón de POST y la lógica de actualización por ID que sí aparece en la captura asíncrona.
- Se valida el estado HTTP antes de cambiar los datos. Los errores se muestran al usuario, se conserva la lista previa y el formulario permanece abierto si falla su solicitud. Se validan nombre y correo. Se desactiva el deslizamiento completo para exigir un toque explícito en la acción.
- Se conservaron `DispatchQueue.main.async` en las operaciones con callback y el aislamiento `@MainActor` al migrar. La carga final usa `.task` para asociarse a la aparición de SwiftUI y las acciones de botón usan `Task` para esperar sus solicitudes. Se evita recargar la lista al cerrar el formulario para conservar las operaciones locales de la sesión.
- JSONPlaceholder puede devolver el mismo ID en varios POST. Cada alta guarda una identidad local distinta y las solicitudes PUT y DELETE se reservan para registros originales. Las pruebas utilizaron nombres de laboratorio y registros públicos de ejemplo.
