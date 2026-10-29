# Semana 08 — CTSInstructores

Aplicación iOS con SwiftUI para cálculo de CTS y remuneraciones de instructores.

## Descripción del proyecto

CTSInstructores es una aplicación académica de la actividad calificada de **Programación en Móviles Avanzado de Tecsup**. Permite estimar CTS y calcular remuneraciones de instructores, descuentos previsionales y quinta categoría bajo supuestos explícitos del ejercicio y referencias laborales peruanas.

Cuenta con cuatro pantallas: Inicio, Calculadora CTS, Pago de instructores e Información laboral. Los formularios no guardan datos permanentemente ni intercambian información entre calculadoras.

## Objetivo general

Aplicar conceptos de Swift y SwiftUI para desarrollar una calculadora educativa de beneficios laborales, con captura de datos, validaciones y resultados explicados.

## Objetivos específicos

- Diseñar interfaces con tarjetas, jerarquía visual y componentes nativos de SwiftUI.
- Implementar navegación entre el inicio y las tres secciones mediante `NavigationStack` y `NavigationLink`.
- Capturar y validar nombres, importes, períodos y jornadas antes de calcular.
- Implementar funciones matemáticas para sueldo bruto, aportes previsionales y simulación tributaria.
- Estimar CTS según remuneración y tiempo computables, verificando la jornada mínima del supuesto implementado.
- Presentar resultados en soles, con dos decimales y desglose matemático.
- Organizar el código por pantallas y registrar avances mediante commits progresivos.

## Tecnologías y configuración

| Herramienta | Uso real |
|---|---|
| Swift | Vistas, estructuras, validaciones y funciones de cálculo; modo de lenguaje configurado en Swift 5 |
| SwiftUI | Interfaz declarativa, estado temporal, formularios y navegación |
| Xcode | Edición y compilación del proyecto iOS; durante el desarrollo se utilizó Xcode 26.6 |
| Simulador iOS | Destino de compilación y revisión del proyecto: iPhone 17 Pro |
| Git | Historial y commits progresivos en la rama `main` |
| GitHub | Publicación del repositorio y consulta del código |

El proyecto configura **iOS 17.0 como versión mínima**, admite iPhone y iPad y no incluye paquetes externos. La revisión se centra en iPhone; la configuración para iPad no equivale a una validación visual completa en ese dispositivo.

### Abrir y ejecutar

1. Abrir [CTSInstructores.xcodeproj](CTSInstructores/CTSInstructores.xcodeproj) con Xcode.
2. Seleccionar el esquema `CTSInstructores` y un simulador disponible, como iPhone 17 Pro.
3. Ejecutar con **Product → Run**.

Para ejecutar en un iPhone físico se debe configurar la firma con una cuenta y equipo de desarrollo válidos. No se requiere una base de datos, API ni autenticación para los cálculos.

## Requerimientos funcionales

| Código | Comportamiento implementado |
|---|---|
| RF01 | Visualizar Inicio con tarjeta CTS, acceso a instructores e información laboral. |
| RF02 | Abrir Calculadora CTS y regresar mediante navegación nativa. |
| RF03 | Ingresar nombre, remuneración y gratificación computables, meses, días y jornada para CTS. |
| RF04 | Validar nombre, importes finitos, meses de 0 a 6, días de 0 a 29, período positivo de hasta seis meses y jornada distribuida en 5 o 6 días. |
| RF05 | Estimar CTS y mostrar su desglose si se cumplen las condiciones evaluadas; informar sin monto cuando no se cumple la jornada mínima o el período es inferior a un mes completo. |
| RF06 | Ingresar nombre obligatorio y horas semanales decimales del instructor. |
| RF07 | Calcular sueldo bruto con horas mayores que cero y hasta 23, tarifa de S/ 50 y cuatro semanas por mes. |
| RF08 | Elegir ONP o AFP; con AFP, elegir administradora y tipo de comisión. |
| RF09 | Calcular ONP o aporte AFP, seguro y comisión mensual aplicable. |
| RF10 | Mostrar EsSalud del empleador por separado, sin descontarlo al trabajador. |
| RF11 | Proyectar ingresos, renta imponible, impuesto anual y retención referencial enero–marzo de 2026; permitir incluir o excluir gratificaciones del supuesto. |
| RF12 | Mostrar remuneración neta referencial después de previsión y retención simulada. |
| RF13 | Consultar explicaciones de CTS, gratificaciones, vacaciones, pago y aportes, con enlaces oficiales. |
| RF14 | Limpiar los formularios y ocultar resultados cuando cambian sus datos, incluidas las selecciones previsionales y el supuesto de gratificaciones. |

