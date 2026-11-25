# Encargo del Laboratorio 14

## Resumen del encargo recibido

Completar el Laboratorio 14 de Programación en Móviles Avanzado de Tecsup, «Autenticación con Firebase», usando la guía `GLAB-S14-JGOMEZM-2026-1.docx`, incluidas sus imágenes y capturas de código. Ejecutar implementación, compilaciones, pruebas reales, evidencias, commits progresivos y publicación. No sustituir la ejecución por instrucciones ni inventar resultados.

Trabajar exclusivamente en `Semana14/` del repositorio `/Users/naomisanchez/Desktop/SanchezNaomi`, reutilizando la carpeta existente y vacía. Conservar raíz, demás semanas, cambios pendientes, índice y worktrees. Verificar instrucciones AGENTS.md, raíz Git, remoto, rama, índice y commits salientes antes de editar. El único destino de publicación autorizado es `origin/main` del remoto `https://github.com/naomisanchez-coder/Naomi-MobileDev-Portfolio`. No crear otro repositorio, otra carpeta Semana14 ni otras ramas. Si fuera necesario aislar el trabajo, usar un worktree temporal con HEAD separado basado en origin/main, sin sobrescribir el checkout original.

Conservar intactas las dos ventanas y proyectos del Lab13 en Xcode: no cerrar, editar, guardar, recompilar, detener sesiones ni cambiar su configuración. No reiniciar ni borrar sus simuladores. Usar xcodebuild y simctl con proyecto, scheme y dispositivo explícitos; usar otro dispositivo para Lab14. Abrir únicamente el proyecto de Semana14 si hiciera falta.

Actividad 01: crear o reutilizar únicamente App01-Lab14 en Firebase; registrar la app SwiftUI Lab14IntroFirebase con Bundle ID `pe.edu.tecsup.dma.Lab14IntroFirebase`; habilitar correo y contraseña; descargar el plist real, comprobar su pertenencia al target y presencia en el bundle, y excluirlo de Git. Integrar el SDK oficial por Swift Package Manager. Configurar Firebase una sola vez antes de usar los servicios. Transcribir AuthView.swift y conectar ContentView.swift, conservando Sign Up, Sign In, Sign Out, estilos, alertas, bienvenida y seguimiento de sesión. Compilar y ejecutar, registrar una cuenta ficticia, comprobarla en Authentication, cerrar y volver a iniciar sesión, probar una entrada inválida. Guardar antes de mensajería capturas reales del formulario inicial, bienvenida, cierre de sesión y, si es seguro, usuario en Authentication. Registrar el hash final de la versión de autenticación.

Actividad 02: continuar en el mismo proyecto, crear DatabaseService.swift y MessagesView.swift según las capturas, conservar el modelo Message, la colección messages, escritura, escucha, lista y envío. Sustituir únicamente la bienvenida autenticada por MessagesView. Probar dos cuentas ficticias, mensajes desde ambas, registros en consola y recepción sin refrescar en dos sesiones independientes si es posible. Guardar evidencias reales con datos exclusivamente ficticios. Restringir las reglas a usuarios autenticados y a mensajes; no habilitar acceso público.

Hacer al menos cinco commits reales por actividad, descriptivos en español, sin «checkpoint», cada uno con avance compilable y comprobado. Incluir funciones invocadas y archivos requeridos en el mismo avance. No fabricar commits vacíos. Antes de cada commit compilar o revisar documentación/evidencias, usar git add -- con rutas explícitas, comprobar el índice y git diff --cached --check, y verificar después las rutas del commit. No incluir archivos ajenos, .DS_Store, xcuserdata, DerivedData, temporales, la guía, credenciales o el plist real. Publicar el primer commit de configuración, después al cerrar cada actividad y al cerrar documentación. Antes de cada push actualizar origin/main y revisar todos los commits salientes y sus rutas individualmente. Publicar desde HEAD comprobado con `git push origin HEAD:refs/heads/main`, sin force, reset --hard, clean ni stashes. Conservar cualquier avance remoto y volver a verificar el alcance antes de publicar.

