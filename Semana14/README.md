# Laboratorio 14 Autenticación con Firebase

Implementación del laboratorio de Programación en Móviles Avanzado de Tecsup con SwiftUI y Firebase. La primera actividad incorpora registro, inicio y cierre de sesión; la segunda utiliza Cloud Firestore conforme al código y las capturas de la guía y a la aclaración de la usuaria.

## Proyecto

[Lab14IntroFirebase.xcodeproj](Lab14IntroFirebase/Lab14IntroFirebase.xcodeproj)

- Scheme compartido: `Lab14IntroFirebase`.
- Bundle Identifier: `pe.edu.tecsup.dma.Lab14IntroFirebase`.
- SwiftUI, iOS 17.0 o posterior; verificado con Xcode 26.6 y SDK iOS 26.5.
- SDK oficial de Firebase 11.14.0 mediante Swift Package Manager. Las revisiones quedan fijadas en `Package.resolved`.
- Proyecto Firebase: `App01-Lab14`, ID `app01-lab14-d0341`, plan Spark gratuito.

## Configuración local de Firebase

1. Abrir únicamente `App01-Lab14` en Firebase Console, con la cuenta propietaria del laboratorio. En Authentication → Método de acceso, habilitar Correo electrónico/contraseña.
2. En Configuración del proyecto → Tus apps, seleccionar la app Apple `Lab14IntroFirebase`, registrada con el Bundle ID indicado, y descargar su `GoogleService-Info.plist`.
3. Copiar el archivo, conservando exactamente ese nombre, a `Lab14IntroFirebase/Lab14IntroFirebase/GoogleService-Info.plist`, junto a los archivos Swift. La carpeta sincronizada del proyecto le da pertenencia al target y copia el archivo como recurso al bundle. No colocarlo dentro de `.xcodeproj`.
4. Abrir el proyecto y permitir la resolución de Swift Package Manager. La URL de origen es `https://github.com/firebase/firebase-ios-sdk`.
5. Antes de ejecutar, comprobar que el plist contiene `PROJECT_ID = app01-lab14-d0341` y `BUNDLE_ID = pe.edu.tecsup.dma.Lab14IntroFirebase`. No publicar su contenido. Está excluido por [.gitignore](.gitignore).

La compilación del código es posible sin el plist. Antes de ejecutar, añadir el archivo real indicado en los pasos anteriores. La copia local queda excluida del repositorio.

## Configuración de Cloud Firestore

En el mismo proyecto App01-Lab14, utilizar Cloud Firestore, edición Standard, base `(default)` y región `nam5 (United States)`, autorizada por la usuaria y mostrada en la guía. No crear una instancia de Realtime Database ni asociar facturación.

La base se creó en modo de producción con acceso cerrado. Copiar el contenido de [firestore.rules](firebase/firestore.rules) en Firestore → Reglas y publicar. Las reglas permiten leer la colección `messages` a usuarios autenticados y crear documentos con los campos del modelo, ID coincidente y correo del usuario autenticado. No permiten modificar o borrar mensajes ni acceder a otras rutas. Reemplazan el modo de prueba abierto de las capturas.

La app usa `Firestore.firestore()`, que selecciona la base predeterminada del proyecto definido en el plist local. El SDK FirebaseDatabase se conserva porque aparece seleccionado en la guía; no se invoca ni se crea una segunda base remota.

## Compilar y ejecutar

Desde la raíz del repositorio, para el dispositivo de Lab14:

```sh
xcodebuild \
  -project Semana14/Lab14IntroFirebase/Lab14IntroFirebase.xcodeproj \
  -scheme Lab14IntroFirebase \
  -destination 'platform=iOS Simulator,id=668BF049-D149-4B9C-8621-7F7C283DE524' \
  -derivedDataPath /private/tmp/lab14-derived \
  -clonedSourcePackagesDirPath /private/tmp/lab14-packages \
  CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=- build

xcrun simctl boot 668BF049-D149-4B9C-8621-7F7C283DE524
xcrun simctl bootstatus 668BF049-D149-4B9C-8621-7F7C283DE524 -b
xcrun simctl install 668BF049-D149-4B9C-8621-7F7C283DE524 \
  /private/tmp/lab14-derived/Build/Products/Debug-iphonesimulator/Lab14IntroFirebase.app
xcrun simctl launch 668BF049-D149-4B9C-8621-7F7C283DE524 \
  pe.edu.tecsup.dma.Lab14IntroFirebase
```

Omitir `boot` si el dispositivo ya está iniciado. Si se utiliza otra Mac, sustituir el UUID por el de un simulador disponible de esa Mac. Para pruebas simultáneas se reservó también `30E50C5E-DAC3-4AFC-AB61-17984373A678` (iPhone 17 Pro, iOS 26.5). No es necesario abrir, compilar ni cambiar proyectos del Lab13.

La versión completa de autenticación previa a mensajería se conserva en el commit `a81fb8fcecb92e840a4d2b4ed25e92c3711ad385`.

## Evidencias y verificaciones

Las capturas se guardan después de observar el resultado real. Los recortes de consola eliminan pestañas y el perfil de la cuenta Google; no alteran los datos del laboratorio.

### Actividad 01

