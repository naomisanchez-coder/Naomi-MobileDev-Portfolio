# Informe de implementación · Compras Tecsup · Grupo B

> **Informe histórico de la implementación inicial.** El prompt posterior autoriza el rediseño y la integración selectiva. El estado actual y las verificaciones nuevas están en [INFORME_REDISENO.md](INFORME_REDISENO.md); la explicación para defensa, en [AUDITORIA_TECNICA.md](AUDITORIA_TECNICA.md). Las restricciones de integración descritas más abajo pertenecen a la fase anterior.

## Entrega y alcance

Proyecto: `/Users/naomisanchez/Desktop/SanchezNaomi/Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj`. Abrir con Xcode, esquema Compras, iPhone 17 Pro / iOS 26.5 y ⌘R. Mínimo iOS 17. La implementación B1–B9, arquitectura, modelos, permisos, reglas y ejemplos se describen en [README del proyecto](README.md); el uso de IA, en [PROMPTS](../PROMPTS.md).

Solo se desarrolló Grupo B. No se crearon Word ni diagramas finales. La guía académica exige expediente/visto bueno docente y defensa oral: no se recibió evidencia de los primeros y no se afirma su cumplimiento. Se continuó por solicitud expresa del usuario. No se tocó hardware, permisos del sistema ni protecciones.

## Auditoría e historia Git

Raíz real comprobada: `/Users/naomisanchez/Desktop/SanchezNaomi`. Remoto HTTPS: `https://github.com/naomisanchez-coder/Naomi-MobileDev-Portfolio.git`. Inicio en main limpio; sin cambios staged/untracked ajenos. Había .DS_Store y datos personales de Xcode ignored en Semana11; no se publicaron ni eliminaron.

Antes de desarrollar: main tenía 58 commits exclusivos y ai-assisted 15; ancestro común `cfa4da5257fc74ce29ee9e8257dd88a18a8a472d`. ai-assisted no contenía Semana11. Se cambió una vez de main a la rama existente ai-assisted. No se crearon ramas equivalentes ni worktrees.

Se incorporó exclusivamente la carpeta Semana11 de main en `9487b69`. Este es un commit de base, no de modificaciones de las actividades anteriores: sus 27 archivos son idénticos a main. La comprobación de whitespace detectó espacios y líneas finales preexistentes en AppDelegate/SceneDelegate de actividad 01; se conservaron y se verificó el árbol exacto contra main antes de registrar la base. Solo para ese commit se deshabilitó la detección de esos dos tipos de whitespace en la comprobación, sin cambiar configuración persistente ni archivos. Todos los commits posteriores se revisaron con diff --cached --check normal.

No hubo merge amplio, rebase, reset, clean, stash, force push ni borrado de archivos. Los commits previos de todas las ramas permanecen. Los commits de esta ejecución solo incluyen rutas Semana11. Actividades01/02 son idénticas a main al finalizar; no se afirma que no aparezcan como incorporaciones en el commit de base, porque ai-assisted no las tenía.

Los primeros fetch/Git locales requirieron autorización adicional al sandbox y se ejecutaron por el mecanismo disponible. El primer push falló por token inválido, confirmado con HTTP401 de gh auth status. Se suspendió únicamente la publicación. Tras la renovación realizada por el usuario, se verificaron autenticación, rama, commits y contenido, y se publicaron los pendientes únicamente a origin/ai-assisted. Los commits posteriores se publicaron después de validar y revisar staging explícito.

Puntas originales, que deben permanecer intactas:

| Rama | Hash |
|---|---|
| main | cce498d7631fd746d9e6b33fcef3948a41ab517c |
| manual | 38c680aac65355e9fcc89f9bdf2445e185ea2400 |
| integrador | ba8346c05852833fa66722fd7ed00e26f81eef1d |

El inventario de hashes, mensajes y rutas exactas por commit se conserva en [COMMITS.md](COMMITS.md). El commit final de documentación se identifica con `git log -1` y en la entrega del chat; ese commit incluye README de Semana11, PROMPTS y documentación/evidencia de actividad03.

## Reglas y resultados numéricos

| Escenario | Resultado verificado en pruebas de dominio |
|---|---|
| Registro | mtorres inicia sesión; MT ORRES se rechaza, igual que claves cortas/distintas |
| Login | Incorrecto produce Usuario o clave incorrectos, sin revelar el campo fallido |
| 40 unidades a costo 110; 10 a120 crédito | Subtotal 1200, IGV 216, total 1416; Aprobada; stock 50, promedio 112; vence+30 días |
| Misma compra contado, fixture propio | Aprobada, pagada, sin deuda |
| 40/110; 50 a120 crédito | Total 7080, Pendiente, stock 40/costo 110, sin deuda |
| Aprobar anterior | Stock 90; promedio 10400/90 = 115.555555…; se muestra 115.56; deuda 7080 |
| Rechazo | Motivo vacío falla; motivo válido se guarda; inventario y deuda no cambian |
| Vencida y pago | Fecha histórica aparece vencida; pagar reduce deuda 1416 y conserva stock |
| Privacidad/roles | Comprador solo ve propias; no puede pagar, aprobar ni mantener catálogos |
| Frontera | 4999.99 no requiere aprobación; 5000 exactos sí, sin efectos iniciales |
| Unicidad de efectos | Reaprobar y doble pago fallan; stock no se aplica nuevamente |
| Borrado | Prevalidación bloquea tres padres con compras; las relaciones declaran .deny |
| Persistencia | Reabrir contenedor de disco temporal conserva compra, stock y relaciones |

