# Informe de cierre · Compras Tecsup · Laboratorio 11 Grupo B

## Estado y alcance

La ubicación definitiva es `Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj`. La carpeta es de organización de entrega; el laboratorio sigue siendo el 11. Se conserva el nombre, Bundle Identifier, icono, modelos, relaciones y almacenamiento de la app.

Inicialmente ai-assisted@f268595 y main@7e7efcd estaban sincronizadas con origin. Existían dos cambios visuales locales y seis eliminaciones ajenas. Semana12 no existía. Se detectaron registros obsoletos de worktrees temporales inexistentes; solo se retiró su metadato y se preparó main en `/private/tmp/compras-cierre/main`, conservando todos los commits y sin modificar ramas manual/integrador.

Las seis eliminaciones previas permanecen sin stage ni publicación:

```text
 D Lab00-GitXcode.xcodeproj/project.pbxproj
 D Lab00-GitXcode.xcodeproj/project.xcworkspace/contents.xcworkspacedata
 D Lab00-GitXcode.xcodeproj/xcuserdata/naomisanchez.xcuserdatad/xcschemes/xcschememanagement.plist
 D Lab00-GitXcode.xcodeproj/xcuserdata/tecsup.xcuserdatad/xcdebugger/Breakpoints_v2.xcbkptlist
 D Lab00-GitXcode.xcodeproj/xcuserdata/tecsup.xcuserdatad/xcschemes/xcschememanagement.plist
 D PROMPTS.md
```

## Rediseño publicado

Design.swift y LoginView.swift: hero de carrito, caja, tarjeta y sello con SF Symbols, paleta azul profundo/turquesa/violeta/coral, fondos adaptativos, bordes degradados y sombras. Se elimina «TECSUP · GRUPO B» del login, se conserva Compras Tecsup. Los componentes compartidos mejoran B1/B2 acceso/registro, B3/B4 catálogos, B5 formulario/resumen monetario, B6 historial, B7 aprobación, B8 deuda y B9 dashboard. No se regeneró el icono ni se cambiaron los flujos.

## Validación de productos

Nombre normalizado de 2–120 caracteres y categoría de 2–60; colapso de espacios y extremos. Marcadores exactos: test, prueba, asdf, qwerty, producto de prueba. Seis letras idénticas sin distinguir mayúsculas se rechazan (XXXxxx). Se aceptan 3M, HP, WD, AAAA, X100 y otros códigos comerciales. La heurística no verifica universalmente la existencia del producto.

Stock convertible a Int, sin overflow y no negativo; costo finito no negativo con valoración finita. Coma decimal admitida. Duplicados por nombre/categoría normalizados en alta y edición, excluyendo el propio registro. Sugerencias de categorías existentes sin lista cerrada. Toda validación se aplica en el servicio antes de mutar datos; la conversión del formulario es reutilizable. No se modificaron registros preexistentes ni se hizo una migración del esquema.

Business.swift solo cambió en ProductValidation y product(...). Se comparó el resto de su contenido con el original y es idéntico: PBKDF2, roles, IGV, promedio ponderado, compras, aprobaciones, pagos y vencimientos conservados.

## Compilaciones y pruebas reales

- Debug del rediseño en Semana11: BUILD SUCCEEDED.
- Debug del traslado en Semana12: BUILD SUCCEEDED.
- Debug y Release en el worktree de main: BUILD SUCCEEDED. Release definitivo después del ajuste comercial: BUILD SUCCEEDED.
- Dominio CLI: 36 comprobaciones correctas tanto antes del traslado como desde el commit de main en Semana12, con contenedores de memoria/disco temporal.
- XCTest previo: 24 casos, cero fallos; revalidación definitiva: 24 casos, cero fallos.
- UI antes de integrar: 3 casos, cero fallos; login 16.962 s, persistencia 111.271 s, recorrido B1–B9/roles 238.138 s.
- Suite final desde el commit de main: **27 casos aprobados (24 dominio + 3 UI), cero fallos y cero omitidos; TEST SUCCEEDED**.

Las pruebas usan el simulador independiente Compras Rediseño QA (ABA6697D-2B9A-419C-85C8-759A286D2AC7). Los casos habituales UI usan memoria; el de persistencia usa cuentas ficticias con sufijos únicos en QA y está protegido por el nombre del dispositivo. No se usó ni borró la base del simulador habitual de la estudiante. Los xcresult y logs completos quedan en `/private/tmp/compras-cierre`; son temporales y no se publican. Las evidencias resumidas están en `Evidence/Final-2026-11-18`.

### Casos de laboratorio

| Caso | Resultado comprobado por el dominio |
|---|---|
| 1 | mtorres duplicado normalizado rechazado |
| 2 | Login incorrecto con error genérico |
| 3 | 40/110 + 10×120 crédito: subtotal1200, IGV216, total1416, stock50, promedio112, vence30 días |
| 4 | Contado pagada, sin deuda |
| 5 | Base independiente40/110; 50×120 total7080 pendiente, stock40, sin deuda |
| 6 | Aprobar caso5: stock90, promedio10400/90=115.555…; presentación115.56, deuda si crédito |
| 7 | Rechazo exige motivo y no cambia inventario |
| 8 | Vencida detectada; pago reduce deuda, sin doble efecto de stock |
| 9 | Comprador ve solo propias y no puede pagar/aprobar |

