# Auditoría técnica · Compras Tecsup · Grupo B

Fecha: 18 de noviembre de 2026. Alcance: código existente y rediseño visual; no se han cambiado modelos, relaciones, fórmulas ni servicios. Esta explicación se basa en los archivos reales del proyecto, no en atribuirle un patrón que no implementa. La estudiante comunica que ya validó manualmente la funcionalidad anterior; esa comunicación no sustituye los resultados nuevos ejecutados aquí.

## A. Arquitectura del proyecto

El punto de entrada es [`ComprasApp`](Compras/ComprasApp.swift), una estructura SwiftUI con `@main`. Crea una única sesión `@State` y el contenedor SwiftData. Inyecta ambos al árbol de vistas mediante `.environment(sesion)` y `.modelContainer(container)`. Si no puede abrir el almacén, presenta el error; no borra el archivo ni lo sustituye silenciosamente por datos vacíos.

Cuando `sesion.usuario` es nil muestra LoginView. Cuando existe un usuario muestra HomeView. Este último conserva un TabView con cuatro pestañas para Comprador o cinco para Supervisor. Cuenta es un menú de avatar, no otra pestaña.

| Ubicación | Responsabilidad real |
|---|---|
| `Compras/ComprasApp.swift` | Arranque, contenedor, inyección y selección de raíz |
| `Compras/HomeView.swift` | Navegación por rol |
| `Compras/Models.swift` | Cuatro entidades, relaciones y configuración Store |
| `Compras/Business.swift` | Sesion, Password, AppError y ComprasService |
| `Compras/*View.swift` | Pantallas B1–B9 y formularios de edición |
| `Compras/Design.swift` | Paleta, tarjetas, botones, métricas, avatar y estados vacíos |
| `Compras/Assets.xcassets` | Icono aprobado y color de acento |
| `Tests/BusinessTests.swift` | Verificador Swift de 36 comprobaciones, ejecutado en macOS |
| `DomainTests/ComprasDomainTests.swift` | XCTest de dominio iOS: casos 1–9, frontera/borrado y reapertura |
| `UITests/ComprasUITests.swift` | XCTest de interfaz, roles, estados y relanzamiento persistente en QA |
| `Scripts/` | Comandos reproducibles de compilación y pruebas |
| `Evidence/` | Evidencia anterior conservada; rediseño en subcarpeta separada |

La organización es SwiftUI con modelos persistentes, sesión observable y un servicio de aplicación. No hay ViewModels para cada pantalla: no corresponde llamarla MVVM completa. Las vistas consultan mediante @Query y poseen estados de presentación (`@State`), por ejemplo búsqueda, hojas, selección y borradores. ComprasService concentra las mutaciones y sus validaciones. Algunos agregados del dashboard se calculan en las vistas; no existe una capa independiente de reportes.

El rediseño reutiliza SurfaceCard, VisualHeader, IconTile, PrimaryActionStyle, EmptyPanel, Metric y PurchaseRow. Son componentes de presentación: no guardan datos ni autorizan compras. Los filtros de las vistas y los servicios originales se conservan.

## B. Persistencia SwiftData

`@Model` transforma las clases de Models.swift en modelos persistentes observables. No significa que una instancia recién creada ya esté guardada: primero se incorpora al contexto y después se guarda.

`Store.schema` reúne Usuario, Proveedor, Producto y Compra. `Store.container(memory:url:)` construye ModelConfiguration y ModelContainer. El contenedor administra el esquema y el almacén. En la ejecución normal se usa `ModelConfiguration("Compras", schema:...)`, persistente. Para pruebas se solicita memoria o una URL temporal explícita. No hay un ModelContainerProvider adicional en esta actividad.

ModelContext es la unidad de trabajo. Las vistas obtienen el contexto del entorno. ComprasService recibe ese mismo contexto y desactiva autosave para ejecutar guardados explícitos. Su método `save()` llama `context.save()`; si falla, hace rollback y devuelve un mensaje útil. Los formularios de catálogo mantienen borradores String en @State; Cancelar no modifica modelos persistentes.

| Operación | Código concreto |
|---|---|
| Insertar usuario | `ComprasService.register`: `context.insert(u)` |
| Insertar compra | `registerPurchase`: `context.insert(c)` |
| Insertar catálogo | `product` y `supplier` cuando el parámetro existente es nil |
| Guardar | `ComprasService.save`, invocado por las operaciones |
| Borrar | Tres sobrecargas `delete`, después de validar rol y ausencia de compras |
| Consultar usuario | `exists` con FetchDescriptor/#Predicate/fetchCount; `login` con fetch |
| Consultar listas | @Query en ProductsView, SuppliersView, NewPurchaseView y otras vistas |

