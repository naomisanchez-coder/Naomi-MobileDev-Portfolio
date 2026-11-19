# Laboratorio 07 · Manejo de datos, tablas y colecciones

El objetivo es presentar datos en tablas de UIKit, reutilizar celdas y responder a la selección de una fila. Los tres proyectos son independientes y usan Swift, UITableView, Main.storyboard y Auto Layout. Requieren iOS 17 o posterior.

## Proyectos

Abre el archivo indicado en Xcode, selecciona su esquema, elige un simulador iOS y ejecuta con **⌘R**.

| Actividad | Proyecto y esquema | Qué puedes probar |
| --- | --- | --- |
| A · Profesores de Tecsup | [Semana07_A.xcodeproj](Lab07-Profesores/Semana07_A.xcodeproj), `Semana07_A` | Siete nombres, cargos y avatares en una celda Subtitle con identificador `celda`. Desplaza la tabla para comprobar que se mantienen las asignaciones. |
| B · Personas | [Semana07_B.xcodeproj](Lab07-Personas/Semana07_B.xcodeproj), `Semana07_B` | Cinco nombres con avatares en `PersonasTableViewCell` (`miCell`). Toca una fila y cierra la alerta con **OK**. |
| Caso final · Culturas peruanas | [CulturasPeruanas.xcodeproj](Lab07-CulturasPeruanas/CulturasPeruanas.xcodeproj), `CulturasPeruanas` | Abre Chavín, Nasca o Chimú para consultar su región, descripción y fotografía. Vuelve con la barra de navegación. |

En cada proyecto, abre `Main.storyboard` en Xcode para editar celdas, restricciones y conexiones. Los datos están en archivos Swift independientes de los controladores. El caso final pasa una instancia de `Cultura` mediante un segue **Show** y usa sus recursos locales sin conexión.

## Fuentes

Los nombres, cargos y asignaciones de avatares de A y B provienen de la guía del Lab07 de Tecsup, pasos 10–19 de la actividad A y 5–12 de «Personalizar un TableView». Los avatares geométricos son recursos locales provisionales elaborados para este laboratorio. Queda pendiente sustituirlos si se proporcionan los archivos originales o retratos autorizados.

Las descripciones del caso final se redactaron a partir de las fichas patrimoniales de UNESCO. Las fotografías se distribuyen bajo las licencias indicadas y se ajustaron de tamaño para el catálogo. Los créditos también se aplican a las fotografías visibles en las capturas del simulador.

| Cultura | Fuente de texto | Fotografía y licencia |
| --- | --- | --- |
| Chavín | [UNESCO · Chavín](https://whc.unesco.org/en/list/330/) | [Chavín de Huantar.jpg, Mimcollipal](https://commons.wikimedia.org/wiki/File:Chav%C3%ADn_de_Huantar.jpg), [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) |
| Nasca | [UNESCO · Líneas y geoglifos de Nasca y Palpa](https://whc.unesco.org/en/list/700/) | [Nazca Lines Hummingbird.jpg, Unukorno](https://commons.wikimedia.org/wiki/File:Nazca_Lines_Hummingbird.jpg), [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/) |
| Chimú | [UNESCO · Zona arqueológica de Chan Chan](https://whc.unesco.org/en/list/366/) | [Chan Chan fish carvings.jpg, Bruno Girin](https://commons.wikimedia.org/wiki/File:Chan_Chan_fish_carvings.jpg), [CC BY-SA 2.0](https://creativecommons.org/licenses/by-sa/2.0/) |

## Verificación y evidencias

Los tres proyectos compilaron en Xcode 26.6 para iPhone 17e con iOS 26.5. Se inspeccionaron con `ibtool` la jerarquía y las conexiones de los tres Storyboards. Las cinco pruebas de interacción con XCUITest se ejecutaron desde copias temporales de los proyectos y pasaron. Las capturas se tomaron durante esas pruebas.

| Actividad | Interacción comprobada | Capturas y código |
| --- | --- | --- |
| Profesores | Primero se ejecutó la versión de texto. Con avatares, se verificaron las siete filas y el desplazamiento de ida y vuelta en horizontal. | [Tabla](Evidencias/Profesores.png) · [Fuente de datos](Lab07-Profesores/Semana07_A/Profesores.swift) · [Controlador](Lab07-Profesores/Semana07_A/ViewController.swift) |
| Personas | Se comprobaron cinco filas con sus avatares y se desplazó la tabla en horizontal. Las filas de Juan León y Elliot Garamendi abrieron alertas con el nombre esperado y ambas se cerraron con **OK**. | [Tabla](Evidencias/Personas-tabla.png) · [Alerta](Evidencias/Personas-alerta.png) · [Celda](Lab07-Personas/Semana07_B/PersonasTableViewCell.swift) · [Selección](Lab07-Personas/Semana07_B/ViewController.swift) |
| Culturas peruanas | Se comprobaron los nombres, regiones, descripciones y fotografías de las tres culturas. Se volvió a la lista desde cada detalle. | [Lista](Evidencias/Culturas-lista.png) · [Detalle Chavín](Evidencias/Culturas-chavin.png) · [Detalle Nasca](Evidencias/Culturas-nasca.png) · [Navegación](Lab07-CulturasPeruanas/CulturasPeruanas/ViewController.swift) · [Detalle](Lab07-CulturasPeruanas/CulturasPeruanas/DetalleCulturaViewController.swift) |

## Conclusiones

1. Una celda Subtitle permite combinar el nombre y el cargo con la configuración estándar de UITableView.
2. Una celda personalizada conserva la correspondencia entre el modelo y la fila cuando el controlador asigna sus dos outlets en cada reutilización.
3. Pasar una instancia de `Cultura` desde la lista mantiene sincronizados el nombre, la región, la descripción y la imagen del detalle.
