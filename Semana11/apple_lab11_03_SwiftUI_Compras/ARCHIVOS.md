# Archivos y propuesta de integración limitada

Raíz: `/Users/naomisanchez/Desktop/SanchezNaomi`. La propuesta contiene 52 rutas: README modificado de Semana11, PROMPTS nuevo y 50 archivos nuevos de actividad03. No incluye actividades01/02 ni otras semanas. No se ejecutó esta integración.

## Rutas exactas candidatas a main

```text
Semana11/README.md
Semana11/PROMPTS.md
Semana11/apple_lab11_03_SwiftUI_Compras/ARCHIVOS.md
Semana11/apple_lab11_03_SwiftUI_Compras/COMMITS.md
Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/project.pbxproj
Semana11/apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj/xcshareddata/xcschemes/Compras.xcscheme
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ApprovalView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AccentColor.colorset/Contents.json
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/AppIcon.png
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/AppIcon.appiconset/Contents.json
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Assets.xcassets/Contents.json
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Business.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ComprasApp.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Design.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/HomeView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/LoginView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/Models.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/MyPurchasesView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/NewPurchaseView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/PayablesView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/ProductsView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/RegisterView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/SummaryView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Compras/SuppliersView.swift
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-error-generico-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b1-login-oscuro-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-datos-2.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b2-registro-rol-2.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b3-productos-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b4-proveedores-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b5-nueva-compra-2.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b6-mis-compras-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b7-aprobar-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b8-por-pagar-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b9-barras-y-equipo-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/b9-resumen-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/domain-tests.txt
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/inicio-icono-compras-1.png
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/login-tests-summary.json
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/screenshots.json
Semana11/apple_lab11_03_SwiftUI_Compras/Evidence/ui-tests-summary.json
Semana11/apple_lab11_03_SwiftUI_Compras/INFORME.md
Semana11/apple_lab11_03_SwiftUI_Compras/README.md
Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/build-simulator.sh
Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh
Semana11/apple_lab11_03_SwiftUI_Compras/Scripts/test-ui.sh
Semana11/apple_lab11_03_SwiftUI_Compras/Tests/BusinessTests.swift
Semana11/apple_lab11_03_SwiftUI_Compras/UITests/ComprasUITests.swift
```

## Árbol de la nueva actividad

```text
Semana11/apple_lab11_03_SwiftUI_Compras/
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
