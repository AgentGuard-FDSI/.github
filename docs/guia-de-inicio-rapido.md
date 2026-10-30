# Guía de inicio rápido

Cómo levantar la demostración completa en Windows. Los tres repositorios deben estar clonados en la misma
carpeta, uno al lado del otro:

```
agentguard-core/
agentguard-andimarket/
agentguard-frontend/
```

Requisitos: Python 3.10 o superior y Node.js 20 o superior.

## 1. Núcleo (opcional, para probar la librería sola)

```powershell
cd agentguard-core
py -m venv .venv
.venv\Scripts\Activate.ps1
pip install -e ".[dev]"
pytest
```

## 2. Agente y API

```powershell
cd agentguard-andimarket
py -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt -r requirements-dev.txt
python scripts/cargar_olist.py
python -m pytest
python -m andimarket.api
```

`requirements.txt` instala `agentguard-core` en modo editable desde `../agentguard-core`. Por defecto se usa
el modelo de guion determinista: no necesita red ni claves.

Para comparar Config. A y Config. B por consola:

```powershell
python -m andimarket.config_a --prompt todos
python -m andimarket.config_b --prompt todos
```

## 3. Interfaz web

En otra terminal:

```powershell
cd agentguard-frontend
npm install
npm run dev
```

Abre http://localhost:5173 e inicia sesión con un usuario de `andimarket/directorio.py`. La guía
[por rol](https://github.com/AgentGuard-FDSI/agentguard-frontend/blob/main/docs/guia-por-rol.md) explica qué
ve cada nivel.

## Modelos remotos

Gemini y Groq necesitan una clave en un archivo `.env` local (hay un `.env.example`). No la subas al
repositorio. Antes de correr comparaciones con muchas llamadas, revisa la cuota gratuita del proveedor.

## Si algo falla

- Si `pip install` no encuentra `agentguard-core`, comprueba que esté al mismo nivel que `agentguard-andimarket`.
- Si la interfaz no carga datos, comprueba que la API esté corriendo (`/api/salud`).
- Si una aprobación pendiente impide correr los escenarios A/B, resuélvela primero en la pestaña Aprobaciones.
