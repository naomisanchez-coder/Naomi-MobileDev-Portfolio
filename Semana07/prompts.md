# Registro de asistencia con Codex

## Encargo recibido

La usuaria solicitó desarrollar y verificar las tres actividades del Laboratorio 07 de Programación en Móviles Avanzado de Tecsup en el orden de la guía. Indicó reutilizar Semana07, usar UIKit y Storyboards editables en tres proyectos, comprobarlos en el simulador, dejar evidencias reales, documentar fuentes y conclusiones, y registrar ocho checkpoints progresivos. Autorizó la publicación únicamente en `origin/main` y pidió preservar los demás trabajos.

## Guía y decisiones de implementación

- Se revisaron las 16 páginas, incluido el código y las conexiones que aparecen en capturas. En Profesores se conservaron la clase `Profesor`, los nombres y cargos, las asignaciones `avatar1` a `avatar5` y la celda Subtitle `celda`. En Personas se conservaron `miCell`, `PersonasTableViewCell`, `PersonaImagen`, `personaNombre`, los dos arreglos de la guía y la alerta con **OK**.
- Se comprobó la configuración de las celdas y los outlets. La lógica guiada compila con Xcode 26.6. Se usó la variante de dequeue con `IndexPath` y se evitaron desenvolturas forzadas de imágenes y de la conversión de celda. Se normalizaron espacios sueltos del texto de ejemplo, manteniendo nombres, encabezado de alerta y orden. Se eliminó de la plantilla la referencia a un conjunto `AppIcon` ausente porque bloqueó la compilación tras añadir Assets.
- El PDF muestra los avatares en capturas. Los recursos independientes correspondientes no estaban adjuntos, por lo que se elaboraron cinco avatares genéricos provisionales, con los nombres de Assets y la correspondencia de la guía.
- Para el caso final se eligieron Chavín, Nasca y Chimú y se consultaron fichas de UNESCO y fotografías de Wikimedia Commons. La guía deja abierta la transmisión del dato. Se usó el flujo solicitado con `UINavigationController`, un segue Show y `prepare(for:sender:)`. El segue sale del controlador de lista y la selección es su único punto de activación.
- Se ejecutaron pruebas de compilación e interacción en el iPhone 17e disponible. Los resultados y capturas se registraron en el README. Los logs, productos de compilación y proyectos temporales de pruebas quedaron fuera del repositorio.