- [Proveedor correo y contraseña habilitado](evidencias/actividad-01/05-proveedor-habilitado.png).
- Compilación con Firebase Authentication: correcta.
- Plist real presente en el bundle y excluido de Git: comprobado.
- [Formulario inicial](evidencias/actividad-01/01-formulario-inicial.png).
- [Bienvenida después de Sign In](evidencias/actividad-01/02-bienvenida-inicio-sesion.png).
- [Formulario después de Sign Out](evidencias/actividad-01/03-sesion-cerrada.png).
- [Rechazo de credenciales incorrectas](evidencias/actividad-01/04-credenciales-invalidas.png).
- [Cuentas ficticias en Authentication](evidencias/actividad-01/06-cuentas-en-authentication.png).
- [Registro correcto](evidencias/actividad-01/07-registro-correcto.png).
- [Pruebas ejecutadas e incidencia resuelta](evidencias/actividad-01/verificacion.md).

### Actividad 02

Compilaciones e intercambio real completados con Ana en el Pro Max y Bob en el Pro, ambos con iOS 26.5. Se comprobó recepción en ambos sentidos sin refrescar y persistencia de los dos documentos en la consola de Cloud Firestore.

- [Pantalla inicial de mensajes](evidencias/actividad-02/01-mensajes-inicial.png).
- [Recepción de Bob en el Pro Max](evidencias/actividad-02/02-recepcion-bob-en-pro-max.png).
- [Intercambio con ambas cuentas en el Pro Max](evidencias/actividad-02/03-intercambio-en-pro-max.png).
- [Recepción de Ana en el Pro](evidencias/actividad-02/04-recepcion-ana-en-pro.png).
- [Documento de Ana en Firestore](evidencias/actividad-02/05-firestore-mensaje-ana.png).
- [Documento de Bob en Firestore](evidencias/actividad-02/06-firestore-mensaje-bob.png).
- [Reglas autenticadas publicadas](evidencias/actividad-02/07-reglas-autenticadas.png).
- [Evaluador de reglas: lectura anónima simulada rechazada](evidencias/actividad-02/08-evaluador-lectura-anonima-rechazada.png).
- [Cierre de sesión desde MessagesView](evidencias/actividad-02/09-cierre-sesion-desde-mensajes.png).
- [Detalle de pruebas, sesiones y documentos persistidos](evidencias/actividad-02/verificacion.md).

Las pruebas funcionales solicitadas están completadas. Para repetirlas, crear cuentas ficticias propias desde Sign Up. Las contraseñas empleadas durante la verificación se generaron en memoria y no se publican.

Los ajustes comprobados y las aclaraciones del encargo se registran en [prompts.md](prompts.md).


## Rediseño de la interfaz

El rediseño continúa sobre el laboratorio terminado `aab6b4dd4ea41a7d9d873b3d96f52ff7bf13343e`. La paleta, los estilos de botones y la marca compartida están en [LabTheme.swift](Lab14IntroFirebase/Lab14IntroFirebase/LabTheme.swift). El acceso agrupa campos y mantiene sus acciones encima del teclado; el chat distingue mensajes con alineación, símbolos y etiquetas, además del color. Se conservan Firebase Authentication, Cloud Firestore, el modelo y el flujo directo de acceso al chat.

### Nuevas evidencias de Actividad 01

- [Formulario inicial](evidencias/rediseno/actividad-01/01-formulario-inicial.png).
- [Bienvenida autenticada en la copia histórica](evidencias/rediseno/actividad-01/02-bienvenida-autenticada-historica.png).
- [Alerta por acceso inválido](evidencias/rediseno/actividad-01/03-alerta-acceso-invalido.png).
- [Regreso al formulario tras cerrar sesión desde el chat](evidencias/rediseno/actividad-01/04-formulario-tras-cerrar-sesion.png).
- [Formulario con teclado abierto y acciones accesibles](evidencias/rediseno/actividad-01/05-formulario-con-teclado.png).

La bienvenida se ejecutó desde una copia temporal de `a81fb8fcecb92e840a4d2b4ed25e92c3711ad385`, con los estilos actuales y Firebase real. No forma parte del target ni del flujo actual. Para reproducir esa copia, ejecutar `python3 Semana14/recursos/actividad-01/preparar_bienvenida.py` desde la raíz. Requiere el plist local ya configurado y devuelve la ruta del proyecto temporal. Compilar ese proyecto con el scheme Lab14IntroFirebase, un DerivedData independiente y el UUID reservado para Lab14; nunca cambiar de rama ni usar un simulador de Lab13. El [archivo de bienvenida](recursos/actividad-01/AuthenticationWelcomeView.swift) se incorpora únicamente a esa copia.

### Nuevas evidencias de Actividad 02

- [Composición y envío con teclado abierto](evidencias/rediseno/actividad-02/01-envio-con-teclado.png).
- [Ana recibe el mensaje de Bob sin refrescar](evidencias/rediseno/actividad-02/02-recepcion-bob-en-pro-max.png).
- [Intercambio en el Pro Max de Ana](evidencias/rediseno/actividad-02/03-intercambio-ana-pro-max.png).
- [Bob recibe la respuesta de Ana en el Pro](evidencias/rediseno/actividad-02/04-intercambio-bob-pro.png).

[Detalle de compilaciones, pruebas y alcance](evidencias/rediseno/verificacion.md). Las 16 capturas originales permanecen en sus rutas anteriores y conservan sus SHA-256; se incluye su [manifiesto de integridad](evidencias/rediseno/originales-sha256.json). Las nueve imágenes nuevas son PNG directos del simulador, sin retoques.