Los casos 5/6 usan un producto independiente con stock 40/costo 110 y compra a crédito. No usan el stock 50 del caso3. El IGV del conjunto de compras aprobadas del suite es 1512 (216+216+1080), excluyendo pendiente/rechazada. La prueba de persistencia no elimina ni abre la base normal del simulador.

## Validación y límites

- Xcode 26.6 (17F113), destino instalado iPhone 17 Pro / iOS 26.5.
- Compilación Debug y Release finales: BUILD SUCCEEDED. El asset AccentColor faltante detectado en la primera compilación Release se añadió y el aviso desapareció. Aviso de metadatos AppIntents omitidos porque la app no usa ese framework; no afecta la compilación.
- Dominio: 36 comprobaciones correctas con los mismos Models.swift/Business.swift compilados para macOS. Resultado real en [Evidence/domain-tests.txt](Evidence/domain-tests.txt). No se presenta este suite como XCTest iOS. Se añadió una comprobación específica de edición completa por supervisor tras retirar la restricción extra inicial.
- Se instaló el bundle nuevo y simctl launch devolvió un PID. Capturas reales revisadas visualmente.
- Recorrido XCTest final: `testScreensAndRoles()` aprobado, 1 prueba y 0 fallos, 170.651 segundos; resultado en `Evidence/ui-tests-summary.json`. Verifica registro inmediato, logout/login, 4/5 pestañas por rol, productos/proveedor, compras pequeñas/grandes, aprobación, pago y resumen; usa memoria.
- Prueba adicional de login final: `testLoginAppearanceAndInvalidCredentials()` aprobada, 1 prueba y 0 fallos, 16.605 segundos. Verifica login claro/oscuro y error genérico real. Resultado en `Evidence/login-tests-summary.json`. Un primer filtro de este caso seleccionó 0 pruebas pese a devolver éxito; se descartó y se ejecutó el identificador completo con paréntesis. No se cuenta la selección vacía como prueba aprobada.
- Se exportaron 17 capturas PNG reales con procedencia en `Evidence/screenshots.json`. Las de B1 fueron actualizadas tras la mejora final de etiquetas/tarjeta. La de Inicio muestra icono y nombre Compras con aplicaciones previas aún presentes. No se eliminó ningún dato de simulador.
- Bundle Release inspeccionado: identificador `edu.pe.tecsup.naomisanchez.compras`, display name Compras, mínimo iOS 17.0 e icono AppIcon. Los modos de pruebas en memoria y apariencia forzada solo se compilan bajo DEBUG.
- Primera ejecución XCTest de interfaz falló al localizar el selector de proveedor con una etiqueta parcial. Se añadieron identificadores de accesibilidad estables. No se ocultó ese fallo ni se atribuye a una prueba manual aprobada.
- Segunda ejecución XCTest: llegó hasta B7 y falló porque la consulta del botón Aprobar también encontraba la pestaña del mismo nombre. Se añadió un identificador específico a la acción. No fue un fallo del cálculo de aprobación.
- Contrastes de colores principales calculados: petróleo/blanco 4.88:1, pizarra/humo 11.87:1, ámbar oscuro/blanco 6.59:1, turquesa/fondo oscuro 6.08:1. Esto no sustituye una auditoría completa de accesibilidad.
- AppIcon inspeccionado: PNG RGB opaco 1024×1024, sin recorte de esquinas.
- Tercera ejecución XCTest: TEST SUCCEEDED (1 prueba de recorrido, 0 fallos). La revisión de sus capturas detectó teclado sobre los importes y una captura de Inicio en transición; se añadió Listo al teclado, etiquetas permanentes y espera del icono. Se explicitó la apariencia oscura solo en DEBUG para obtener una captura verificable.
- El control gráfico CUA falló por sesión expirada; se usaron XCTest y simctl, sin cambiar protecciones.

La autorización es local y académica: el registro permite escoger Supervisor según la guía. PBKDF2 protege el campo clave, pero no sustituye autorización remota ni cifra toda la base. No hay backend ni API.

## Revisión manual y sustentación

Verificar en Xcode: borrado por swipe y su confirmación con y sin compras; cancelar ediciones sin cambios; búsqueda con tildes; filtro Vencidas con fecha real; rechazo y motivo visible; todos los roles; texto grande, VoiceOver, teclado, orientación y pantallas pequeñas. Estas comprobaciones no se declaran aprobadas automáticamente por los tests de lógica.

Para sustentar: explicar @Model, contexto/guardar, @Query/#Predicate, inversas y .deny, sesión @Observable, validación por rol, promedio ponderado, umbral 5000 y serialización de aprobación/pago. Para captura de icono: ejecutar y pulsar Inicio (⇧⌘H); mostrar Compras con su caja en verde. Las capturas exportadas de XCTest se identificarán en Evidence; no usar maquetas como evidencia de ejecución.

## Integración futura a main

No fusionar la rama completa: su historia anterior contiene diferencias de otras semanas. Integrar únicamente archivos nuevos bajo `Semana11/apple_lab11_03_SwiftUI_Compras/`, la ampliación de `Semana11/README.md` y `Semana11/PROMPTS.md`. No trasladar las actividades 01/02, que ya existen e idénticas en main. No hay autorización para merge/push a main en esta ejecución. Se solicita revisión final del usuario antes de esa fase.


El árbol completo y las 52 rutas exactas propuestas para main están en [ARCHIVOS.md](ARCHIVOS.md). Se debe revisar esa lista y autorizar expresamente la integración en una fase posterior.
