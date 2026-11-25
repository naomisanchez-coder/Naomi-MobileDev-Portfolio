# Verificación real de mensajería con Cloud Firestore

Fecha: 25 de noviembre de 2026, zona America/Lima. App Lab14IntroFirebase, Bundle ID `pe.edu.tecsup.dma.Lab14IntroFirebase`. Firebase App01-Lab14 (`app01-lab14-d0341`), Firestore Standard, base `(default)`, región `nam5`, plan Spark.

## Compilaciones

Compilaron correctamente, antes de sus respectivos commits: integración de FirebaseFirestore/FirebaseDatabase; DatabaseService y modelo Message; MessagesView; conexión de la rama autenticada de AuthView. Se usó xcodebuild con la ruta del proyecto, scheme Lab14IntroFirebase y destino explícito del Pro Max; firma ad hoc del simulador y entitlements del propio Bundle ID. Esa compilación se instaló en ambos dispositivos con simctl y UUID explícito.

FirebaseDatabase está enlazado para conservar la selección de la guía; la app no lo invoca. La única base remota creada es Cloud Firestore, conforme a la aclaración de la usuaria y al código/capturas del documento. No se habilitó facturación.

## Sesiones independientes

| Dispositivo | iOS | UUID | Cuenta ficticia |
| --- | --- | --- | --- |
| iPhone 17 Pro Max | 26.5 | 668BF049-D149-4B9C-8621-7F7C283DE524 | ana.lab14@example.com |
| iPhone 17 Pro | 26.5 | 30E50C5E-DAC3-4AFC-AB61-17984373A678 | bob.lab14@example.com |

Bob se registró desde la app del Pro y recibió «Account created successfully!». Ana volvió a iniciar sesión con su cuenta ya registrada y recibió «Sign in successful!». Se rechazaron las ofertas de guardar contraseñas del sistema. Las dos sesiones se conservaron al instalar la versión de mensajería y abrieron Messages sin volver a autenticarse, confirmando persistencia de sesión entre ejecuciones.

## Intercambio ejecutado

1. Ambas apps estaban abiertas en Messages, con lista vacía y Send deshabilitado sin texto. Se capturó el estado inicial del Pro Max en `01-mensajes-inicial.png`; también se observó el estado vacío del Pro antes de enviar.
2. Bob escribió y envió desde el Pro: `Lab14-Bob-01: Hola desde iPhone 17 Pro`. La lista local mostró el mensaje y `bob.lab14@example.com`.
3. Se cambió únicamente la ventana de Simulator al Pro Max, sin recargar, reiniciar ni navegar en la app receptora. El mensaje de Bob ya estaba visible en Ana: `02-recepcion-bob-en-pro-max.png`.
4. Ana escribió y envió desde el Pro Max: `Lab14-Ana-02: Recibido en Pro Max, respuesta en vivo`. Ambos mensajes quedaron visibles: `03-intercambio-en-pro-max.png`.
5. Se volvió únicamente a la ventana del Pro. La respuesta de Ana estaba visible junto al mensaje inicial, sin refrescar la app de Bob: `04-recepcion-ana-en-pro.png`. Se comprobó recepción en tiempo real en ambos sentidos con dos sesiones autenticadas independientes.
6. Se pulsó Sign Out en MessagesView del Pro. La app regresó al formulario con Email y Password vacíos: `09-cierre-sesion-desde-mensajes.png`.

## Persistencia comprobada en la consola real

Se abrió la colección `messages` de la base `(default)` en Firebase Console y se inspeccionaron los dos documentos escritos por las apps. No se crearon documentos manualmente desde la consola.

| Autor | Documento | Timestamp mostrado por Firestore (UTC-5) | Evidencia |
| --- | --- | --- | --- |
| Ana | 132ACF75-9AB3-41DD-ACE1-2F7CE3BDE393 | 25/11/2026 10:27:17 | 05-firestore-mensaje-ana.png |
| Bob | 87A8726C-3B68-452B-AD7E-51B2D02A6EFD | 25/11/2026 10:26:44 | 06-firestore-mensaje-bob.png |

En cada documento se comprobaron `id`, `text`, `timestamp` de tipo timestamp y `userEmail`. El id coincide con el nombre del documento. El texto y el correo coinciden con el mensaje enviado desde la sesión correspondiente.

## Reglas y evaluación adicional

Se creó la base con reglas cerradas de producción y luego se publicaron las reglas de `../../firebase/firestore.rules`, limitadas a `messages`: lectura autenticada y creación con esquema/ID/correo válidos; actualización, borrado y otras rutas denegados. Evidencia `07-reglas-autenticadas.png`.

Además, el **evaluador simulado de reglas de Firebase Console** rechazó una operación get sobre `messages/prueba-sin-sesion` con Autenticado desactivado: `08-evaluador-lectura-anonima-rechazada.png`. Esta es una evaluación de reglas y se distingue de las pruebas efectivas de envío, recepción y persistencia ejecutadas en las apps reales. No se presenta como una prueba de mensajería real ni como un documento creado.

## Alcance y datos

Las capturas muestran exclusivamente datos ficticios del laboratorio. Las de consola se recortaron para eliminar pestañas y perfil Google, sin alterar los registros. No se guardaron contraseñas, tokens ni la sesión Google en las evidencias. No se recrearon capturas o resultados. No quedaron pruebas funcionales solicitadas pendientes.
