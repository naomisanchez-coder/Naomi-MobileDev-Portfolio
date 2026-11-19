# Uso de IA · Semana11 · Compras Tecsup

## 18 de noviembre de 2026 · Prompt maestro del usuario

Registro estructurado de la solicitud recibida en este chat. Fuente de requisitos: PDF local `LAB11-MÓVILESS.docx.pdf`, Grupo B, instrucciones generales, maquetas, casos, ícono y rúbrica. Se extrajeron los textos y se revisaron visualmente las páginas PDF 30–33. No se desarrolló Grupo A.

### Contexto

Actuar como desarrollador senior iOS especializado en SwiftUI, SwiftData y Git. Repositorio Naomi-MobileDev-Portfolio, localizado bajo `/Users/naomisanchez/Desktop/SanchezNaomi`. Área exclusiva Semana11. Actividades 01 UIKit/Core Data y 02 SwiftUI/SwiftData intocables. Proyecto nuevo propuesto `Semana11/apple_lab11_03_SwiftUI_Compras`. Ramas reales main, ai-assisted, manual e integrador, con historias divergentes; conservar todos los commits. ai-assisted es desarrollo, main entrega futura. Mantener seguridad de escritura en workspace y solicitar autorización adicional para operaciones legítimas sobre .git.

### Tarea

Completar en esta ejecución el caso Compras del Grupo B, sin backend ni dependencias innecesarias. Leer requisitos generales y B íntegros, pruebas, maquetas, icono y rúbrica antes de desarrollar. Auditar raíz, status, tracked/untracked/ignored, upstream, remotos, fetch y divergencias. Integrar únicamente la base Semana11 desde main de forma limitada y auditable.

Implementar cuatro modelos @Model: Usuario (nombre, usuario, clave, rol; compras .deny inversa), Proveedor (nombre/ruc y compras .deny inversa), Producto (nombre/categoria/stock/costoPromedio y compras .deny inversa), Compra (fecha/cantidad/costoUnitario/igv/total/alCredito/vence/estado/pagada/motivoRechazo opcional y tres relaciones opcionales). Contenedor persistente, queries, sesión @Observable y lógica separada. Usuario único sin distinguir mayúsculas y normalizando espacios, clave mínimo seis y confirmación idéntica, error genérico de login, ingreso inmediato al registrar, sesión de proceso y logout. Proteger clave con solución local simple sin romper modelo. Validar permisos en servicios.

Implementar B1 login; B2 registro; B3 productos con búsqueda, stock, costo, valoración y CRUD supervisor; B4 proveedores con búsqueda, RUC, total comprado, deuda y CRUD supervisor; B5 compra con sesión, proveedor, producto, cantidad, costo, condición de pago, importes y aviso 5000; B6 compras propias y filtros; B7 aprobación/rechazo con motivo y proyección antes/después; B8 filtros Pendientes/Vencidas/Pagadas, búsqueda por proveedor, total y pago confirmado; B9 resumen, crédito fiscal, inventario, deuda, pendientes y barras por proveedor. Comprador tiene cuatro pestañas y Supervisor cinco según PDF, con menú de avatar y ninguna pestaña de cuenta adicional.

Reglas: IGV 18 %, total subtotal + IGV, aprobación automática por debajo de 5000, pendiente desde 5000 sin efectos hasta aprobación. Promedio ponderado sin redondear almacenamiento; validar stock cero, overflow y finitud. Aplicar efectos una sola vez, sin carreras ni doble pulsación; rechazo sin stock. Contado pagada al aprobar; crédito vence fecha + 30 días calendario, solo aprobada no pagada genera deuda; vencimiento pasado se etiqueta VENCIDA. Pago supervisor una vez, sin nuevo efecto stock. Crédito fiscal solo aprobadas. .deny y alerta amigable con compras en cualquiera de los padres. Guardar y conservar consistencia al reiniciar, sin datos ficticios como resultados reales ni carga demo automática.