También se comprobaron frontera5000 inclusive, reaprobación/doble pago bloqueados, relaciones .deny, CRUD supervisor, autenticación, persistencia y roles. Los casos13–24 agregan las 12 categorías de prueba de productos solicitadas, incluyendo edición inválida sin mutación y códigos legítimos. No se afirma una nueva evaluación manual ni una prueba exhaustiva en todos los dispositivos.

## Organización y preservación

```text
Semana11/
├── README.md                      # conserva actividades 01/02
├── apple_lab11_01_UIKit_CoreData/  # idéntica
└── apple_lab11_02_SwiftUI_SwiftData/ # idéntica
Semana12/
├── README.md
├── PROMPTS.md                     # historial específico de Compras
└── apple_lab11_03_SwiftUI_Compras/
    ├── Compras.xcodeproj/
    ├── Compras/                    # Swift y Assets
    ├── DomainTests/
    ├── UITests/
    ├── Tests/
    ├── Scripts/
    ├── Evidence/
    ├── README.md
    ├── AUDITORIA_TECNICA.md
    ├── INFORME.md
    ├── INFORME_REDISENO.md
    ├── INFORME_CIERRE.md
    ├── COMMITS.md
    └── ARCHIVOS.md
```

Se trasladaron con git mv los 88 archivos versionados de la actividad y su PROMPTS específico. El README compartido se separó por secciones, preservando exactamente el prefijo anterior de actividades01/02. Se actualizaron referencias de rutas en documentación propia, manteniendo el historial académico. No queda una copia del proyecto en Semana11. Un archivo ignorado de estado de usuario de Xcode se conservó fuera del repositorio en `/private/tmp/compras-cierre/estado-xcode-previo/Compras.xcodeproj/project.xcworkspace/xcuserdata/naomisanchez.xcuserdatad/UserInterfaceState.xcuserstate`. No se trasladaron bases privadas ni DerivedData.

Se verificaron hashes de todos los archivos versionados de actividades01/02, Models.swift, ComprasApp.swift, HomeView.swift e icono frente al inicio. Se preservaron todas las diferencias ajenas. No hubo merge completo, reset/clean, staging global, force push, rebase ni reescritura de historia.

## Commits y rutas exactas

Los nombres de las rutas siguientes son los que aparecen en cada commit, no una reconstrucción retroactiva:

### bf41379 · style: finalizar identidad visual de Compras Tecsup · ai-assisted

```text
M	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
M	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
```

### da3181a · fix: fortalecer validaciones de productos y evitar registros invalidos · ai-assisted

```text
M	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
M	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
M	Semana11/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift
M	Semana11/apple_lab11_03_SwiftUI_Compras/README.md
```

### dba7150 · refactor: trasladar actividad Compras Tecsup a Semana12 · ai-assisted

```text
M	Semana11/README.md
D	Semana11/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
D	Semana11/apple_lab11_03_SwiftUI_Compras/COMMITS.md
R092	Semana11/PROMPTS.md	Semana12/PROMPTS.md
A	Semana12/README.md
A	Semana12/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md	Semana12/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md
A	Semana12/apple_lab11_03_SwiftUI_Compras/COMMITS.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj	Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme	Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift	Semana12/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-error-generico-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-error-generico-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-detalle-catalogo-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-detalle-catalogo-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-productos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-productos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b4-proveedores-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b4-proveedores-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-3.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-3.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-4.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-4.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b6-mis-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b6-mis-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-aprobar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-aprobar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-todo-al-dia-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-todo-al-dia-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-pagadas-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-pagadas-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-por-pagar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-por-pagar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-vencidas-vacio-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-vencidas-vacio-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-barras-y-equipo-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-barras-y-equipo-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-resumen-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-resumen-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/database-observation.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/database-observation.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-36.txt	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-36.txt
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-xctest.txt	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-xctest.txt
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/inicio-icono-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/inicio-icono-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/integrity.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/integrity.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistence-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistence-summary.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistencia-real-qa.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistencia-real-qa.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/run-3-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/run-3-summary.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/screenshots.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/screenshots.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/validation-results.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/validation-results.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json
R098	Semana11/apple_lab11_03_SwiftUI_Compras/INFORME.md	Semana12/apple_lab11_03_SwiftUI_Compras/INFORME.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md	Semana12/apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/README.md	Semana12/apple_lab11_03_SwiftUI_Compras/README.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-redesign.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-redesign.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift	Semana12/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift
```

### 25057f1 · fix: preservar codigos comerciales en validacion de nombres · ai-assisted

```text
M	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
M	Semana12/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift
M	Semana12/apple_lab11_03_SwiftUI_Compras/README.md
```

### 99c7ae2 · chore: organizar entrega final de Compras en Semana12 · main

Transferencia selectiva; ninguna fusión de historias completas.

