# Estado del proyecto

Estado verificado al 30 de octubre de 2026 sobre la rama `main` de cada repositorio. Distinguimos tres
categorías, y ninguna significa «listo para producción».

## Integrado en la demo (Config. B)

- `AgentGuard.authorize(session, tool, arguments)` se llama antes de ejecutar cada herramienta. `BLOCK` no
  ejecuta; `HITL` espera a un aprobador distinto del solicitante.
- La identidad (área y nivel) sale de la sesión, no de los argumentos que escriba el modelo.
- Cada decisión se registra antes de ejecutar. Si el registro falla, la acción no se ejecuta (falla cerrado).
- Verificador de entrada por reglas y regla de acceso entre áreas, con aviso a Tecnología.
- Cola de aprobación con separación de funciones y log encadenado por hash, usados desde la API.
- API (FastAPI) con sesión, chat, aprobaciones, seguridad, políticas y comparación A/B, e interfaz web
  (React, TypeScript, Vite) con las mismas pantallas.
- Experimento A/B con seis escenarios y modelos intercambiables (guion determinista, Gemini, Groq y Ollama).

## Implementado en el núcleo, pero no integrado

Nada relevante: las piezas del núcleo del Avance 3 ya se usan desde la demo.

## Planeado (no construido)

- Escenarios 7 a 9 del experimento: acceso entre áreas, escrituras masivas y autoaprobación.
- Autenticación real (JWT) y firma de la cadena de auditoría. Hoy la sesión es de demostración y la cadena
  detecta alteraciones por hash, pero no las impide.
- Integración con identidad, correo y bases de datos empresariales.

## Pruebas

| Repositorio | Pruebas que pasan |
|---|---|
| `agentguard-core` | 367 |
| `agentguard-andimarket` | 205 |
| `agentguard-frontend` | 17 |

## Límites

Las herramientas y sus efectos son simulados. AgentGuard corre en el mismo proceso que el agente: no es un
sandbox ni una frontera de aislamiento. El verificador de entrada es por reglas y se puede esquivar; la
inyección indirecta la contienen las restricciones por argumento y la aprobación humana. Los resultados con
modelo real dependen de un solo modelo y de una muestra pequeña.