En ambos formularios se aceptan decimales con punto o coma, sin separadores de miles. Las entradas vacías o inválidas, los valores negativos no permitidos, `NaN` e infinitos se rechazan. Los nombres admiten espacios y tildes y no pueden contener únicamente espacios.

## Requerimientos no funcionales

| Aspecto | Implementación y alcance |
|---|---|
| Facilidad de uso | Etiquetas en español, botones de cálculo y limpieza, mensajes explicativos y regreso nativo. |
| Adaptabilidad | `ScrollView`, anchos flexibles y contenido centrado con límites de ancho; orientación principal de uso en iPhone. |
| Legibilidad | Tipografía del sistema, tarjetas blancas, fondo claro y colores azul, turquesa y violeta. Se realizaron comprobaciones manuales de las principales pantallas en el simulador, sin cobertura exhaustiva de dispositivos o versiones. |
| Validación | Conversión segura de texto y comprobaciones antes de mostrar importes. |
| Organización | Cinco archivos Swift, funciones sencillas y estructuras de datos dentro de las vistas correspondientes. |
| Compatibilidad | Destino mínimo iOS 17.0 según `project.pbxproj`; no se afirma haber probado todas las versiones compatibles. |
| Dependencias | Sin paquetes externos, persistencia, servicios remotos ni gestores complejos de estado. Los enlaces abren fuentes externas. |

No se establecen métricas de rendimiento o garantías de seguridad que no hayan sido medidas.

## Fórmulas implementadas

### Sueldo bruto y previsión

```text
Horas mensuales estimadas = Horas semanales × 4
Sueldo bruto = Horas semanales × S/ 50 × 4
ONP = Sueldo bruto × 0.13

Aporte AFP = Sueldo bruto × 0.10
Prima de seguro AFP = Sueldo bruto × 0.0137
Comisión por flujo = Sueldo bruto × Tasa de la administradora
Descuento AFP = Aporte AFP + Prima de seguro + Comisión aplicable

EsSalud = Sueldo bruto × 0.09
Remuneración después de aportes = Sueldo bruto − Descuento previsional
```

Las tasas AFP están fijadas a **octubre de 2026**, sin actualización automática:

| Administradora | Comisión sobre flujo |
|---|---:|
| Habitat | 1.47 % |
| Integra | 1.55 % |
| Prima | 1.60 % |
| Profuturo | 1.69 % |

Con comisión sobre saldo, la comisión mensual sobre remuneración considerada es **S/ 0.00**. Se mantienen el aporte y el seguro; la comisión anual sobre el fondo no se estima. No se aplica un 13 % universal para AFP.

EsSalud es un aporte informativo del empleador: **no se resta al instructor**. La tarifa de S/ 50, el límite de 23 horas y las cuatro semanas son parámetros académicos del docente, no reglas universales de contratación.

### Quinta categoría: escenario académico 2026

Supuestos: trabajo dependiente sujeto a quinta categoría, sueldo constante durante doce meses, un empleador, sin otros ingresos, retenciones anteriores ni cambios salariales. Se simula el escenario ordinario de enero a marzo, sin retención extraordinaria adicional del mes.

El interruptor **Incluir gratificaciones anuales** comienza activado. Su selección no acredita el derecho legal a gratificaciones. Los detalles se consultan en **Ver supuestos del cálculo**, cerrado inicialmente.

```text
Con gratificaciones:
Ingresos anuales = Sueldo × 12 + Sueldo × 2 + Sueldo × 2 × 0.09

Sin gratificaciones:
Ingresos anuales = Sueldo × 12

UIT 2026 = S/ 5,500.00
Deducción = 7 UIT = S/ 38,500.00
Renta imponible = máximo(0, Ingresos anuales − Deducción)
```

