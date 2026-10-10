# AgentGuard

> ⚠️ Estado: ***EN DESARROLLO*** Versión académica

AgentGuard es una librería de Python que se ubica entre un agente de IA y las herramientas que puede ejecutar. Antes de cada llamada decide si la permite (`ALLOW`), la bloquea (`BLOCK`) o la escala a aprobación humana (`HITL`), según el área y el nivel de quien usa el agente, la herramienta y sus argumentos. Resuelve el problema de que un agente con permisos amplios puede ejecutar acciones dañinas o no autorizadas, por un error del modelo o por manipulación externa (prompt injection), sobre todo cuando atiende a varias áreas de una organización sin distinguir qué le corresponde a cada una. Su diferenciador es el mínimo privilegio definido por área (no por roles genéricos), con aprobación humana para acciones irreversibles y registro de las decisiones. Se evalúa comparando el mismo agente de ANDIMARKET S.A.S. (empresa ficticia de comercio electrónico) sin AgentGuard (Config. A) y con AgentGuard (Config. B).

---

## 👥 Autores — Equipo AgentGuard
TATIANA MARCELA GOMEZ SARMIENTO, SANTIAGO NARANJO MELO y FABIAN EDUARDO SIERRA SANCHEZ
* BRAYAN LOAIZA LEAL
* JUAN DAVID MORENO D'ALEMAN
* JUAN SEBASTIÁN GUAYAZÁN CLAVIJO
* KAROL XIMENA RODRIGUEZ REYES

Fundamentos de Seguridad de la Información (ISIS FDSI-1 y FDSI-1L, FDSI-4L)  
Decanatura Ingeniería de Sistemas → Centro de Estudios en Gestión y Arquitectura de Datos, Tecnología y Ciberseguridad  
Ingeniería de Sistemas  
Escuela Colombiana de Ingeniería Julio Garavito  
2026-2

---

## El problema

Los agentes de IA con herramientas y permisos amplios pueden ejecutar acciones dañinas o no autorizadas, ya sea por errores propios del modelo o por manipulación externa (prompt injection). Ese riesgo crece cuando el mismo agente atiende a distintas áreas de una organización sin distinguir qué le corresponde a cada una.

## La propuesta

Comparamos dos configuraciones del mismo agente, con la misma sesión, el mismo prompt, el mismo modelo, las mismas herramientas y los mismos datos:

- **Config. A** — sin control de permisos: el agente ejecuta cualquier herramienta que decida usar.
- **Config. B** — con AgentGuard: cada llamada pasa por el motor de políticas antes de ejecutar la misma herramienta. Los permisos se definen por área y nivel (no por roles genéricos como cliente o administrador), la identidad sale de la sesión y no de lo que escriba el modelo, y si no se puede decidir o registrar una acción, esta no se ejecuta (falla cerrado).

El objetivo es medir cuánto reduce AgentGuard el impacto de una decisión incorrecta o manipulada, sin frenar las acciones legítimas de bajo riesgo. Como el agente y las herramientas son los mismos en ambas configuraciones, la diferencia medida se atribuye a la mediación de AgentGuard.

## Repositorios

| Repositorio | Qué es |
|---|---|
| [`agentguard-core`](https://github.com/AgentGuard-FDSI/agentguard-core) | El producto: librería que decide `ALLOW`, `BLOCK` o `HITL` para cada llamada a una herramienta según el área y el nivel de la sesión, la herramienta y sus argumentos. Incluye validación de políticas y de argumentos, servicios de aprobación humana y una cadena de auditoría verificable. |
| [`agentguard-andimarket`](https://github.com/AgentGuard-FDSI/agentguard-andimarket) | El agente de ANDIMARKET S.A.S. y el experimento: la Config. A sin AgentGuard y la Config. B con AgentGuard instalado, con herramientas simuladas, datos en SQLite, modelos intercambiables (guion determinista, Gemini, Groq y Ollama), escenarios y un comparador de resultados. |
| [`agentguard-frontend`](https://github.com/AgentGuard-FDSI/agentguard-frontend) | La interfaz web para comparar ambas configuraciones. Por ahora solo tiene la estructura inicial; el diseño está en un prototipo de Figma. |

`agentguard-andimarket` instala `agentguard-core` como paquete: la Config. A no lo usa y la Config. B envuelve cada herramienta con él.

## Estado del proyecto

- **Integrado en la demo (Config. B):** la decisión `ALLOW`, `BLOCK` o `HITL` antes de cada herramienta, la aprobación humana por consola, el registro de la decisión en SQLite antes de ejecutar y el comportamiento que falla cerrado.
- **Disponible en el núcleo, aún sin conectar a la demo:** la cola de solicitudes de aprobación, la separación de funciones (quien solicita no aprueba) y la cadena de auditoría con hash verificable.
- **Por desarrollar:** el verificador de contenido de entrada, la regla de acceso entre áreas, la API y la interfaz web.

Es un prototipo académico: las herramientas y sus efectos son simulados, y AgentGuard corre en el mismo proceso que el agente, por lo que no es un sandbox ni está listo para producción. Cada repositorio documenta en su README qué está listo y qué falta.

## Contexto académico

Este proyecto se desarrolla para la 23.ª edición del Seminario de Seguridad de la Información de la Escuela Colombiana de Ingeniería Julio Garavito, dentro del tema **"Autonomía excesiva en agentes"**: comparar un agente con herramientas y permisos amplios frente a otro configurado con mínimo privilegio, para limitar el impacto de decisiones incorrectas o manipuladas.