Crear README.md con objetivo, proyecto, configuración y ejecución local, e índice de evidencias; no incluir allí respuestas ni conclusiones del informe. Crear este prompts.md con el encargo y ajustes comprobados. Entregar proyecto, enlace GitHub, hash remoto final, hashes por actividad, simuladores, iOS, compilaciones separadas de pruebas Firebase, capturas y pendientes. Responder en primera persona las preguntas de paquetes, configure, Auth.auth(), ventaja de Database y tres servicios adicionales aplicados; redactar tres conclusiones basadas en lo ejecutado. Comparar el estado Git inicial/final y confirmar el alcance y la protección de Lab13.

## Aclaraciones posteriores de la usuaria

- Se autorizó Chrome solo para la pestaña de Firebase Console del Lab14; no acceder a Gmail, Drive ni otras pestañas o aplicaciones mediante el navegador. Dejar contraseña y verificaciones Google a la usuaria.
- La usuaria confirmó usar **Cloud Firestore** cuando la lectura de código e imágenes verificó ese servicio. Esta aclaración sustituye el requisito inicial de Realtime Database. No crear una segunda base, habilitar facturación ni acceso público.
- La usuaria autorizó aceptar las Condiciones de Firebase en el asistente de creación.
- El selector institucional «Recurso superior» permanecía vacío para la usuaria y para la automatización. La usuaria autorizó cambiar a su cuenta personal y dejó abierta esa sesión. Se creó exclusivamente App01-Lab14, ID `app01-lab14-d0341`, en el plan Spark gratuito.

## Fidelidad y ajustes comprobados

- Se leyó el texto completo del DOCX y se extrajeron e inspeccionaron todas sus imágenes. Las capturas de código de autenticación y mensajería son legibles; no fue necesaria una reconstrucción de fragmentos ilegibles. No se incorporó la guía docente al repositorio.
- Se transcribieron los métodos signIn, signUp, signOut y checkAuthState de la imagen 32; el cuerpo y estilos de AuthView proceden del texto del documento. Se conservaron sus textos y flujo. El seguimiento de sesión se incorporó después del formulario como avance propio compilable; la versión intermedia usaba currentUser.
- Se usó Firebase 11.14.0, versión mostrada en las capturas, fijada con Package.resolved. FirebaseCore y FirebaseAuth se integraron primero. La captura de selección también señala FirebaseDatabase y FirebaseFirestore; su función se distingue en la entrega, sin confundir el producto SDK con crear una base remota.
- El proyecto se generó mediante archivos de proyecto y scheme compartido, sin usar las ventanas de Xcode del Lab13. Se conservaron nombre, Bundle ID y SwiftUI; deployment target iOS 17.0.
- La primera integración falló al enlazar x86_64 con objetos de paquetes arm64. Se añadió `ONLY_ACTIVE_ARCH = YES` a Debug, valor habitual para compilar la arquitectura del simulador seleccionado. La recompilación pasó. No se modificaron los paquetes ni se excluyeron arquitecturas globalmente.
- El plist real se coloca en la carpeta sincronizada del target. Se comprobó su PROJECT_ID y BUNDLE_ID y su copia al bundle compilado. Está excluido por Semana14/.gitignore. La compilación sin plist también pasó; ejecutar los servicios requiere añadir primero el archivo real.
- Se eliminaron espacios finales detectados por git diff --cached --check sin cambiar el código funcional.
- Gemini y Analytics se desactivaron durante la creación para no incorporar servicios opcionales ajenos al ejercicio. No se habilitó facturación.

