# Documentación del Proyecto Rymel

**Cliente:** Rymel
**Versión del paquete documental:** 1.0.0
**Autor:** Alex Pinaida
**Fecha de emisión:** 2026-05-06
**Estado:** Entregable formal — Avance de documentación funcional y técnica

---

## 1. Propósito

Este paquete documental presenta el avance consolidado de la documentación funcional y técnica de la **Plataforma Rymel**, una solución web para la gestión de normas eléctricas, diseño de configuraciones eléctricas, cálculo de costos y administración de catálogos de elementos por país. Su objetivo es:

- Establecer una línea base **formal** de los requerimientos del sistema.
- Documentar los **módulos principales** que componen la solución.
- Describir la **estructura general de la aplicación web** (frontend, backend, microservicios).
- Definir la **organización de procesos** y el plan de fases para el desarrollo subsiguiente.

## 2. Alcance del paquete

El paquete cubre los cuatro componentes que integran la plataforma:

| # | Componente | Tipo | Rol funcional |
|---|------------|------|---------------|
| 1 | `project-back` | API REST (NestJS) | Núcleo de negocio, persistencia y orquestación |
| 2 | `project-front` | SPA Web (React) | Aplicación de ingeniería de normas y diseños |
| 3 | `project-admin` | SPA Web (React) | Consola administrativa de usuarios y roles |
| 4 | `secure-function-engine-api` | Microservicio (NestJS) | Cifrado y evaluación segura de fórmulas de diseño |

## 3. Estructura del paquete documental

| Documento | Archivo | Contenido |
|-----------|---------|-----------|
| **DOC-01** Especificación de Requerimientos del Software (SRS) | [`01_Especificacion_Requerimientos_SRS.md`](./01_Especificacion_Requerimientos_SRS.md) | Requerimientos funcionales y no funcionales, alcance, roles, casos de uso y reglas de negocio. |
| **DOC-02** Documento de Arquitectura Técnica | [`02_Arquitectura_Tecnica.md`](./02_Arquitectura_Tecnica.md) | Stack tecnológico, diagrama de componentes, modelo de datos, integraciones y seguridad. |
| **DOC-03** Especificación Funcional y Módulos del Sistema | [`03_Especificacion_Funcional_Modulos.md`](./03_Especificacion_Funcional_Modulos.md) | Descripción detallada de cada módulo del sistema y sus interfaces. |
| **DOC-04** Estructura de la Aplicación Web y Plan de Fases | [`04_Estructura_Web_y_Plan_Fases.md`](./04_Estructura_Web_y_Plan_Fases.md) | Mapa de navegación, pantallas, flujos de usuario y roadmap de procesos. |

## 4. Convenciones

- Todos los diagramas se han elaborado en **Mermaid**, renderizables en GitHub, GitLab, VS Code, Notion y la mayoría de visores Markdown modernos.
- Los identificadores de requerimientos siguen la convención `RF-NNN` (Requerimiento Funcional) y `RNF-NNN` (Requerimiento No Funcional).
- Los identificadores de casos de uso siguen la convención `CU-NNN`.
- Las referencias cruzadas entre documentos se indican como `DOC-XX §N.N`.

## 5. Política de versionado

El paquete documental adopta **versionado semántico** (`MAJOR.MINOR.PATCH`):

| Tipo | Cuándo se incrementa | Ejemplo |
|------|----------------------|---------|
| **MAJOR** (`X.0.0`) | Cambios estructurales, restructuraciones que rompen la trazabilidad anterior, cambios de alcance del proyecto. | `1.x.x` → `2.0.0` |
| **MINOR** (`x.Y.0`) | Adiciones funcionales: nuevos requerimientos, casos de uso, módulos, fases o secciones. | `1.0.x` → `1.1.0` |
| **PATCH** (`x.y.Z`) | Correcciones tipográficas, aclaraciones, ajustes menores que no alteran el contenido sustantivo. | `1.0.0` → `1.0.1` |

Cada incremento debe registrarse en la tabla de control (§6) y en la tabla de control específica de cada documento que cambie.

## 6. Control de versiones del paquete

| Versión | Fecha | Autor | Descripción |
|---------|-------|-------|-------------|
| 1.0.0 | 2026-05-06 | Alex Pinaida | Línea base inicial del paquete documental — avance de documentación funcional y técnica para presentación al cliente Rymel. Incluye SRS, arquitectura técnica, especificación funcional/módulos y estructura web/plan de fases. |

> Las versiones cerradas se archivan como snapshots inmutables en [`releases/`](./releases/). Para crear un nuevo snapshot, usa `./releases/snapshot.sh <versión>` (consulta [`releases/README.md`](./releases/README.md) para detalles).

## 7. Glosario rápido

| Término | Definición |
|---------|------------|
| **Norma** | Especificación normativa eléctrica asociada a un país, que regula los elementos permitidos y sus parámetros. |
| **Elemento** | Componente físico catalogado (con referencia SAP) usado en diseños eléctricos. |
| **Diseño** | Configuración técnica que combina elementos bajo una norma, con fórmulas de cálculo asociadas. |
| **Función de Diseño** | Expresión matemática cifrada que calcula valores derivados (cantidades, dimensiones, costos). |
| **SAP Reference** | Identificador del elemento en el sistema SAP del cliente. |
| **Function Engine** | Microservicio dedicado al cifrado y evaluación de fórmulas. |
