# Verificación real de autenticación

Fecha: 25 de noviembre de 2026, zona America/Lima. Proyecto Firebase App01-Lab14 (`app01-lab14-d0341`), plan Spark, proveedor correo y contraseña habilitado. App `pe.edu.tecsup.dma.Lab14IntroFirebase`.

Dispositivo: iPhone 17 Pro Max, iOS 26.5, UUID `668BF049-D149-4B9C-8621-7F7C283DE524`. Xcode 26.6 (17F113). Se utilizó xcodebuild con proyecto, scheme y destino explícitos y simctl con UUID explícito; no se operó Xcode.

## Compilaciones

Proyecto SwiftUI inicial, integración FirebaseCore/FirebaseAuth, formulario, seguimiento de sesión y configuración del llavero: compilación correcta. Se comprobó que el plist real local se copia al bundle y coincide con el proyecto y Bundle ID indicados. También se comprobó que Git lo excluye. El SDK queda fijado en 11.14.0.

## Interacciones ejecutadas en la app

1. Formulario inicial sin sesión, con Email, Password, Sign In y Sign Up: observado y capturado en `01-formulario-inicial.png`.
2. Registro con `ana.lab14@example.com` y contraseña de prueba generada en memoria: Firebase devolvió «Account created successfully!». Captura `07-registro-correcto.png`. Se rechazó la oferta del sistema de guardar la contraseña.
3. Authentication de Firebase Console mostró `ana.lab14@example.com` con proveedor Email: captura `06-cuentas-en-authentication.png`. En la tabla solo aparecen cuentas ficticias de este laboratorio.
4. Sign Out: alerta «Signed out successfully!»; al cerrarla reapareció el formulario con ambos campos vacíos. Captura `03-sesion-cerrada.png`.
5. Sign In con la misma cuenta y contraseña: alerta «Sign in successful!», seguida de «Welcome!», «You are signed in» y Sign Out. Captura `02-bienvenida-inicio-sesion.png`.
6. Nuevo Sign Out y Sign In con el mismo correo y otra contraseña aleatoria: Firebase rechazó la entrada con «The supplied auth credential is malformed or has expired». Se mantuvo el formulario. Captura `04-credenciales-invalidas.png`. No se registraron contraseñas en archivos ni logs de prueba.

## Incidencia resuelta

La primera ejecución sin firma creó `alice.lab14@example.com` remotamente, pero falló al persistir la sesión en el llavero. No se consideró una prueba satisfactoria del flujo completo. Se corrigió la firma y los entitlements de la app exclusivamente para iphonesimulator y se repitió el registro con Ana, seguido de las pruebas anteriores, todas correctas. La cuenta Alice se conserva como dato ficticio del primer intento y no se borró.

Las capturas de consola se recortaron para excluir pestañas y el perfil Google, conservando el proyecto y los datos originales. No se recrearon pantallas ni registros.