Diseño profesional consistente en petróleo #087F76, turquesa #19AD9C, blanco humo #F6F8FA, pizarra #243449 y ámbar #F0B54C; semántica accesible claro/oscuro, SF Symbols, navegación nativa, formularios, confirmaciones, errores, estados vacíos y S/ dos decimales. AppIcon propio PNG 1024 cuadrado opaco sin esquinas redondeadas, caja/documento en verde y turquesa. Display Name Compras y bundle coherente.

Implementar y ejecutar nueve pruebas PDF: duplicado mtorres; login erróneo; 40/110 + 10 a 120 crédito da 1200/216/1416, 50/112, 30 días; contado pagada; 50 a 120 total 7080 pendiente con stock40; aprobar da90/115.56; rechazo con motivo obligatorio sin efecto; vencida pagada reduce deuda; propias y sin permiso pagar. Añadir frontera5000, borrado, una sola aprobación, registro y roles. Casos5/6 con precondiciones independientes. Compilar para destino de simulador instalado, ejecutar tests y comprobar icono/arranque sin borrar datos. No afirmar pruebas no ejecutadas.

### Restricciones

Solo desarrollar en ai-assisted, sin crear ramas equivalentes, modificar manual/integrador o integrar/publicar a main. No reset --hard, clean, stash, force push, rebase destructivo, sudo, chmod ni desactivar seguridad. No perder cambios locales. No modificar otras semanas ni contenido de actividades 01/02. Antes de escribir enumerar alcance. Staging de rutas explícitas con revisión de nombres y diff --cached --check; nunca add ., add -A ni commit -a. Commits progresivos descriptivos, idealmente por pantalla, al menos nueve. Push solo origin/ai-assisted con autorización adicional si corresponde. Si existe un bloqueo, detener solo esa operación e informar sin solución insegura.

Actualizar README Semana11 conservando actividades anteriores y PROMPTS con Contexto/Tarea/Restricciones/Formato/uso de respuesta. No crear documento Word ni diagramas académicos ahora ni inventar expediente/visto bueno docente. Terminar app y validaciones antes de pedir revisión final. Pausa obligatoria antes de integración a main.

### Formato esperado

Informe en español con estado final, resultados reales, ruta del proyecto y apertura, árbol, tabla B1–B9, modelos/relaciones/delete rules, reglas y cifras, ramas/hashes/mensajes/rutas por commit, pushes y estado remoto, confirmación de alcance, capturas/defensa pendientes y limitaciones veraces. Presentar exactamente los archivos candidatos a main y pedir revisión sin integrar.

### Qué se hizo con la respuesta

Se aceptó el alcance del usuario y se contrastó con el PDF. Se eligió copiar solo la base de Semana11 desde main, idéntica byte a byte, a ai-assisted; no se mezclaron otras semanas ni reescribieron commits. La guía menciona `ia-asistida`, pero se usó la rama real `ai-assisted` solicitada. El expediente/visto bueno académico se documenta como pendiente sin inventarlo, siguiendo la instrucción explícita de implementar ahora.

Se implementaron modelos, servicios, nueve pantallas, icono y scripts. Se escogió PBKDF2-HMAC-SHA256 para conservar clave String sin texto plano. Se dividieron filas y se explicitó ToolbarContent para resolver diagnósticos del compilador de SwiftUI. Se corrigieron selectores de XCTest para distinguir los menús de proveedor/producto y el botón Aprobar de su pestaña. Se retiró una restricción extra inicial de edición de inventario: el supervisor conserva edición completa; solo el borrado se bloquea por compras. Se ajustaron los colores semánticos para contraste claro/oscuro. Se añadió un modo DEBUG `--ui-testing`, explícito y sin carga de datos, que usa base en memoria solo para pruebas de interfaz. Se ejecutaron inicialmente 35 comprobaciones de dominio y persistencia aislada; tras añadir el caso de edición autorizada, las 36 comprobaciones finales pasaron; los resultados de XCTest y capturas se consignan en el informe final.