```text
M	Semana11/README.md
D	Semana11/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
D	Semana11/apple_lab11_03_SwiftUI_Compras/COMMITS.md
R092	Semana11/PROMPTS.md	Semana12/PROMPTS.md
A	Semana12/README.md
A	Semana12/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md	Semana12/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md
A	Semana12/apple_lab11_03_SwiftUI_Compras/COMMITS.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj	Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme	Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json
R075	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift
R062	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift
R072	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift
R089	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift
R066	Semana11/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift	Semana12/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-error-generico-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-error-generico-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-detalle-catalogo-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-detalle-catalogo-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-productos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-productos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b4-proveedores-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b4-proveedores-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-3.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-3.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-4.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-4.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b6-mis-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b6-mis-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-aprobar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-aprobar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-todo-al-dia-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-todo-al-dia-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-pagadas-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-pagadas-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-por-pagar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-por-pagar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-vencidas-vacio-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-vencidas-vacio-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-barras-y-equipo-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-barras-y-equipo-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-resumen-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-resumen-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/database-observation.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/database-observation.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-36.txt	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-36.txt
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-xctest.txt	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-xctest.txt
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/inicio-icono-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/inicio-icono-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/integrity.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/integrity.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistence-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistence-summary.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistencia-real-qa.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistencia-real-qa.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/run-3-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/run-3-summary.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/screenshots.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/screenshots.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/validation-results.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/validation-results.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json	Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json
R098	Semana11/apple_lab11_03_SwiftUI_Compras/INFORME.md	Semana12/apple_lab11_03_SwiftUI_Compras/INFORME.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md	Semana12/apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md
R089	Semana11/apple_lab11_03_SwiftUI_Compras/README.md	Semana12/apple_lab11_03_SwiftUI_Compras/README.md
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-redesign.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-redesign.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh	Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh
R100	Semana11/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift	Semana12/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift
R100	Semana11/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift	Semana12/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift
```

El cierre documental posterior se registra por separado en ai-assisted y main, conservando las mismas versiones finales de los documentos y evidencias. Los hashes de esos commits documentales se entregan en el informe del chat para evitar una referencia circular al propio commit.


## Datos y límites

La base SwiftData sigue en el contenedor instalado, en Library/Application Support/Compras.store. El cambio de ruta del repositorio no la mueve; depende del Bundle Identifier, que permanece igual. No se copian registros privados a Git. Las pruebas son académicas locales, sin seguridad de servidor. Los resúmenes anteriores y las capturas previas se conservan como evidencias históricas, sin presentarlas como capturas nuevas de este cierre.

Abrir el proyecto con Xcode desde Semana12, seleccionar Compras y un simulador iOS17+. Para revisión manual se recomienda confirmar teclado/contraste/Dynamic Type en el dispositivo de exposición y probar una entrada real de catálogo; los resultados automatizados no equivalen a esa revisión manual. No se instala la versión Release en el dispositivo de la estudiante.


## Estado de ramas al cierre

ai-assisted permanece como rama activa del repositorio principal; main se trabaja aisladamente en `/private/tmp/compras-cierre/main`. Ambas contienen los mismos archivos finales de Semana11/12 correspondientes a esta entrega, sin fusionar sus historias completas. La integración de código en main es 99c7ae2; el código validado de ai-assisted es 25057f1. Los commits documentales posteriores solo agregan el informe y evidencias. Los resultados de publicación se verifican con origin y se entregan con los hashes finales en el chat.

manual conserva bbda928d0b36a9ed1bbd413a272ccd448d7d84ed e integrador ba8346c05852833fa66722fd7ed00e26f81eef1d, ambos idénticos a sus referencias iniciales. El worktree de main queda limpio al finalizar; el repositorio principal conserva exclusivamente las seis eliminaciones locales ajenas.

Documentación vigente: README de Semana11 (actividades01/02), README y PROMPTS de Semana12, README propio, AUDITORIA_TECNICA.md actualizada e INFORME_CIERRE.md. COMMITS.md y ARCHIVOS.md preservan sus listas históricas e indican la nueva organización. Las rutas exactas del cierre documental son los dos README/PROMPTS de Semana12 que cambien y los documentos/evidencias dentro de la actividad; se revisaron antes del commit. No se modificó ningún archivo fuente después de la suite final.

## Archivos exactos del cierre documental

```text
Semana12/README.md
Semana12/PROMPTS.md
Semana12/apple_lab11_03_SwiftUI_Compras/README.md
Semana12/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
Semana12/apple_lab11_03_SwiftUI_Compras/COMMITS.md
Semana12/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md
Semana12/apple_lab11_03_SwiftUI_Compras/INFORME_CIERRE.md
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Final-2026-11-18/domain-36-main.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Final-2026-11-18/domain-36.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Final-2026-11-18/integrity.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Final-2026-11-18/main-final-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Final-2026-11-18/product-validation-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Final-2026-11-18/ui-before-integration-summary.json
```

La publicación de la integración 99c7ae2 en origin/main fue confirmada antes de este cierre documental.
