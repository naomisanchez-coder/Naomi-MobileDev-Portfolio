# Rediseño y entrega selectiva · Compras Tecsup

Fecha: 18 de noviembre de 2026. Punto de partida auditado: ai-assisted/origin/ai-assisted en `0ee9171`; main/origin/main en cce498d; manual/origin/manual en `38c680a`; integrador/origin/integrador en ba8346c. Fetch autorizado correcto. El árbol de Semana11 estaba limpio.

## Protección del trabajo previo

Se detectaron seis eliminaciones locales ajenas: cinco archivos del proyecto raíz Lab00-GitXcode.xcodeproj y PROMPTS.md raíz. Se guardó una huella de su diff y se conservaron. No se restauraron, eliminaron nuevamente ni incluyeron en staging. Por ello no se afirma que el árbol global inicial/final esté limpio: Semana11 sí debe quedar limpio y los directorios de integración sí deben quedar limpios.

No se modificaron las actividades 01/02. Se verificó igualdad contra main. Models.swift, Business.swift, ComprasApp.swift y AppIcon conservan su contenido inicial; no hay cambios de esquema, migraciones, autenticación, fórmulas o reglas motivados por estética. No se añadieron dependencias externas. El icono aprobado, Display Name y bundle permanecen.

## Mejoras B1–B9

| Pantalla | Cambios de presentación |
|---|---|
| B1 | Encabezado de marca, composición con logo, fondo con profundidad, campos en tarjeta y acción principal |
| B2 | Encabezado de cuenta, secciones de datos/seguridad/rol y botón amplio; validaciones originales |
| B3 | Encabezado de inventario, tarjetas con categoría, stock semántico, costo y valoración |
| B4 | Tarjetas con icono, nombre/RUC, total comprado y estado; búsqueda y CRUD originales |
| B5 | Cabecera de operación, resumen monetario destacado, advertencia de aprobación en tarjeta y CTA en el flujo desplazable |
| B6 | Cabecera de seguimiento, filtros originales, tarjetas individuales y rechazo destacado |
| B7 | Cabecera de control, tarjeta con solicitante y proyección, acciones diferenciadas y vacío Todo al día |
| B8 | Cabecera de tesorería, tarjetas de deuda con vencimiento/estado, acción amplia y total separado |
| B9 | Dashboard con cuadrícula adaptable, métricas con tonos suaves, gráfico redondeado y actividad del equipo |

SurfaceCard, VisualHeader, IconTile, PrimaryActionStyle y EmptyPanel se reutilizan. Se preservaron los permisos y las cuatro/cinco pestañas. Dynamic Type de accesibilidad usa una columna en dashboard; no hay alturas fijas para sus textos. No se atribuye una auditoría completa de VoiceOver a estas mejoras.

## Commits visuales progresivos

Todos se compilaron antes de registrar y publicar en origin/ai-assisted; staging de rutas explícitas, diff --cached --check y revisión de nombres.

| Hash | Mensaje |
|---|---|
|09f1928|style: renovar diseño de login y registro|
|ff17be6|style: mejorar interfaces de productos y proveedores|
|e687268|style: rediseñar formulario y resumen de nueva compra|
|a8edf46|style: modernizar historial y estados de compras|
|44978f3|style: mejorar aprobación y cuentas por pagar|
|6d908fb|style: renovar dashboard y componentes visuales|

## Validación

Debug de los seis grupos: BUILD SUCCEEDED. Release: BUILD SUCCEEDED, con el aviso de AppIntents sin dependencia de ese framework. Verificador original: 36 comprobaciones correctas, en memoria y disco temporal; no es XCTest. Nuevo target ComprasDomainTests: XCTest iOS, casos 1–9, frontera/borrado, reapertura persistente y CRUD supervisor. El código de producción que prueba es el mismo servicio conservado.

QA independiente: Compras Rediseño QA, UDID ABA6697D-2B9A-419C-85C8-759A286D2AC7, iOS 26.5. No se arrancó ni borró el dispositivo de la estudiante. Los recorridos en memoria crean qa-redesign-supervisor y qa-redesign-comprador. El recorrido persistente usa qa-sup/qa-buy con sufijo UUID y guarda en el contenedor QA; la guarda omite el caso fuera de QA. El script test-redesign.sh exige el dispositivo independiente.