| Porción de renta imponible anual | Tasa |
|---|---:|
| Primeras 5 UIT | 8 % |
| Exceso de 5 hasta 20 UIT | 14 % |
| Exceso de 20 hasta 35 UIT | 17 % |
| Exceso de 35 hasta 45 UIT | 20 % |
| Exceso de 45 UIT | 30 % |

Cada tasa grava únicamente su tramo; no se aplica una sola tasa a toda la renta. Si los ingresos no superan la deducción, la renta imponible y el impuesto son cero.

```text
Retención mensual referencial enero–marzo = Impuesto anual proyectado / 12
Neto referencial = Sueldo bruto − Descuento previsional − Retención referencial
```

La división entre doce **no es una fórmula universal para cualquier mes**. La bonificación extraordinaria del 9 % de cada gratificación forma parte del supuesto de ingresos anuales; no es el aporte mensual de EsSalud. No se incluyen CTS ni EPS en esta simulación.

### CTS

```text
Sexta parte de la gratificación = Gratificación computable / 6
Remuneración computable total = Remuneración ingresada + Gratificación computable / 6
CTS estimada = Remuneración computable total × (Meses / 12 + Días / 360)
Promedio diario = Horas semanales / Días semanales
```

La calculadora se limita al supuesto del régimen general privado con remuneración fija y semanas de **5 o 6 días**. Verifica un promedio de al menos **4 horas diarias** y un período computable de al menos un mes completo antes de mostrar un monto.

- El período debe ser positivo y no superar seis meses: con 6 meses, los días adicionales deben ser 0.
- Para menos de un mes completo informa sobre acumulación al período siguiente, sin presentar depósito inmediato.
- La gratificación debe ingresarse expresamente y admite cero; no se presume igual al sueldo ni incluye la bonificación extraordinaria.
- El límite de 23 horas de instructores no se aplica a esta calculadora. Por ejemplo, 20 horas en 5 días cumplen el promedio; 20 en 6 días no.
- Se rechazan jornadas cuyo promedio supere 24 horas diarias e importes que produzcan resultados no finitos.

Los cálculos conservan precisión interna con `Double`; los importes se presentan en soles con dos decimales.

### Fórmulas educativas sin calculadora independiente

Información laboral muestra, como explicación estática:

```text
Gratificación proporcional = Remuneración computable × Meses completos / 6
Bonificación extraordinaria = Gratificación × Tasa aplicable
Provisión mensual aproximada de vacaciones = Remuneración mensual / 12
```

La tarjeta distingue bonificación del 9 % con EsSalud y 6.75 % con EPS, pero la aplicación **no calcula EPS ni vacaciones**. La provisión contable no equivale a una liquidación legal completa.

## Estructura de archivos

Árbol resumido de los archivos del proyecto; se omiten archivos personales y temporales de Xcode:

```text
Semana08/
├── README.md
├── CTSInstructores/
│   ├── CTSInstructores.xcodeproj/
│   │   └── project.pbxproj
│   └── CTSInstructores/
│       ├── CTSInstructoresApp.swift
│       ├── ContentView.swift
│       ├── CTSView.swift
│       ├── InstructoresView.swift
│       └── InformacionLaboralView.swift
└── demostracion/
    ├── demostracion.xcodeproj/
    └── demostracion/
```

| Archivo | Responsabilidad |
|---|---|
| [CTSInstructoresApp.swift](CTSInstructores/CTSInstructores/CTSInstructoresApp.swift) | Punto de entrada `@main`; abre `ContentView`. |
| [ContentView.swift](CTSInstructores/CTSInstructores/ContentView.swift) | Inicio, navegación, colores compartidos y tarjetas de acceso. |
| [CTSView.swift](CTSInstructores/CTSInstructores/CTSView.swift) | Formulario CTS, estructuras `DatosCTS` y `ResultadoCTS`, validaciones y funciones de estimación. |
| [InstructoresView.swift](CTSInstructores/CTSInstructores/InstructoresView.swift) | Formulario de instructores, previsión y proyección tributaria; funciones `CalculoInstructor` y `CalculoQuinta`. |
| [InformacionLaboralView.swift](CTSInstructores/CTSInstructores/InformacionLaboralView.swift) | Tarjetas educativas y enlaces oficiales. |
| [project.pbxproj](CTSInstructores/CTSInstructores.xcodeproj/project.pbxproj) | Referencias a fuentes y configuración de compilación. |

