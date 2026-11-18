# Archivos y propuesta de integración limitada

> Inventario histórico de la primera entrega. El inventario actual del rediseño se agrega al final; la autorización posterior permite la transferencia selectiva, sin merge general.

Raíz: `/Users/naomisanchez/Desktop/SanchezNaomi`. La propuesta contiene 52 rutas: README modificado de Semana11, PROMPTS nuevo y 50 archivos nuevos de actividad03. No incluye actividades01/02 ni otras semanas. No se ejecutó esta integración.

## Rutas exactas candidatas a main

```text
Semana11/README.md
Semana11/PROMPTS.md
Semana12/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
Semana12/apple_lab11_03_SwiftUI_Compras/COMMITS.md
Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj
Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/INFORME.md
Semana12/apple_lab11_03_SwiftUI_Compras/README.md
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift
Semana12/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift
```

## Árbol de la nueva actividad

```text
Semana12/apple_lab11_03_SwiftUI_Compras/
├── ARCHIVOS.md
├── COMMITS.md
├── Compras/
│   ├── ApprovalView.swift
│   ├── Assets.xcassets/
│   │   ├── AccentColor.colorset/
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset/
│   │   │   ├── AppIcon.png
│   │   │   └── Contents.json
│   │   └── Contents.json
│   ├── Business.swift
│   ├── ComprasApp.swift
│   ├── Design.swift
│   ├── HomeView.swift
│   ├── LoginView.swift
│   ├── Models.swift
│   ├── MyPurchasesView.swift
│   ├── NewPurchaseView.swift
│   ├── PayablesView.swift
│   ├── ProductsView.swift
│   ├── RegisterView.swift
│   ├── SummaryView.swift
│   └── SuppliersView.swift
├── Compras.xcodeproj/
│   ├── project.pbxproj
│   └── xcshareddata/
│       └── xcschemes/
│           └── Compras.xcscheme
├── Evidence/
│   ├── b1-error-generico-1.png
│   ├── b1-login-1.png
│   ├── b1-login-oscuro-1.png
│   ├── b2-registro-datos-1.png
│   ├── b2-registro-datos-2.png
│   ├── b2-registro-rol-1.png
│   ├── b2-registro-rol-2.png
│   ├── b3-productos-1.png
│   ├── b4-proveedores-1.png
│   ├── b5-nueva-compra-1.png
│   ├── b5-nueva-compra-2.png
│   ├── b6-mis-compras-1.png
│   ├── b7-aprobar-1.png
│   ├── b8-por-pagar-1.png
│   ├── b9-barras-y-equipo-1.png
│   ├── b9-resumen-1.png
│   ├── domain-tests.txt
│   ├── inicio-icono-compras-1.png
│   ├── login-tests-summary.json
│   ├── screenshots.json
│   └── ui-tests-summary.json
├── INFORME.md
├── README.md
├── Scripts/
│   ├── build-simulator.sh
│   ├── test-domain.sh
│   └── test-ui.sh
├── Tests/
│   └── BusinessTests.swift
└── UITests/
    └── ComprasUITests.swift
```

Las rutas por commit, incluidas las27 incorporaciones de la base previa, están en COMMITS.md. Estas27 no son candidatas a main: su contenido ya existe allí. Todas las modificaciones de desarrollo son de actividad03 o documentación de Semana11.


## Inventario de entrega del rediseño

Las rutas de actividad03 y documentación para transferencia selectiva son 90. No incluyen actividades01/02 para main, que ya las contiene. Manual recibe la base de Semana11 completa porque no tenía archivos de esa semana.

```text
Semana11/PROMPTS.md
Semana11/README.md
Semana12/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
Semana12/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md
Semana12/apple_lab11_03_SwiftUI_Compras/COMMITS.md
Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj
Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-error-generico-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-detalle-catalogo-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-productos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b4-proveedores-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-3.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-4.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b6-mis-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-aprobar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-todo-al-dia-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-pagadas-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-por-pagar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-vencidas-vacio-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-barras-y-equipo-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-resumen-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/database-observation.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-36.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-xctest.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/inicio-icono-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/integrity.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistence-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistencia-real-qa.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/run-3-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/screenshots.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/validation-results.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/INFORME.md
Semana12/apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md
Semana12/apple_lab11_03_SwiftUI_Compras/README.md
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-redesign.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh
Semana12/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift
Semana12/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift
```

### Archivos nuevos o modificados por el rediseño respecto de0ee9171

```text
Semana11/PROMPTS.md
Semana11/README.md
Semana12/apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md
Semana12/apple_lab11_03_SwiftUI_Compras/COMMITS.md
Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj
Semana12/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift
Semana12/apple_lab11_03_SwiftUI_Compras/DomainTests/ComprasDomainTests.swift
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-error-generico-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b1-login-oscuro-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-datos-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b2-registro-rol-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-detalle-catalogo-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b3-productos-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b4-proveedores-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-2.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-3.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b5-nueva-compra-4.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b6-mis-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-aprobar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b7-todo-al-dia-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-pagadas-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-por-pagar-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b8-vencidas-vacio-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-barras-y-equipo-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/b9-resumen-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/database-observation.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-36.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/domain-xctest.txt
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/inicio-icono-compras-1.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/integrity.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistence-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/persistencia-real-qa.png
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/run-3-summary.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/screenshots.json
Semana12/apple_lab11_03_SwiftUI_Compras/Evidence/Redesign-2026-11-18/validation-results.json
Semana12/apple_lab11_03_SwiftUI_Compras/INFORME.md
Semana12/apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md
Semana12/apple_lab11_03_SwiftUI_Compras/README.md
Semana12/apple_lab11_03_SwiftUI_Compras/Scripts/test-redesign.sh
Semana12/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift
```


## Organización final

La actividad se trasladó a Semana12 sin reescribir el historial Git. Las rutas documentales de esta lista se actualizaron a la ubicación vigente; los commits históricos conservan sus rutas originales. El inventario y los commits de este cierre se detallan en INFORME_CIERRE.md.
