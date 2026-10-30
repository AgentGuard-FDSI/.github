# Documentación de AgentGuard

Índice de la documentación de la organización. Cada repositorio tiene además su propio `README.md` y,
cuando hace falta, una carpeta `docs/`.

## Para empezar

| Documento | Para qué sirve |
|---|---|
| [Guía de inicio rápido](guia-de-inicio-rapido.md) | Levantar la demostración completa (núcleo, API y interfaz) en Windows. |
| [Estado del proyecto](estado-del-proyecto.md) | Qué está integrado en la demo, qué está solo en el núcleo y qué es planeado. |
| [Glosario](glosario.md) | Términos del proyecto: ALLOW/BLOCK/HITL, Config. A/B, mínimo privilegio, etc. |

## Arquitectura

| Documento | Para qué sirve |
|---|---|
| [Arquitectura C4](arquitectura/AgentGuard_Arquitectura_C4.md) | Contexto, contenedores y componentes, con diagramas y su código fuente. |
| [Arquitectura del núcleo](https://github.com/AgentGuard-FDSI/agentguard-core/blob/main/docs/arquitectura.md) | Orden de evaluación de `authorize()` y cómo integrar cada pieza. |

## Cómo trabajamos

| Documento | Para qué sirve |
|---|---|
| [Guía de contribución](../CONTRIBUTING.md) | Ramas, pull requests, revisión y reglas del equipo. |
| [Política de seguridad](../SECURITY.md) | Alcance del prototipo y cómo reportar un problema. |

## Documentación por repositorio

| Repositorio | Documentos |
|---|---|
| [`agentguard-core`](https://github.com/AgentGuard-FDSI/agentguard-core) | `README.md`, `docs/arquitectura.md`, `docs/guia-de-politicas.md` |
| [`agentguard-andimarket`](https://github.com/AgentGuard-FDSI/agentguard-andimarket) | `README.md`, `docs/api.md` |
| [`agentguard-frontend`](https://github.com/AgentGuard-FDSI/agentguard-frontend) | `README.md`, `docs/guia-por-rol.md` |