Git fetch autorizado funcionó. El primer push fue rechazado por credencial inválida de GitHub; `gh auth status` confirmó HTTP401. Se detuvieron los pushes y se solicitó al usuario renovar su autenticación, sin pedir ni exponer tokens. El usuario la renovó y autorizó reintentar exclusivamente ai-assisted; se verificaron puntas y contenido antes de publicar los 11 commits pendientes y se continuó publicando los siguientes commits verificados. Las operaciones locales con .git se hicieron mediante autorización adicional. No hubo consultas adicionales a otros servicios de IA, subagentes ni búsqueda web; los refinamientos y verificaciones se realizaron en este mismo chat. No se atribuyen aportes manuales ni aprobación docente que no consten.


### Verificación final de la respuesta

El recorrido iOS B1–B9 final pasó (170.651 s), y una prueba adicional de login claro/oscuro y credenciales incorrectas pasó (16.605 s). El primer filtro del caso adicional seleccionó cero pruebas y se descartó; se corrigió al identificador completo con `()`. Se exportaron 17 capturas reales y resúmenes de xcresult; se revisaron para corregir teclado, contraste y captura de Inicio en transición. Debug y Release compilaron. No se confunden las 36 comprobaciones de dominio macOS con los casos XCTest iOS. Se conservan pendientes las pruebas manuales que no se ejecutaron y el expediente/defensa académicos.

## 18 de noviembre de 2026 · Continuación: rediseño, pruebas y entrega selectiva

### Contexto

La estudiante comunica que la aplicación anterior ya fue validada manualmente. Se parte de ai-assisted/0ee9171 y se comprueba de nuevo el estado, sin asumir que los antecedentes sean el estado actual. Main y manual tienen historias diferentes e integrador queda excluido. Se encontraron seis eliminaciones locales previas fuera de Semana11; se preservan sin incluirlas.

### Tarea

Rediseñar B1–B9 con identidad petróleo/turquesa/pizarra/humo/ámbar, tarjetas, encabezados, jerarquía, estados semánticos, claro/oscuro y Dynamic Type. Conservar icono, nombre, bundle y toda la funcionalidad. Realizar seis grupos visuales progresivos, compilar y publicar cada uno solamente en ai-assisted. Revalidar Debug/Release, dominio, XCTest iOS, roles, formularios, compras al contado/crédito, rechazo, aprobación única, deuda y persistencia tras relanzar.

Preparar después manual mediante un único commit de base limitada de Semana11, reconociendo expresamente la procedencia asistida, sin llevar los commits de IA a su historia ni inventar trabajo manual. Integrar en main exclusivamente actividad03, sección README y PROMPTS/documentación mediante transferencia selectiva. El nuevo prompt autoriza esta integración limitada y reemplaza la pausa obligatoria del prompt anterior. No se autoriza un merge completo.

Crear AUDITORIA_TECNICA.md con arquitectura real, SwiftData, registro/autenticación/PBKDF2, ubicación y lectura segura de SQLite, reglas/funciones, permisos, calidad y al menos15 respuestas en primera persona para defensa. Entregar resultados reales, commits/rutas/ramas, evidencias, limitaciones y estado final remoto.

### Restricciones

Ningún cambio propio fuera de Semana11 ni en actividades 01/02; no alterar registros existentes; no modificar modelos, relaciones, servicios o seguridad por estética. No borrar datos de simulador, usar staging global, reset/clean/force push ni fusionar historias completas. Integrador intocable. Solicitar acceso a .git por el mecanismo autorizado. Conservar trabajo local independiente. No presentar código asistido como manual. Las pruebas persistentes deben usar un dispositivo QA separado con cuentas ficticias únicas.

### Formato esperado

Auditoría explicativa A–H y un informe detallado en español con mejoras por pantalla, inventario de archivos, hashes/mensajes/ramas, pushes, resultados de pruebas y ejemplos, capturas reales, almacenamiento local e integración controlada. Conservar documentos y evidencias anteriores como historial, identificando versiones nuevas.