B6 conserva @Query ordenado por fecha y filtra por persistentModelID del comprador de sesión. B7 consulta únicamente Pendiente con #Predicate. B8 obtiene Aprobada + crédito y discrimina pagada mediante #Predicate; después aplica vencimiento y búsqueda localizada del proveedor en la colección observada. Productos y proveedores buscan nombre/categoría/RUC en memoria. @Query observa cambios, por eso no se llama reloadData.

Usuario, Producto y Proveedor tienen `compras: [Compra]` con `.deny` e inversas explícitas a `Compra.comprador`, `Compra.producto` y `Compra.proveedor`. Compra conserva esas tres relaciones opcionales. Un padre con compras no debe borrarse: además de declarar .deny, el servicio revisa el arreglo y muestra una explicación antes de pedir delete al contexto. Se incluyen pendientes y rechazadas; no solo aprobadas. La aplicación no expone borrado de compras.

Al reiniciar el proceso se vuelve a abrir el almacén, se recuperan los modelos y las consultas muestran sus datos. La sesión, en cambio, no se restaura automáticamente: requiere login de nuevo. Esto distingue persistencia de cuentas/compras de persistencia de sesión.

## C. Registro y autenticación

1. RegisterView recoge nombre, usuario, clave, confirmación y rol. La comprobación anticipada `exists` da aviso de duplicado; el servicio vuelve a comprobarlo al guardar.
2. `normalized` elimina espacios Unicode y convierte a minúsculas: `MT ORRES` y `mtorres` se normalizan igual. `@Attribute(.unique)` agrega una restricción persistente para el identificador normalizado.
3. `register` valida nombre/usuario no vacíos, longitud mínima de seis caracteres, confirmación idéntica y usuario no repetido.
4. Password.hash genera una sal de 16 bytes con SecRandomCopyBytes. Password.derive usa CommonCrypto: PBKDF2-HMAC-SHA256, 120000 iteraciones y salida de 32 bytes.
5. Se guarda en `Usuario.clave: String` un formato versionado con algoritmo, iteraciones, sal y derivado codificados en Base64. No se guarda la contraseña original. La sal es aleatoria y distinta por registro; no necesita ser secreta.
6. Después de insertar y guardar, `sesion.entrar(u)` produce ingreso inmediato.

En login, el servicio busca el usuario normalizado y Password.verify vuelve a derivar la clave introducida usando la sal almacenada. Solo admite el formato y número de iteraciones esperado. Compara los bytes sin salir al encontrar la primera diferencia. Esto describe la comparación implementada; no promete que toda la autenticación o el dispositivo sean inmunes a ataques de tiempo.

La interfaz siempre muestra `Usuario o clave incorrectos` ante un login fallido. No señala cuál campo falló. Los SecureField ocultan las claves. Esta auditoría no incluye contraseñas personales ni derivados de cuentas reales.

Sesion es `@Observable @MainActor`, con usuario de escritura privada. `entrar` y `salir` controlan el estado; cerrar sesión lo pone en nil y la raíz vuelve al login. El menú conserva nombre, usuario y rol, sin claves.

## D. Base de datos local y lectura segura

Los usuarios se guardan en el mismo almacén local de SwiftData que las compras y catálogos. La configuración está en Store.container, Models.swift. El sistema asigna un contenedor de datos por bundle y dispositivo; su UUID puede cambiar si se reinstala o se usa otro simulador. El bundle no cambió: `edu.pe.tecsup.naomisanchez.compras`.

Ruta real observada al finalizar las pruebas, en el **simulador QA nuevo**, no en el dispositivo de la estudiante:

```text
/Users/naomisanchez/Library/Developer/CoreSimulator/Devices/ABA6697D-2B9A-419C-85C8-759A286D2AC7/data/Containers/Data/Application/DE54AE8F-4F3C-435A-92D7-C114DCE6DB1A/Library/Application Support/Compras.store
```

