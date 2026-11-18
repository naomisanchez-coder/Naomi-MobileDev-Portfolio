# Compras Tecsup · Grupo B

Aplicación académica iOS con SwiftUI, SwiftData, Observation, Charts y CommonCrypto. Sin backend, paquetes externos ni carga automática de datos. iOS 17 o posterior; validada con Xcode 26.6 e iPhone 17 Pro / iOS 26.5.

## Ejecutar

Abre `Compras.xcodeproj`, esquema **Compras**, selecciona un simulador y pulsa ⌘R. Display Name **Compras**; bundle `edu.pe.tecsup.naomisanchez.compras`. No se requiere equipo de firma para el simulador. Registra primero un Supervisor y crea productos y proveedores; cierra sesión y registra un Comprador para comprar. Los dos roles son seleccionables porque la guía exige autorregistro académico. Esto no representa un sistema de autorización de servidor.

La sesión existe solo durante el proceso. Los datos se guardan en el contenedor SwiftData persistente `Compras`, dentro del sandbox exclusivo de este bundle. Los errores al abrir la base se muestran sin eliminarla ni sustituirla por una base vacía. No se modifican los almacenes de las actividades 01/02.

## Pantallas y permisos

| Pantalla | Implementación | Permisos |
|---|---|---|
| B1 | `LoginView.swift`: usuario, clave oculta, error genérico | Sin sesión |
| B2 | `RegisterView.swift`: nombre, usuario, claves, rol; ingreso inmediato | Sin sesión |
| B3 | `ProductsView.swift`: buscar, valoración, CRUD y confirmación | Consulta ambos; CRUD Supervisor |
| B4 | `SuppliersView.swift`: buscar nombre/RUC, total aprobado, deuda y CRUD | Consulta ambos; CRUD Supervisor |
| B5 | `NewPurchaseView.swift`: proveedor, producto, cantidad, costo, pago e importes | Comprador |
| B6 | `MyPurchasesView.swift`: propias; Todas/Pendientes/Rechazadas y motivo | Comprador |
| B7 | `ApprovalView.swift`: pendientes, solicitante, proyección y decisión | Supervisor |
| B8 | `PayablesView.swift`: Pendientes/Vencidas/Pagadas, búsqueda, confirmar pago | Supervisor |
| B9 | `SummaryView.swift`: inventario, IGV, deuda, aprobación, barras e historial completo | Supervisor |

TabView: Comprador tiene Productos, Proveedores, Compra y Mis compras. Supervisor tiene Resumen, Aprobar, Por pagar, Productos y Proveedores. Cuenta se presenta en el avatar con nombre, usuario, rol y cerrar sesión. No es otra pestaña. Los servicios vuelven a validar roles aunque alguien intente invocarlos directamente.

## Modelo

`Models.swift` define exactamente cuatro clases `@Model`:

- Usuario: nombre, usuario único normalizado, clave protegida, rol; compras con `.deny`, inversa `Compra.comprador`.
- Proveedor: nombre, ruc; compras con `.deny`, inversa `Compra.proveedor`.
- Producto: nombre, categoria, stock Int, costoPromedio Double; compras con `.deny`, inversa `Compra.producto`.
- Compra: fecha, cantidad, costoUnitario, igv, total, alCredito, vence, estado, pagada, motivoRechazo opcional y relaciones opcionales comprador/proveedor/producto. Las relaciones opcionales conservan el comportamiento nullify por defecto en ese lado. No hay eliminación de compras en la interfaz.

La prevalidación impide borrar usuario, producto o proveedor con cualquier compra, incluso pendiente o rechazada. Los formularios usan borradores: Cancelar no muta objetos persistentes. El supervisor puede editar los datos del producto; el bloqueo por compras se aplica al borrado, conforme a la guía.

## Reglas verificables

`Business.swift` contiene sesión, autenticación, validaciones, operaciones y cálculos. Mutaciones síncronas en `@MainActor`, sin puntos de suspensión entre verificar estado y guardar. Esto serializa dobles pulsaciones en el único contexto de la app. Cada aprobación exige estado Pendiente; reaprobación, pago doble y pago por comprador fallan. Ante error de save se ejecuta rollback. Autosave está desactivado para que las mutaciones se guarden explícitamente.

