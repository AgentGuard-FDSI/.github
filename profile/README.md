# AgentGuard

**Mínimo privilegio para agentes de IA con acceso a herramientas.**

AgentGuard es un interceptor de políticas que se ubica entre un agente LLM y las herramientas que puede ejecutar (consultar o modificar pedidos, leer bases de datos, enviar correos, ejecutar acciones administrativas, entre otras). Antes de permitir cualquier acción, evalúa el rol del usuario, el nivel jerárquico y el riesgo de la herramienta contra un conjunto de políticas declarativas, y decide si la ejecuta, la bloquea o la escala a un humano para aprobación.

## El problema

Los agentes de IA con herramientas y permisos amplios pueden ejecutar acciones dañinas o no autorizadas, ya sea por errores propios del modelo o por manipulación externa (prompt injection). Ese riesgo crece cuando el mismo agente atiende a distintas áreas de una organización sin distinguir qué le corresponde a cada una.

## La propuesta

Comparamos dos configuraciones del mismo agente:

- **Config A** — sin control de permisos: el agente ejecuta cualquier herramienta que decida usar.
- **Config B** — con AgentGuard: cada llamada a una herramienta pasa por un motor de políticas de mínimo privilegio, definido por área/dependencia (no por roles genéricos tipo cliente/administrador), con verificación de contenido en el input, aprobación humana para acciones irreversibles, y registro de auditoría con no repudio.

El objetivo es medir cuánto reduce AgentGuard el impacto de una decisión incorrecta o manipulada, sin frenar las acciones legítimas de bajo riesgo.

## Repositorios

| Repositorio | Qué es |
|---|---|
| [`agentguard-core`](https://github.com/AgentGuard-FDSI/agentguard-core) | El producto: librería que decide `ALLOW`, `BLOCK` o `HITL` para cada llamada a una herramienta según el área y el nivel de la sesión, la herramienta y sus argumentos. |
| [`agentguard-andimarket`](https://github.com/AgentGuard-FDSI/agentguard-andimarket) | El agente de ANDIMARKET S.A.S. (empresa ficticia de comercio electrónico) y el experimento: la Config. A sin AgentGuard y la Config. B con AgentGuard instalado, con sus herramientas simuladas, datos y escenarios. |
| `agentguard-frontend` | La interfaz web para comparar ambas configuraciones. Se publicará en el Avance 3. |

`agentguard-andimarket` instala `agentguard-core` como paquete: la Config. A no lo usa y la Config. B envuelve cada herramienta con él.

## Contexto académico

Este proyecto se desarrolla para la 23.ª edición del Seminario de Seguridad de la Información de la Escuela Colombiana de Ingeniería Julio Garavito, dentro del tema **"Autonomía excesiva en agentes"**: comparar un agente con herramientas y permisos amplios frente a otro configurado con mínimo privilegio, para limitar el impacto de decisiones incorrectas o manipuladas.

## Estado del proyecto

En desarrollo activo. Cada repositorio documenta en su README qué está listo y qué falta: empieza por [`agentguard-core`](https://github.com/AgentGuard-FDSI/agentguard-core) para el producto y por [`agentguard-andimarket`](https://github.com/AgentGuard-FDSI/agentguard-andimarket) para el agente y el experimento.