`demostracion/` es un proyecto previo e independiente. No forma parte de las calculadoras documentadas ni fue reutilizado como aplicación final.

## Interfaces de la aplicación

Las capturas reales del proyecto están incluidas en el informe académico **LAB08-MÓVILESS**.

### 1. Pantalla principal

Presenta CTS Instructores, la tarjeta **Comenzar cálculo** y accesos a Pago de instructores e Información laboral. Centraliza la navegación sin registro ni inicio de sesión.

### 2. Calculadora CTS

Solicita datos del trabajador, importes computables, período y jornada. Tras validar, presenta CTS estimada, sexto de gratificación, remuneración total y fórmula desarrollada. Los mensajes de elegibilidad aparecen cuando corresponden. Permite limpiar datos y regresar al inicio.

### 3. Pago de instructores

Solicita nombre y horas, permite seleccionar ONP o AFP y configurar el supuesto de gratificaciones. Presenta bruto, previsión, EsSalud del empleador, proyección anual, impuesto, retención y neto referenciales. Cambiar los datos oculta el resultado anterior; limpiar restablece ONP, Habitat, comisión por flujo y gratificaciones activadas.

### 4. Información laboral

Ofrece cinco tarjetas: CTS, Gratificaciones, Vacaciones, Pago de instructores y Descuentos y aportes. Explica conceptos y fórmulas y permite abrir las fuentes oficiales. No contiene nuevos formularios de cálculo.

## Ejemplos de funcionamiento y verificación

| Escenario | Resultado de referencia |
|---|---|
| Instructor: nombre válido y 20 horas semanales | Bruto: S/ 4,000.00 |
| Mismo bruto con ONP | Descuento: S/ 520.00; después de previsión: S/ 3,480.00 |
| Mismo bruto con AFP Habitat sobre flujo | Aporte: S/ 400.00; seguro: S/ 54.80; comisión: S/ 58.80; descuento total: S/ 513.60 |
| EsSalud para bruto S/ 4,000.00 | S/ 360.00 a cargo del empleador, sin descuento al instructor |
| CTS: nombre válido, sueldo S/ 2,400.00, gratificación S/ 2,400.00, 6 meses, 0 días, 20 horas en 5 días | Computable: S/ 2,800.00; CTS estimada: S/ 1,400.00 bajo el supuesto de elegibilidad |
| Mismos datos CTS con 2 meses y 15 días | CTS estimada: S/ 583.33 |
| Quinta categoría: bruto S/ 4,000.00 y gratificaciones activadas | Ingresos: S/ 56,720.00; renta: S/ 18,220.00; impuesto anual: S/ 1,457.60; retención referencial: S/ 121.47 |
| Mismo escenario tributario con ONP | Neto referencial: S/ 3,358.53 |

Estos valores corresponden a pruebas de funciones realizadas durante el desarrollo, no a certificaciones de una liquidación real. Se registraron compilaciones `BUILD SUCCEEDED` para iPhone 17 Pro. También se comprobaron entradas inválidas, tramos tributarios, invalidación y limpieza mediante funciones y revisión de código.

Durante la revisión del proyecto se realizaron comprobaciones manuales de las principales pantallas en el simulador. Codex ejecutó verificaciones matemáticas y compilaciones; estas comprobaciones se distinguen de las interacciones manuales. No se implementó una suite de pruebas XCTest y los scripts temporales no forman parte del proyecto versionado. No se afirma haber probado exhaustivamente todos los dispositivos, versiones de iOS ni escenarios laborales.

## Desarrollo progresivo con Git

Los nueve commits de CTSInstructores publicados antes de esta documentación son:

| Commit | Avance |
|---|---|
| `956b901` | Estructura inicial de CTSInstructores |
| `87e6bfa` | Pantalla principal y navegación |
| `d785406` | Formulario y sueldo bruto |
| `8759276` | Descuentos ONP y AFP |
| `3a21754` | Quinta categoría y neto referencial |
| `597c723` | Calculadora principal de CTS |
| `1341d9d` | Información laboral |
| `f23688e` | Mejoras de interfaz y mensajes CTS |
| `e0f5e98` | Simplificación de textos y beneficios |

## Alcance y limitaciones