- La primera prueba real de Sign Up creó `alice.lab14@example.com` en Authentication, pero la app devolvió un error de acceso al llavero al persistir la sesión. La compilación inicial había desactivado la firma. Se activó la firma ad hoc y se añadió Simulator.entitlements con application-identifier y keychain-access-groups del propio Bundle ID, aplicado mediante una condición exclusiva de iphonesimulator. No se usan certificados personales ni se comparten grupos con otras apps. La compilación corregida pasó y el registro completo con Ana, cierre, reingreso y rechazo de contraseña incorrecta se verificaron en la app real.

- Para DatabaseService se añadió `import Combine`, necesario para declarar ObservableObject y @Published de forma explícita. Se conserva la clase, el modelo Message, los campos id/text/userEmail/timestamp, la colección messages, setData(from:) y addSnapshotListener de la imagen 45.
- Firestore se creó en edición Standard, base (default), nam5, después de la autorización específica de la usuaria para la región irreversible. Se mantuvo Spark y se omitieron copias de seguridad que requerían Blaze.
- Las reglas de prueba abiertas de las capturas se sustituyeron por reglas autenticadas limitadas a messages. Las creaciones verifican el esquema, el ID y el correo del usuario autenticado; no se conceden actualización ni borrado. El archivo local firebase/firestore.rules coincide con el contenido publicado.
- Solo se reinició el iPhone 17 Pro reservado para Lab14 tras quedar bloqueado su arranque/instalación. No se reinició el Pro Max ni el iPhone 17e usado previamente por Lab13; no se borró ningún dispositivo.

## Verificación

La Actividad 01 se ejecutó realmente y se describe en [su verificación](evidencias/actividad-01/verificacion.md). Su último commit, antes de modificar AuthView para mensajería, es `a81fb8fcecb92e840a4d2b4ed25e92c3711ad385`.

La Actividad 02 se ejecutó con dos sesiones independientes y se describe en [su verificación](evidencias/actividad-02/verificacion.md). Bob envió desde el iPhone 17 Pro y Ana recibió en el Pro Max; Ana respondió y Bob recibió sin refrescar. Se comprobaron ambos documentos en Cloud Firestore y el cierre de sesión desde MessagesView. La evaluación simulada de acceso anónimo se identifica aparte y no sustituye las pruebas reales.

Cada avance de código tuvo una compilación correcta antes de guardarse. Las capturas se inspeccionaron antes de sus commits. Los ajustes de plataforma se limitaron al proyecto de Semana14 y no cambiaron el diseño ni la arquitectura de las capturas. Los seis commits de autenticación y los cinco de mensajería son avances reales, con un commit adicional para esta documentación. Las publicaciones se dirigen exclusivamente a origin/main.

## Comprobación del alcance Git

Al inicio, la raíz era `/Users/naomisanchez/Desktop/SanchezNaomi`, la rama `main` estaba limpia y sincronizada con origin/main en `b0ec407cd9e9ef3d848914f7fd04d586bd2678f9`; el índice y los commits salientes estaban vacíos. Semana14 existía y estaba vacía. No se encontraron AGENTS.md aplicables en la carpeta ni sus ancestros revisados.

Se reutilizó el checkout existente. Se conservaron los worktrees registrados y no se aplicaron stashes. Todos los commits del laboratorio se revisaron individualmente y sus rutas comienzan por Semana14/. La comparación contra el commit inicial no mostró diferencias en la raíz ni en las otras semanas. El plist real, xcuserdata, DerivedData, temporales y guía docente quedaron fuera de los commits. La auditoría final de sincronización se realiza tras publicar la documentación.

## Protección de Lab13

No se abrió ni operó la aplicación Xcode. Se compilaron solo el .xcodeproj y scheme de Semana14 con xcodebuild. No se cerraron, editaron, guardaron ni recompilaron las ventanas o proyectos del Lab13. Los UUID usados para Lab14 fueron el Pro Max y el Pro; el iPhone 17e usado previamente en Lab13 permaneció intacto. El único reinicio de dispositivo fue el del Pro reservado para Lab14, para resolver su arranque bloqueado; no se borró ningún simulador.