Se generó un snapshot local con lectura SQLite en `/private/tmp/compras-redesign/qa-final-snapshot.sqlite`. Su cabecera identifica SQLite format 3 y `PRAGMA quick_check` devolvió `ok`. Contiene 12 usuarios ficticios acumulados por los intentos (6 Compradores y 6 Supervisores) y 4 compras QA; no se borraron los datos de intentos anteriores. El último caso registró una nueva pareja única y comprobó su compra tras relanzar. Estos conteos no son datos ni resultados de uso de la estudiante.

XCTest apagó QA al terminar; se localizó el contenedor por su metadata de bundle, sin arrancar el simulador personal. La ruta no es portable: consultar de nuevo el contenedor después de reinstalar o cambiar de dispositivo.

SwiftData proporciona la API de objetos; el almacén local observado utiliza SQLite. La aplicación no construye tablas ni ejecuta SQL manualmente. Los nombres físicos de tablas/columnas son detalles de la persistencia y no deben confundirse con un contrato de API. Las relaciones y metadatos aparecen en el esquema del almacén generado.

Para localizar el directorio de una instalación propia, consultar `xcrun simctl get_app_container DEVICE_UDID edu.pe.tecsup.naomisanchez.compras data`. Después buscar el archivo del almacén bajo Library/Application Support. Consultar no requiere borrar ni reinstalar la aplicación.

Para inspeccionar sin cambiar la base activa, usar SQLite en modo solo lectura y generar un snapshot con `.backup` hacia un archivo temporal distinto. No copiar únicamente el archivo principal mientras hay escrituras: WAL/SHM pueden contener transacciones recientes. Ejemplo, sustituyendo rutas verificadas:

```sh
sqlite3 'file:/RUTA/Library/Application Support/Compras.store?mode=ro' ".backup '/private/tmp/compras-copia-lectura.sqlite'"
sqlite3 -readonly /private/tmp/compras-copia-lectura.sqlite '.tables'
sqlite3 -readonly /private/tmp/compras-copia-lectura.sqlite 'SELECT ZNOMBRE, ZUSUARIO, ZROL FROM ZUSUARIO;'
```

La última consulta omite ZCLAVE. Si el esquema físico cambia, revisar primero `.schema`; no adivinar columnas. La copia también contiene información privada y hashes: mantenerla local, no subirla al repositorio. La demostración de esta ejecución usa exclusivamente la base QA nueva, no la de la estudiante.

## E. Reglas de negocio y funciones responsables

Todas las operaciones mutantes citadas están en Compras/Business.swift y se conservaron durante el rediseño.

| Regla | Implementación |
|---|---|
| Subtotal, IGV y total | `amounts(cantidad:costo:)`: cantidad × costo; IGV subtotal ×0.18; total suma |
| Umbral | `needsApproval(total:)`: total >=5000 |
| Costo promedio | `projection`: promedio ponderado y validaciones de stock, overflow y valores finitos |
| Registrar | `registerPurchase`: exige Comprador, calcula importes y vencimiento, inserta Pendiente |
| Efecto automático | Si total <5000, registerPurchase llama `apply` antes de guardar |
| Aplicar inventario | `apply` privado escribe stock/costo, Aprobada y pagada según condición |
| Aprobar | `approve`: exige Supervisor, contexto válido y estado Pendiente; recalcula proyección actual y aplica una vez |
| Rechazar | `reject`: exige Supervisor y motivo no vacío; cambia estado/motivo sin aplicar inventario |
| Crédito | registerPurchase guarda alCredito y vence = fecha +30 días con Calendar |
| Deuda/vencimiento | `Compra.esDeuda` y `Compra.vencida(en:)`, en Models.swift |
| Pagar | `pay`: exige Supervisor, aprobada a crédito no pagada; solo cambia pagada |
| Indicadores | SummaryView.approved/pending/totals y reducciones de inventario, IGV y deuda; SupplierRow.total/hasDebt |

Caso pequeño: stock inicial40 a costo110; compra 10 a 120. Subtotal 1200, IGV 216, total 1416. Se aprueba automáticamente, stock 50 y promedio `(4400+1200)/50 =112`. Contado queda pagada; crédito queda por pagar y vence 30 días después de la fecha de registro.

Caso grande independiente: stock 40 a 110; compra 50 a 120 a crédito. Total 7080: queda Pendiente, con stock 40/costo110 y sin deuda. Cuando el supervisor aprueba, stock 90 y promedio `(4400+6000)/90 =115.555555…`, mostrado 115.56. El almacenamiento no se redondea para mostrar esa cifra. No se encadena este ejemplo al stock 50 del caso anterior.

