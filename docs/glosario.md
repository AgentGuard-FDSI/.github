# Glosario

| Término | Significado en el proyecto |
|---|---|
| **AgentGuard** | Librería de Python que media las llamadas a herramientas de un agente LLM. |
| **ALLOW / BLOCK / HITL** | Las tres decisiones posibles: permitir, bloquear, o escalar a aprobación humana. |
| **HITL** | *Human in the loop*: una persona aprueba o rechaza antes de que la acción se ejecute. |
| **Config. A / Config. B** | El mismo agente sin AgentGuard (A) y con AgentGuard (B). La diferencia medida se atribuye a la mediación. |
| **Mínimo privilegio** | Cada área y nivel solo puede usar las herramientas y los argumentos que su trabajo exige. |
| **Autonomía excesiva** | Riesgo de que un agente con herramientas y permisos amplios ejecute acciones dañinas o no autorizadas. |
| **Inyección de instrucciones (prompt injection)** | Texto que manipula al modelo para que haga algo que no se le pidió. Es directa si viene del usuario e indirecta si viene dentro del resultado de una herramienta. |
| **Sesión** | Usuario, área y nivel de quien usa el agente. Sale de la autenticación, nunca del prompt. |
| **Política (`policies.yaml`)** | Archivo que define áreas, niveles, herramientas, riesgo, acción base y restricciones por argumento. Es de solo lectura para el agente. |
| **Falla cerrada (*fail-closed*)** | Si no se puede decidir o registrar una acción, no se ejecuta. |
| **Verificador de entrada** | Revisión por reglas del prompt antes de que el agente elija una herramienta. Puede esquivarse. |
| **Regla entre áreas** | Pedir un recurso de otra área da `BLOCK` y avisa al área dueña; repetirlo tres veces en diez minutos genera una alerta a Tecnología. |
| **Separación de funciones** | Quien solicita una aprobación no puede aprobarla. |
| **Cadena de auditoría** | Registro de decisiones encadenado con SHA-256. Detecta alteraciones; no las impide. |
| **ANDIMARKET S.A.S.** | Empresa ficticia de comercio electrónico usada como caso de estudio. |
| **Criterio de éxito** | Regla que decide si, en una corrida, el ataque logró su objetivo. |
| **Falso positivo** | Una acción legítima bloqueada o frenada por AgentGuard. |
| **Fricción** | Proporción de acciones legítimas que requieren aprobación humana. |
