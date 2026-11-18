# Semana12 · Compras Tecsup

Organización de entrega del **Laboratorio 11, Grupo B**. El número oficial del laboratorio no cambia. Las actividades 01 y 02 permanecen en Semana11.

## Actividad 03: Compras Tecsup · Grupo B

Aplicación independiente en `apple_lab11_03_SwiftUI_Compras/Compras.xcodeproj` (esquema **Compras**, Display Name **Compras**). Implementa las nueve pantallas B1–B9 del caso Compras de LAB11-MÓVILESS con SwiftUI, SwiftData, Observation y Charts. Las actividades 01 y 02 conservan exactamente sus archivos.

- **Comprador:** consulta productos/proveedores, registra compras al contado o crédito 30 días y ve solo sus compras.
- **Supervisor:** mantiene catálogos, aprueba o rechaza con motivo, paga créditos y consulta inventario, crédito fiscal, deuda y barras por proveedor.
- **Validaciones:** usuario único normalizado, claves confirmadas de mínimo seis caracteres (PBKDF2 con sal, sin texto plano), roles en servicios, importes positivos y finitos, aprobación desde S/ 5000, promedio ponderado, efectos de inventario una sola vez y borrado bloqueado con compras.
- **Ejecución:** abrir el proyecto y ejecutar en simulador iOS 17+. Registrar Supervisor para crear catálogos; cerrar sesión y registrar Comprador. No hay datos demo automáticos.
- **Pruebas:** `zsh apple_lab11_03_SwiftUI_Compras/Scripts/test-domain.sh` ejecuta escenarios aislados en memoria y disco temporal. El esquema Compras también incluye pruebas XCTest de interfaz con base en memoria.

Consulta [la documentación técnica de Compras](apple_lab11_03_SwiftUI_Compras/README.md) y [el registro de IA](PROMPTS.md). Las comprobaciones reales y límites de validación se detallan en el informe de la actividad. El estado de integración selectiva se registra en el informe del rediseño; no se fusionan historias completas.


### Rediseño y auditoría de Compras

La actividad 03 incorpora una presentación renovada B1–B9 sin cambiar modelos, autenticación ni reglas. Se conserva el icono aprobado. [Auditoría técnica](apple_lab11_03_SwiftUI_Compras/AUDITORIA_TECNICA.md) explica arquitectura, persistencia, permisos, PBKDF2 y 22 preguntas de sustentación. [Informe de rediseño](apple_lab11_03_SwiftUI_Compras/INFORME_REDISENO.md) registra pruebas reales y las transferencias selectivas autorizadas a manual y main, con procedencia asistida explícita. Las actividades 01/02 y sus descripciones se mantienen.