Subtotal = cantidad × costo; IGV = subtotal × 18 %; total = subtotal + IGV. Se conserva la precisión Double del modelo; solo la presentación monetaria redondea a dos decimales. Desde 5000 el estado inicial es Pendiente, sin modificar inventario, IGV computable ni deuda. Aprobar aplica `(stock × costoAnterior + cantidad × costoUnitario)/(stock + cantidad)` una vez. Rechazar requiere motivo no vacío y no aplica efectos.

Al aprobar: contado pagada; crédito no pagada y vencimiento a fecha de registro + 30 días calendario. Solo Aprobada + crédito + no pagada es deuda. Vencida significa vencimiento anterior al instante actual; se actualiza al entrar, volver al primer plano y cada minuto. Pagar solo cambia pagada. IGV y barras suman exclusivamente aprobadas. B8 usa #Predicate sobre estado, crédito y pagada; luego filtra vencimiento y búsqueda localizada del proveedor sobre la colección observada.

Usuarios: se eliminan espacios Unicode y se convierte a minúsculas; `MT ORRES` coincide con `mtorres`. Clave de al menos seis caracteres, confirmación idéntica. `clave: String` almacena PBKDF2-HMAC-SHA256, 120000 iteraciones, sal aleatoria de 16 bytes y salida de 32 bytes; comparación sin salida temprana. Nunca se muestra la clave ni su hash en la interfaz. No cifra toda la base y no simula seguridad de servidor. Un supervisor autorregistrado es una decisión exigida por esta práctica local.

## Pruebas y evidencia

Ejecuta `zsh Scripts/test-domain.sh` para compilar los mismos modelos/servicios con Swift y ejecutar escenarios SwiftData en memoria y una base de disco temporal única. No toca la base del simulador. Ejecuta `zsh Scripts/build-simulator.sh` para compilar iOS; acepta un destino instalado como argumento. Los scripts no borran datos. El suite de dominio no es un target XCTest de Xcode.

El target `ComprasUITests` sí ejecuta XCTest en iOS: un recorrido B1–B9 con registro de ambos roles, catálogos, dos compras, aprobación, pago y resumen; y una prueba adicional de login claro/oscuro y error genérico. Ejecuta ⌘U o `zsh Scripts/test-ui.sh`. El argumento DEBUG explícito `--ui-testing` crea un contenedor en memoria sin datos iniciales y `--ui-dark` permite comprobar la apariencia oscura sin cambiar preferencias del simulador. Release no admite estas opciones. Las pruebas crean datos mediante los formularios y no contaminan la base normal.

Resultados reales: 36 comprobaciones de dominio; recorrido XCTest aprobado; prueba de login final y resultados de compilación descritos en [INFORME.md](INFORME.md). Las 17 capturas finales del recorrido y login están en Evidence con manifiestos de procedencia. No se presentan maquetas como ejecución real.

| Caso PDF | Comprobación |
|---|---|
| 1 | mtorres se registra e inicia sesión; MT ORRES se rechaza |
| 2 | Clave incorrecta: Usuario o clave incorrectos; sin sesión |
| 3 | 40 × 110; compra 10 × 120: subtotal 1200, IGV 216, total 1416; stock 50, promedio 112 y 30 días |
| 4 | Fixture independiente 40/110, misma compra contado: pagada, sin deuda |
| 5 | Fixture independiente 40/110; 50 × 120: total 7080, Pendiente, stock 40, costo 110, sin deuda |
| 6 | Se aprueba exactamente la compra del caso 5 a crédito: stock 90, promedio 115.555555… (115.56 mostrado), deuda 7080 |
| 7 | Otra compra grande: motivo vacío rechazado; motivo válido persistido; no cambia stock |
| 8 | Compra con fecha histórica: vencida; pagar reduce deuda 1416 y no altera stock |
| 9 | Otro comprador no ve compras; el original ve solo propias; pagar lanza error |

Además: claves cortas/distintas, autorización de creación/borrado/aprobación, .deny declarado y prevalidaciones de los tres padres, doble aprobación/pago, rechazada no se aprueba/paga, 5000 exactos y 4999.99, cantidad cero, infinito, stock cero, crédito fiscal y reapertura persistente con relaciones. Los casos 5/6 no se encadenan con el inventario modificado del caso 3.