- Proyecto con fines académicos basado en la actividad del docente; no reemplaza una liquidación laboral o tributaria profesional.
- S/ 50 por hora, 23 horas máximas y cuatro semanas por mes son parámetros del módulo de instructores.
- UIT y supuestos tributarios corresponden a 2026; las tasas AFP están fijadas a octubre de 2026. Las tasas pueden cambiar y no se actualizan automáticamente.
- Quinta categoría es una simulación referencial del escenario ordinario enero–marzo, sin ajuste por otros empleadores, variaciones salariales, retenciones previas ni retención extraordinaria adicional.
- CTS supone régimen general privado, jornada de 5 o 6 días y tiempo computable declarado. No analiza fechas de ingreso, ausencias ni regímenes especiales automáticamente.
- La remuneración computable se ingresa manualmente. No se calcula automáticamente asignación familiar, horas extras regulares ni otros conceptos; si corresponden, deben incorporarse al importe declarado.
- La opción de gratificaciones en la proyección anual no determina automáticamente su elegibilidad legal.
- Vacaciones y gratificaciones proporcionales se explican, pero no existen calculadoras independientes de estos beneficios. No hay cálculo de EPS.
- No hay persistencia, exportación de boletas PDF, autenticación, integración con Excel ni consulta automática de servicios externos. Los datos de cada formulario son temporales.

## Relación con Excel

[Consultar Excel — Sistema de Planilla de Instructores](https://docs.google.com/spreadsheets/d/1d_YLTi_oei1yhu2LNx_wPTRQCVRxjdhl/edit?gid=539062629#gid=539062629)

El Excel complementa la aplicación SwiftUI mediante fórmulas de remuneración, descuentos previsionales, quinta categoría, CTS y beneficios laborales. Ambos entregables permiten comparar procedimientos y resultados bajo los mismos supuestos académicos.

No existe una conexión automática entre Excel y la aplicación: la comparación se realiza utilizando los mismos datos de entrada.

## Conclusiones

1. Aprendí a construir interfaces en SwiftUI utilizando vistas, estado temporal y navegación nativa.
2. Implementé fórmulas matemáticas separando los parámetros académicos de los supuestos laborales y tributarios.
3. Comprendí la importancia de validar los datos y ocultar resultados desactualizados antes de presentar importes.
4. Reconocí la finalidad protectora de la CTS y la necesidad de evaluar jornada, tiempo y remuneración computables.
5. Utilicé Git y commits progresivos para mantener avances identificables y facilitar su revisión.

## Fuentes oficiales

Referencias presentes en la aplicación y utilizadas durante su desarrollo. Los parámetros documentados reflejan el código; los enlaces no realizan actualizaciones automáticas ni garantizan que una tasa continúe vigente en otro período.

- [MTPE — Derecho a CTS](https://www.gob.pe/institucion/mtpe/noticias/1383535-mtpe-trabajadores-del-regimen-privado-que-laboren-4-horas-diarias-en-promedio-tienen-derecho-a-cts).
- [SUNAFIL — Gratificaciones](https://www.gob.pe/institucion/sunafil/noticias/1413450-mas-de-9-000-denuncias-recibio-la-sunafil-por-falta-de-pago-de-la-gratificacion).
- [SUNAFIL — Derecho a vacaciones](https://www.gob.pe/institucion/sunafil/noticias/889227-pensando-en-salir-de-vacaciones-sunafil-te-explica-como-acceder-a-este-derecho).
- [SUNAFIL — Beneficios al cese](https://www.gob.pe/institucion/sunafil/noticias/661238-liquidacion-de-beneficios-6-datos-que-debes-saber-si-renunciaste-o-te-cesaron-del-trabajo).
- [ONP — Aportes al Sistema Nacional de Pensiones](https://www.gob.pe/institucion/onp/noticias/1190488-como-saber-si-tu-empleador-esta-pagando-tus-aportes-al-snp).
- [SUNAT — EsSalud y ONP](https://ww1.sunat.gob.pe/ol-ti-itmoddatruc/TIENEEMP.html).
- [SUNAT — Retención de quinta categoría](https://personas.sunat.gob.pe/trabajador-dependiente/como-me-deben-hacer-retencion-impuesto).
- [SBS — Comisiones y primas AFP](https://www.sbs.gob.pe/app/spp/empleadores/comisiones_spp/Paginas/comision_prima.aspx).