Las primeras ejecuciones UI detectaron que el punto accesible del campo de costo quedaba bajo la barra Listo del teclado; tocarlo no daba foco. Se conservan esos fallos en el historial de validación y no se cuentan como aprobados. Se corrigió el recorrido para descartar el teclado entre campos. También se selecciona la primera acción Aprobar cuando hay varias tarjetas pendientes. No se modificó el servicio para resolver pruebas.

Resultados efectivos de la versión final, en ejecuciones separadas:

| Comprobación | Resultado real |
|---|---|
| Verificador original macOS | 36 comprobaciones correctas |
| ComprasDomainTests iOS | 12 casos aprobados, incluidos los nueve escenarios y CRUD/persistencia |
| UI acceso y error genérico | Aprobado, 15.432 s, Tests-3 |
| UI recorrido B1–B9/roles/estados | Aprobado, 225.352 s, Tests-3 |
| UI persistencia y navegación tras relanzar | Aprobado, 104.124 s, Persistence-6 |
| Release y Debug | BUILD SUCCEEDED |

Son 15 casos XCTest finales distintos aprobados, no una afirmación de que la ejecución completa Tests-3 fuera verde: allí falló el caso persistente antiguo. Las repeticiones aisladas 4/5 tampoco se cuentan como aprobadas. El caso final con nombre inequívoco, espera de pestaña y artefactos nuevos pasó en Persistence-6. Se conservan resumen intermedio y mapeo final por caso en Evidence/Redesign-2026-11-18/validation-results.json y los resúmenes originales. No se falsifican pruebas manuales.

Se guardaron 26 capturas PNG nuevas con manifiesto de caso, dispositivo y origen; se conservaron las 17 anteriores. Incluyen ambos roles, pendiente, aprobada, rechazada con motivo, contado, pagada, filtros vacíos, dashboard, claro/oscuro, icono y persistencia. Vencida real se verificó en dominio con fecha histórica; la captura UI Vencidas muestra un filtro vacío, no una deuda vencida inventada.

La lectura de un snapshot QA confirmó SQLite format 3, quick_check=ok, 12 cuentas ficticias y 4 compras acumuladas por los intentos. La copia queda solo en /private/tmp; no se publica la base. Ruta y comandos seguros están en AUDITORIA_TECNICA.md.

## Casos de negocio

Los nueve casos siguen la guía: registro duplicado, login genérico,10×120 crédito con1200/216/1416 y50/112, contado pagado,50×120 pendiente con7080 sin efectos, aprobación a90/115.56, rechazo con motivo sin inventario, vencimiento/pago y visibilidad/roles. Los casos 5/6 usan fixture independiente 40/110. Se verifica 5000 inclusive, aplicación única, borrado bloqueado y persistencia. El test de CRUD verifica creación/edición/borrado sin compras; no se simula un gesto UI como resultado de ese test de servicio.

## Preparación de manual e integración a main

Estado al congelar la base asistida para transferencia: las pruebas y el rediseño están validados. La preparación de manual y la integración selectiva a main están autorizadas y se ejecutan después de este snapshot; sus hashes y verificaciones se registrarán al cerrar la entrega. Esta versión no afirma que esas operaciones ya se hayan publicado. Manual conservará este snapshot como procedencia; main recibirá la actualización final del informe.

## Auditoría para defensa y datos

[AUDITORIA_TECNICA.md](AUDITORIA_TECNICA.md) explica arquitectura real, funciones concretas, relaciones, permisos y PBKDF2, limitaciones y 22 preguntas en primera persona. Incluye la ruta observada del almacén QA y el procedimiento de snapshot de SQLite en modo lectura. No se publica una base de datos ni hashes de cuentas reales.

## Comprobaciones manuales recomendadas

La estudiante comunica validación manual de la versión anterior. Para este rediseño quedan recomendadas VoiceOver de todas las pantallas, texto máximo en dispositivos pequeños, orientación, contraste de estados vacíos/errores y gestos de edición/borrado. No se presentan como pruebas manuales ejecutadas por el agente. Consultar los resultados UI para distinguir acciones efectivamente automatizadas de las comprobaciones del servicio.