Un total exactamente 5000 también queda Pendiente. Una rechazada no afecta stock, crédito fiscal ni deuda. Crédito fiscal suma IGV exclusivamente aprobado, incluso si la compra ya se pagó. La deuda exige aprobada, crédito y no pagada. Pagar no vuelve a llamar apply ni cambia inventario.

Las mutaciones son síncronas en MainActor y no tienen await entre comprobar estado y guardar. En el único contexto de la app esto serializa las acciones; la segunda aprobación encuentra Aprobada y falla. No es un mecanismo de transacciones distribuidas para varios dispositivos.

## F. Seguridad y permisos

La presentación restringe pestañas y acciones mediante Sesion.supervisor. ProductsView/SuppliersView no muestran alta/borrado al comprador; B7–B9 comprueban acceso; B6 muestra solo propias. Ocultar botones no es la única medida.

`ComprasService.require` valida que haya usuario, rol exacto y que el objeto de usuario pertenezca al contexto recibido. registerPurchase exige Comprador. product, supplier, delete, approve, reject y pay exigen Supervisor. approve/reject validan estado y pay valida esDeuda. Las pruebas de dominio invocan directamente funciones restringidas desde una sesión Comprador: deben lanzar error, aunque se omita la interfaz.

El supervisor puede consultar todo mediante el resumen; visiblePurchases también permite todo al supervisor y filtra las propias para comprador. Son reglas de la aplicación, no permisos SQL por fila ni cifrado de cada registro.

Limitaciones: el rol Supervisor se puede escoger al registrarse porque así lo exige el caso académico; no hay invitación ni autorización de servidor. Una persona con control del proceso o acceso de escritura al archivo podría manipular datos; PBKDF2 protege la representación de la clave, no cifra nombres ni impide alterar un rol en un entorno comprometido. No se implementaron bloqueo de intentos, sincronización remota o recuperación de contraseña. No se cambiaron estas decisiones por estética.

## G. Calidad del código y revisión

Fortalezas: nombres de entidades coinciden con la guía; servicios concentran reglas; consultas ordenadas y filtros están identificados; borradores evitan guardar al cancelar; errores de save revierten contexto; validaciones rechazan cantidades/costos inválidos y proyecciones no finitas; no hay dependencias externas. Recursos conservan el icono aprobado y el identificador original.

El rediseño mantiene controles nativos, SF Symbols, etiquetas de estado además de color y tamaños mínimos de acciones. Tipografía usa estilos semánticos; dashboard cambia a una columna con Dynamic Type de accesibilidad. Las tarjetas evitan alturas fijas para texto. Esto no sustituye una inspección completa con VoiceOver, texto máximo, orientación y todas las pantallas pequeñas.

Oportunidades no críticas que no se modifican en esta tarea:

- Hay reducciones repetidas para agregados en SummaryView y SupplierRow; podrían extraerse si el volumen crece. Para un laboratorio local el recorrido en memoria es razonable, pero no se midió con miles de registros.
- Las búsquedas de catálogo y parte de los filtros trabajan en memoria; paginación y más predicados serían mejoras posteriores de rendimiento.
- PBKDF2 se calcula sincrónicamente en el actor principal. Puede introducir una pausa breve en dispositivos lentos; moverlo requiere diseñar concurrencia y no es un ajuste visual.
- Double mantiene el modelo de la guía; una aplicación financiera de producción podría adoptar representación decimal y política explícita de redondeo. No se cambió el modelo ni las cifras ahora.
- Los tres delete prevalidan rol/relaciones, pero no repiten la comprobación de pertenencia al contexto que sí aparece en otras mutaciones. El flujo actual les pasa objetos del @Query del mismo contexto; si se agregan múltiples contextos habría que reforzar ese contrato.
- No hay pantalla de gestión de usuarios ni borrado de compras, conforme al alcance; la existencia de un método delete(Usuario) no implica que se haya añadido un flujo nuevo.

La prueba `test11PersistentReopen` reabre una URL temporal de SwiftData. La prueba UI `testPersistentRelaunchWithVerifiedNavigation` cierra y lanza el proceso en QA y vuelve a autenticar. Son comprobaciones diferentes. El verificador de 36 comprobaciones es un ejecutable Swift macOS, no XCTest; el nuevo target ComprasDomainTests sí ejecuta XCTest en iOS. No se deben sumar capturas o comprobaciones como si fueran casos independientes de XCTest.

