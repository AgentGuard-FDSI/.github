# Política de seguridad

AgentGuard es un **prototipo académico** del curso Fundamentos de Seguridad de la Información de la Escuela
Colombiana de Ingeniería Julio Garavito. No está listo para producción ni recibe soporte.

## Alcance y límites conocidos

- Las herramientas y sus efectos son simulados; no hay integración con correo, identidad ni bases de datos reales.
- AgentGuard corre en el mismo proceso que el agente. No es un sandbox ni una frontera de aislamiento.
- El verificador de entrada es por reglas y se puede esquivar con reformulaciones.
- La sesión es de demostración (no hay autenticación empresarial) y la cadena de auditoría no está firmada.
- Los resultados con modelo real dependen de un solo modelo y de una muestra pequeña.

## Cómo reportar un problema

Abre un *issue* en el repositorio afectado de la organización. Si el problema expone una clave o un dato
sensible, no lo publiques en el *issue*: avisa primero a alguien del equipo por un canal privado.

## Secretos

Las claves de los modelos remotos van en un `.env` local que no se versiona. Si una clave llega a subirse al
repositorio, debe revocarse y generarse una nueva; borrarla del historial no basta.
