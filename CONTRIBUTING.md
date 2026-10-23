# Cómo trabajamos en AgentGuard

Esta guía aplica a todos los repositorios de la organización (`agentguard-core`, `agentguard-andimarket`, `agentguard-frontend`). Su objetivo es que cada avance pase por una rama propia, por un pull request y por una revisión, y que el historial cuente lo que realmente pasó.

## 1. Ramas

| Rama | Para qué sirve | Quién escribe en ella |
|---|---|---|
| `main` | Lo entregado y estable. | Solo por pull request desde `develop`. |
| `develop` | Integración de los avances ya revisados. | Solo por pull request desde `avance-N`. |
| `avance-N` (`avance-1`, `avance-2`, `avance-3`…) | Acumula el trabajo de todo el equipo para el avance N. | Solo por pull request desde una rama de trabajo. |
| `feature/personaK-avanceN` | Trabajo de una persona en un avance (por ejemplo `feature/persona2-avance3`). | La persona K. |

Nadie sube commits directamente a `main`, `develop` ni `avance-N`. Los cambios entran por pull request.

## 2. Flujo de un avance

```
feature/personaK-avanceN  ──PR──▶  avance-N  ──PR──▶  develop  ──PR──▶  main
```

1. **Crea tu rama** desde la punta actual de `avance-N`:
   ```bash
   git fetch origin
   git switch -c feature/persona1-avance3 origin/avance-3
   ```
2. **Trabaja y haz commits pequeños** con mensajes que digan qué cambió (`feat(...)`, `fix(...)`, `docs(...)`, `test(...)`, `chore(...)`).
3. **Antes de abrir el pull request**, corre las pruebas del repositorio y confirma que pasan:
   - `agentguard-core`: `pytest`
   - `agentguard-andimarket`: `python -m pytest`
   - `agentguard-frontend`: `npm run build` y `npm test`
4. **Abre el pull request** de tu rama hacia `avance-N`. Describe qué cambia, cómo lo probaste y qué queda pendiente.
5. **Revisión:** otra persona del equipo (nunca quien lo escribió) lo revisa y lo aprueba. Mezcla quien aprobó, o quien escribió después de la aprobación.
6. **Cuando el avance está completo**, se abre un pull request de `avance-N` a `develop`, y de `develop` a `main` para la entrega.

## 3. Reglas

- **No se reescribe el historial compartido:** nada de `git push --force` sobre `main`, `develop` ni `avance-N`.
- **No se cambian fechas ni autorías de commits** para que parezcan de otro momento. El historial es evidencia de lo que se hizo y cuándo.
- **No se tocan reglas, fixtures ni evidencia experimental** para que los resultados se vean mejor. Si una corrida sale mal, se reporta tal cual y se explica.
- **No se suben claves, tokens ni datos reales.** Las credenciales de los modelos remotos van en un `.env` local que no se versiona.
- **Los commits llevan solo a quien los hizo.**

## 4. Nota sobre las protecciones

GitHub no permite proteger ramas (ni exigir revisiones) en repositorios **privados** del plan gratuito de una organización. Por eso estas reglas **no las impone GitHub: las cumplimos por acuerdo del equipo**. Si en algún momento los repositorios pasan a un plan de pago o se hacen públicos, conviene activar la protección de `develop` y `main` con al menos una revisión aprobada y sin pushes forzados.

## 5. Qué se hizo distinto en el Avance 3 (registro honesto)

Para que quede claro cómo se integró el Avance 3 y qué se mejora desde ahora:

- Varios commits del avance se hicieron **directamente sobre `avance-3`**, sin pasar por una rama de trabajo y un pull request.
- La rama `feature/persona1-avance3` de `agentguard-andimarket` se integró a `avance-3` con un **avance rápido (fast-forward)** y sin pull request ni revisión previos.
- En `agentguard-frontend` no existía `develop`: se creó a partir de `main` al abrir el pull request del avance.
- Los pull requests de `avance-3` a `develop` (`agentguard-andimarket#16`, `agentguard-frontend#3`) **sí** se abrieron para revisión. En `agentguard-core`, `develop` ya contenía `avance-3`.

Desde el Avance 4 el flujo de la sección 2 es el que seguimos.