No se detectó un defecto crítico que justificara cambiar reglas de negocio. Los ajustes de pruebas y localizadores se documentan aparte si el rediseño exige desplazamientos distintos. Los resultados efectivos y ejecuciones fallidas se registran en INFORME_REDISENO.md, sin confundir compilación con prueba aprobada.

## H. Preguntas para la sustentación

1. **¿Por qué SwiftData y no Core Data?** Yo usé SwiftData porque el Grupo B pide SwiftUI con cuatro modelos @Model. La actividad01 usa Core Data y permanece separada. Lo muestro en Models.swift.
2. **¿Qué hace @Model?** Yo declaro modelos persistentes observables. No guardo por escribir el inicializador: inserto y guardo mediante el contexto, como se ve en register.
3. **¿Dónde guardo usuarios?** Yo los guardo como Usuario en el almacén local de Store.container, dentro del contenedor de Compras; no en variables globales ni en un servidor.
4. **¿Cómo registro una cuenta?** RegisterView recoge los datos y llama ComprasService.register. Yo valido, protejo la clave, inserto, guardo y después inicio sesión.
5. **¿Qué hace ModelContext?** Yo lo uso como unidad de trabajo para consultar, insertar, modificar y borrar; save confirma y rollback revierte un guardado fallido.
6. **¿Qué es @Query?** Yo consulto y observo los modelos desde la vista. Cuando guardo cambios, la lista se actualiza sin reloadData; ProductsView lo demuestra.
7. **¿Cómo relaciono entidades?** Cada Compra puede referenciar comprador, producto y proveedor. Yo declaro las inversas de sus arreglos compras en Models.swift.
8. **¿Qué significa .deny?** Yo impido borrar un padre con compras. Además doy una alerta amigable en los delete del servicio antes de pedir el borrado.
9. **¿Cómo separo Comprador y Supervisor?** HomeView cambia las pestañas y ComprasService.require vuelve a comprobar el rol en las operaciones; no confío solo en esconder botones.
10. **¿Cómo calculo IGV?** Yo multiplico cantidad por costo para subtotal, luego subtotal por 0.18. amounts devuelve subtotal, IGV y total;10×120 da 1200+216=1416.
11. **¿Qué es el promedio ponderado?** Yo considero el valor del stock anterior y el de la compra. projection divide su suma entre las unidades finales;40×110 más10×120 da112 con 50 unidades.
12. **¿Por qué 5000 necesita aprobación?** Yo implemento el umbral inclusive de la guía en needsApproval. Desde 5000 registro Pendiente sin aplicar efectos todavía.
13. **¿Cuándo actualizo stock?** Yo llamo apply solo en aprobación automática o approve. Una Pendiente o Rechazada no aumenta inventario.
14. **¿Cómo evito aprobar dos veces?** Yo verifico que siga Pendiente y guardo sin suspender el actor principal. La siguiente llamada encuentra otro estado y se rechaza.
15. **¿Cómo funcionan cuentas por pagar?** Yo uso esDeuda: aprobada, crédito y no pagada. pay marca pagada; no vuelve a aplicar stock.
16. **¿Qué ocurre al cerrar y abrir?** Yo recupero cuentas y compras del almacén persistente, pero la sesión en memoria desaparece. El login vuelve a verificar la clave.
17. **¿Guardo contraseñas en texto plano?** No. Yo guardo un derivado PBKDF2 con sal aleatoria en el campo String clave. Password.hash y verify muestran el procedimiento.
18. **¿La sal es otra contraseña?** No. Yo genero 16 bytes aleatorios por cuenta y los guardo junto al derivado para poder repetir la verificación; la sal no debe mantenerse secreta.
19. **¿Cómo pruebo sin contaminar datos?** Yo uso memoria para dominio/recorrido y un simulador QA nuevo para relanzamiento real. No borro la base de la estudiante.
20. **¿Dónde se calcula el dashboard?** Yo filtro aprobadas y pendientes en SummaryView y sumo inventario, IGV y deuda con sus condiciones; no invento resultados para el gráfico.
21. **¿Qué significa Cancelar en una edición?** Yo cierro el formulario sin copiar el borrador al modelo. Solo Guardar llama al servicio y confirma cambios.
22. **¿Por qué no hago merge completo?** Yo transfiero solo Semana11 porque las ramas tienen historias de otras semanas. El commit de manual reconoce la procedencia asistida y no la presenta como trabajo manual.