Revisión manual y capturas de sustentación: probar ambos roles y todas las pestañas; alta/edición/cancelación de catálogos; swipe de borrado bloqueado con compras; formulario y aviso 5000; rechazo con motivo; aprobar y revisar proyección; pagar por botón y swipe con confirmación; búsquedas; reiniciar y comprobar datos; modo oscuro, texto grande, VoiceOver y teclado en pantalla pequeña. Para el icono ejecutar app y pulsar Inicio del simulador (⇧⌘H); capturar icono y nombre Compras. No considerar estas comprobaciones aprobadas sin ejecutarlas.

## Alcance académico y Git

> Este bloque conserva el contexto de la primera implementación. El prompt posterior autoriza las transferencias selectivas y su estado actual se registra en INFORME_REDISENO.md.

Se implementa exclusivamente Grupo B. El PDF exige expediente previo y visto bueno, y defensa oral; no se dispone de evidencia de su realización. Por instrucción del usuario se completa el código ahora, dejando documentos y diagramas académicos para otra fase. No se inventa aprobación del docente.

La rama ai-assisted conserva sus 15 commits exclusivos previos. Se copió solo Semana11 desde main en un commit de base, sin merge/rebase general. Las actividades 01/02 son idénticas a main, incluidos sus espacios preexistentes. Su restauración solo las incorpora a una rama que no las tenía. Los commits funcionales posteriores solo incluyen actividad 03 y documentación de Semana11. No integrar toda ai-assisted a main: sus historias previas difieren en otras semanas. La entrega debe trasladar únicamente los archivos de actividad 03, README y PROMPTS, con revisión final obligatoria.


## Rediseño y revalidación del 18 de noviembre de 2026

Las nueve pantallas conservan su funcionalidad y usan encabezados, tarjetas, botones y métricas compartidas. El icono, bundle, modelos y servicios no cambiaron. Consulta [la auditoría técnica A–H](AUDITORIA_TECNICA.md), con 22 preguntas para defensa, y [el informe del rediseño](INFORME_REDISENO.md) para resultados actuales e integración selectiva.

El esquema incluye ahora ComprasDomainTests (12 casos XCTest iOS) además del verificador macOS de 36 comprobaciones y los recorridos UI. Para la suite nueva usa `zsh Scripts/test-redesign.sh UDID_QA` con un dispositivo separado llamado Compras Rediseño QA. El recorrido persistente escribe únicamente en ese dispositivo y verifica cuentas/compras tras cerrar y abrir la app. Los otros recorridos usan memoria. La guarda del caso persistente evita ejecutarlo en un simulador personal.

Se conservan las evidencias anteriores. Las nuevas capturas, manifiestos, resultados y prueba de integridad están bajo `Evidence/Redesign-2026-11-18/`. No hay base SQLite publicada; la auditoría explica cómo obtener una copia de lectura local. El prompt nuevo autoriza transferencia selectiva a main y una base de procedencia asistida para manual; no autoriza fusionar historias completas ni atribuir desarrollo asistido a trabajo manual.

## Validación de productos · cierre de entrega

`ProductValidation` en `Business.swift` normaliza espacios y valida tanto altas como ediciones antes de modificar el contexto. Nombre: 2–120 caracteres; categoría: 2–60. Se rechazan únicamente los marcadores exactos `test`, `prueba`, `asdf`, `qwerty`, `producto de prueba` y nombres de cuatro o más letras idénticas sin distinguir mayúsculas (por ejemplo, `XXXxxx`). Es una heurística limitada, no una comprobación de existencia comercial. Se admiten marcas/códigos como 3M, HP, WD y X100.

El stock debe poder convertirse a `Int` y ser no negativo; el costo debe ser finito, no negativo y producir una valoración finita. Se acepta coma decimal. La combinación nombre/categoría es única tras normalizar espacios y mayúsculas; editar excluye el propio registro. Las categorías existentes se ofrecen como sugerencias, manteniendo texto libre. No se sanea ni migra ningún registro previo automáticamente. Las fórmulas de compras, permisos y modelos no cambian.

Los casos XCTest 13–24 cubren entradas vacías, espacios, límites de longitud, marcadores, marcas legítimas, duplicados en alta/edición, categorías, stock negativo/no numérico/overflow, costo no finito y alta/edición válidas. Usan contenedores aislados.