### Qué se hizo con la respuesta

Se auditó y preservó el trabajo previo ajeno; se realizaron seis commits visuales compilados y publicados progresivamente. Los modelos, servicios, punto de entrada y recursos del icono permanecen idénticos al inicio. Se creó el simulador Compras Rediseño QA, separado del dispositivo de la estudiante. Se agregó XCTest de dominio iOS sobre los mismos servicios, manteniendo también el ejecutable de36 comprobaciones. Los casos UI usan memoria salvo el relanzamiento persistente, protegido por una guarda de nombre de dispositivo QA y credenciales ficticias con sufijo único. Los fallos de automatización por el teclado se investigaron con el árbol de accesibilidad; se ajustó el recorrido, sin cambiar reglas de compra. Los resultados definitivos y transferencias se registran en INFORME_REDISENO.md. No se usaron subagentes ni se inventaron pruebas manuales realizadas por el agente.


### Cierre de ramas y validación efectiva

El verificador conservado pasó 36 comprobaciones; XCTest de dominio pasó 12 casos. UI de login y recorrido B1–B9 pasaron en Tests-3 y el caso persistente definitivo, con navegación comprobada y artefactos nuevos, pasó en Persistence-6 (104.124 s). Se registran resultados por caso en ejecuciones separadas; no se llama verde a la ejecución intermedia que tenía un fallo de automatización. Se generaron 26 capturas nuevas y se conservaron las 17 anteriores. La copia SQLite se limita a QA y no se publica.

Manual se preparó en `bbda928d0b36a9ed1bbd413a272ccd448d7d84ed` desde ai-assisted@8c90a91, mediante un único commit de base que reconoce la asistencia de IA. Main recibió transferencia selectiva en `d3116012aa0253f9f57e4824def1277d7c5e2607`, con README anterior preservado y actividades 01/02 intactas. Ambos pushes se completaron; main compiló desde su worktree antes y después. Integrador no se tocó. El cierre documental se publica también en main, conforme al nuevo prompt, sin modificar código ni atribuir cambios manuales inexistentes. Las seis eliminaciones locales previas ajenas se conservan exactamente.


## 18 de noviembre de 2026 · Cierre y organización en Semana12

### Contexto
Aplicación existente del Laboratorio 11 Grupo B y rediseño visual local pendiente.

### Tarea
Publicar el rediseño, fortalecer validaciones de productos, probar en aislamiento, trasladar la actividad a Semana12 e integrar selectivamente en main.

### Restricciones
Conservar modelos, compras, autenticación, permisos, datos y actividades 01/02. Preservar seis eliminaciones ajenas. No modificar manual/integrador, fusionar historias completas, reescribir commits ni hacer staging global.

### Formato esperado
Informe real de cambios, pruebas, commits, ramas, rutas y limitaciones.

### Uso de la respuesta
Asistencia de IA en el mismo chat. Se reutilizó el rediseño, se agregó ProductValidation y 12 casos XCTest, y se organizó el traslado con git mv de rutas versionadas. No se detecta universalmente la existencia comercial de un nombre. La organización en Semana12 no cambia la denominación oficial del Laboratorio 11. Los resultados finales e integración se registran en INFORME_CIERRE.md. No se atribuye este trabajo a desarrollo manual.

### Resultado final de esta continuación

Se publicaron el rediseño, las validaciones y el traslado mediante commits separados. La heurística se afinó a seis letras repetidas para no rechazar códigos legítimos como AAAA. Debug y Release desde Semana12 en main compilaron; la suite final pasó 27 casos (24 dominio y 3 UI), sin fallos ni omitidos. Las 36 comprobaciones CLI también pasaron desde main. Los datos de la estudiante no se usaron en pruebas. Manual/integrador y actividades01/02 permanecen intactos. Se preparó y verificó una integración selectiva a main, sin merge completo ni reescritura de historial; el estado de publicación se entrega en el informe final. No hubo subagentes ni consultas externas de IA.
