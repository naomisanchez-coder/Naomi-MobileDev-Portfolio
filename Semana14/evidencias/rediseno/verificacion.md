# Verificación del rediseño

## Compilación

- Proyecto principal: Semana14/Lab14IntroFirebase/Lab14IntroFirebase.xcodeproj; scheme explícito Lab14IntroFirebase. Xcode 26.6, SDK iOS 26.5, SwiftUI; Firebase 11.14.0 existente.
- Compilaciones correctas del primer formulario, chat y ajuste final de teclado. La última terminó con BUILD SUCCEEDED usando xcodebuild, firma ad hoc y DerivedData independiente /private/tmp/lab14-derived.
- La copia histórica con bienvenida también compiló correctamente; DerivedData /private/tmp/lab14-welcome-derived. Se usó git archive de a81fb8fcecb92e840a4d2b4ed25e92c3711ad385, sin cambiar main, crear ramas ni reescribir historia.
- Se mantuvo el plist real ignorado y presente localmente. No cambió ninguna dependencia ni configuración del proyecto.

## Pruebas efectivas de Firebase y presentación

Pruebas manuales reales en dos simuladores iOS 26.5, con el proyecto Firebase existente App01-Lab14 (app01-lab14-d0341), Authentication y Cloud Firestore. No se usaron mocks ni emuladores de Firebase.

| Dispositivo reservado | UUID | Cuenta ficticia |
| --- | --- | --- |
| iPhone 17 Pro Max | 668BF049-D149-4B9C-8621-7F7C283DE524 | ana.rediseno@example.com |
| iPhone 17 Pro | 30E50C5E-DAC3-4AFC-AB61-17984373A678 | bob.rediseno@example.com |

1. Registro de Ana en el formulario rediseñado: Firebase confirmó la creación y la app entró al chat. Registro de Bob en la copia histórica rediseñada: confirmación correcta y bienvenida real con su correo. Se rechazaron los avisos del sistema para guardar contraseñas; las contraseñas se generaron en memoria y no se publican.
2. La captura 02 de Actividad 01 corresponde exclusivamente a la bienvenida ejecutada desde la copia histórica, no al chat. Esa pantalla no es un paso adicional de la app principal. Al terminar esta prueba se reinstaló la versión principal en el Pro, conservando la sesión Firebase de Bob.
3. Bob envió «Rediseño Bob 01: Hola Ana, probando el chat renovado.» desde el Pro con el teclado de software abierto y el botón visible. La burbuja propia apareció y Ana recibió en el Pro Max sin refrescar ni volver a entrar.
4. Ana respondió «Rediseño Ana 02: Recibido, Bob. Respuesta en tiempo real.». Bob recibió en el Pro sin refrescar. Ambas sesiones ya estaban abiertas antes del intercambio. Se verificó alineación, etiquetas Tú/Recibido, remitente y hora en ambos sentidos.
5. Cierre de sesión desde el encabezado de Bob: regreso al formulario y campos vacíos. Se guardó la captura 04 de Actividad 01.
6. Acceso de Bob con una contraseña incorrecta: Firebase rechazó las credenciales y la app mostró la alerta legible «Revisa tus datos». No se expuso la contraseña en capturas ni registros.
7. Sustitución por la contraseña correcta de Bob: inicio de sesión confirmado y regreso directo al chat; los mensajes permanecieron tras el reingreso.
8. Teclado de software revisado en el formulario del Pro: ambos campos y botones Iniciar sesión/Crear cuenta visibles. Chat revisado con teclado en Pro y Pro Max: mensajes recientes, campo y botón accesibles. Enviar vacío permanece deshabilitado; enviar con texto funciona.

Las nueve capturas nuevas son PNG directos de simctl, revisados visualmente. La captura inicial se tomó en el Pro Max; las otras cuatro de autenticación, en el Pro. Las de chat identifican el dispositivo por su nombre. Se muestran solo correos example.com y mensajes ficticios.

## Contraste y alcance de la revisión

Se calcularon relaciones de contraste de la paleta: azul/blanco 12,79:1; turquesa/blanco 4,75:1; verde/blanco 5,87:1; coral/fondo coral suave 5,02:1; texto secundario/fondo neutro 5,52:1. Se usan símbolos y etiquetas junto al color. La revisión visual se hizo en modo claro, orientación vertical y tamaño de texto estándar; no se afirma una auditoría completa de accesibilidad ni una prueba de todos los tamaños de dispositivo.

No se volvió a capturar Firebase Console ni se modificó el backend durante este rediseño. Las evidencias de consola originales siguen enlazadas en README. Las pruebas nuevas acreditan acceso real y recepción entre dos sesiones; no se presenta una nueva inspección de los documentos en consola.

## Integridad y protección

Se identificaron 7 PNG originales de Actividad 01 y 9 de Actividad 02. Los 16 conservan ruta y contenido, comparados con originales-sha256.json y con los blobs de aab6b4dd4ea41a7d9d873b3d96f52ff7bf13343e. No se borraron, movieron ni sobrescribieron.

Solo se modificaron rutas de Semana14. DatabaseService.swift, el modelo, firestore.rules, el plist local, Bundle ID y configuración del proyecto permanecen como estaban. No se abrió ni operó Xcode, ni se cerraron, guardaron, editaron o recompilaron proyectos del Lab13. No se detuvieron sesiones ni se reiniciaron o borraron simuladores del Lab13. Los dos simuladores del Lab14 se iniciaron si estaban apagados y no se reiniciaron ni borraron.
