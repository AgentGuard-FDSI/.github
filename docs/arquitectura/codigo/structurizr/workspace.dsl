workspace "AgentGuard" "Control de acceso de minimo privilegio sobre las llamadas a herramientas de un agente LLM. Caso de estudio: ANDIMARKET S.A.S. (ficticia)." {

    !identifiers hierarchical

    model {
        usuario = person "Usuario de la empresa" "Escribe prompts al agente. Su area y nivel salen de la sesion, no de lo que escriba."
        aprobador = person "Aprobador (jefe)" "Aprueba o rechaza acciones HITL. Nunca puede aprobar quien hizo la solicitud."

        llm = softwareSystem "Backend LLM" "Guion determinista (demo), Gemini/Groq (cuota gratuita) u Ollama local." "Externo"

        andimarket = softwareSystem "Agente ANDIMARKET" "Mismo agente, prompt, modelo, herramientas y datos en Config. A y Config. B. Herramientas y efectos simulados." {
            runner = container "CLI / runner" "Elige Config. A o B y crea la sesion (usuario, area, nivel)." "Python: config_a.py, config_b.py, session.py"
            agentLoop = container "Agent Loop" "Envia prompt y definiciones de herramientas al modelo; ejecuta las llamadas a herramientas que este devuelve." "Python: agent/loop.py"
            toolsA = container "RegistryToolbox (Config. A)" "Ejecuta la herramienta directamente, sin autorizacion." "Python: toolbox.py"
            toolsB = container "GuardedToolbox (Config. B)" "Intercepta cada llamada y pide autorizacion a AgentGuard antes de ejecutar la misma herramienta." "Python: toolbox_guard.py"
            negocio = container "SQLite de negocio" "Clientes, pedidos, pagos y configuracion de TI (simulados)." "SQLite" "Almacen"
            evidencia = container "SQLite de evidencia" "Decisiones y efectos de Config. B, guardados antes de ejecutar. Si falla el registro, la accion falla cerrada. Sin cadena de hashes." "SQLite: auditoria.py" "Almacen"
            politica = container "policies.yaml" "Reglas por area, herramienta y argumentos. Se valida al iniciar; politica invalida = no se ejecuta." "YAML" "Almacen"
            consola = container "ConsoleApprover" "HITL actual de la demo: confirmacion por consola. Por defecto rechaza en corridas reproducibles." "Python"
        }

        agentguard = softwareSystem "AgentGuard (libreria)" "Libreria Python instalable que media las llamadas a herramientas. Corre en el mismo proceso que el agente: no es un sandbox." {
            guard = container "AgentGuard.authorize()" "authorize(session, tool, arguments) devuelve ALLOW, BLOCK o HITL. Falla cerrado." "Python: guard.py, decision.py" {
                fachada = component "AgentGuard" "Punto de entrada: orquesta politica, argumentos y decision." "guard.py" "Integrado"
                politicaEngine = component "Motor de politicas" "Carga y valida politicas; resuelve regla por area y herramienta." "policy/loader.py, policy/models.py" "Integrado"
                validador = component "Validacion de argumentos" "Restricciones sobre los argumentos de la herramienta." "guard.py" "Integrado"
                decision = component "Decision" "ALLOW / BLOCK / HITL con motivo." "decision.py" "Integrado"
                directorio = component "Directorio" "Usuarios, areas y niveles para resolver aprobadores." "directory.py" "NucleoSinIntegrar"
                aprobacion = component "ApprovalService" "Cola SQLite de solicitudes HITL." "approval.py" "NucleoSinIntegrar"
                validatingApprover = component "ValidatingApprover" "Separacion de funciones: el solicitante no aprueba." "hitl.py" "NucleoSinIntegrar"
                cadena = component "AuditChain" "Registro encadenado por hash, verificable (audit_cli)." "audit.py" "NucleoSinIntegrar"
            }
            verificador = container "Verificador de entrada y regla entre areas" "Por desarrollar." "Python" "Planeado"
        }

        api = softwareSystem "API y frontend" "FastAPI y React/TypeScript: login, bandeja de aprobaciones, vista de seguridad." "Planeado"

        # Nivel 1: contexto
        usuario -> andimarket "Pide tareas en lenguaje natural"
        aprobador -> andimarket "Aprueba o rechaza acciones HITL (hoy por consola)"
        andimarket -> llm "Prompt y definiciones de herramientas; recibe respuesta o tool call"
        andimarket -> agentguard "Config. B: authorize() antes de cada herramienta"
        usuario -> api "Usara (planeado)"
        api -> agentguard "Usara (planeado)"

        # Nivel 2: contenedores
        usuario -> andimarket.runner "Prompt y escenario"
        andimarket.runner -> andimarket.agentLoop "Texto + sesion + Config. A/B"
        andimarket.agentLoop -> llm "Prompt + herramientas / tool call"
        andimarket.agentLoop -> andimarket.toolsA "Config. A: ejecucion directa"
        andimarket.agentLoop -> andimarket.toolsB "Config. B: llamada interceptada"
        andimarket.toolsA -> andimarket.negocio "Consulta o cambio"
        andimarket.toolsB -> agentguard.guard "session + tool + arguments"
        andimarket.toolsB -> andimarket.consola "Solo si HITL"
        andimarket.toolsB -> andimarket.evidencia "Registra decision antes de ejecutar; falla cerrado"
        andimarket.toolsB -> andimarket.negocio "Solo si ALLOW o HITL aprobada"
        agentguard.guard -> andimarket.politica "Lee reglas"

        # Nivel 3: componentes de AgentGuard.authorize()
        andimarket.toolsB -> agentguard.guard.fachada "authorize(session, tool, arguments)"
        agentguard.guard.fachada -> agentguard.guard.politicaEngine "Resuelve regla"
        agentguard.guard.fachada -> agentguard.guard.validador "Valida argumentos"
        agentguard.guard.fachada -> agentguard.guard.decision "Construye decision"
        agentguard.guard.aprobacion -> agentguard.guard.validatingApprover "Valida aprobador" "" "NucleoSinIntegrar"
        agentguard.guard.validatingApprover -> agentguard.guard.directorio "Consulta area y nivel" "" "NucleoSinIntegrar"
        agentguard.guard.aprobacion -> agentguard.guard.cadena "Registra" "" "NucleoSinIntegrar"
    }

    views {
        systemContext andimarket "Nivel1_Contexto" "C4 nivel 1: quien usa el sistema y con que se relaciona." {
            include *
            autolayout lr
        }

        container andimarket "Nivel2_Contenedores_ANDIMARKET" "C4 nivel 2: Config. A y Config. B sobre el mismo agente." {
            include *
            autolayout lr
        }

        container agentguard "Nivel2_Contenedores_AgentGuard" "C4 nivel 2: la libreria y quien la llama." {
            include *
            autolayout lr
        }

        component agentguard.guard "Nivel3_Componentes" "C4 nivel 3: componentes de AgentGuard.authorize(). Solido = integrado en la demo; punteado ambar = en el nucleo sin integrar." {
            include *
            autolayout lr
        }

        styles {
            element "Person" {
                shape person
                background #334155
                color #ffffff
            }
            element "Software System" {
                background #1D4ED8
                color #ffffff
            }
            element "Container" {
                background #2563EB
                color #ffffff
            }
            element "Component" {
                background #16804A
                color #ffffff
            }
            element "Almacen" {
                shape cylinder
                background #B7791F
                color #ffffff
            }
            element "Externo" {
                background #64748B
                color #ffffff
            }
            element "Integrado" {
                background #16804A
                color #ffffff
            }
            element "NucleoSinIntegrar" {
                background #FFF8E7
                color #53370A
                stroke #C27A00
                strokeWidth 3
                border dashed
            }
            element "Planeado" {
                background #F3E8FF
                color #4C1D95
                stroke #7C3AED
                border dashed
            }
            relationship "NucleoSinIntegrar" {
                dashed true
                color #C27A00
            }
        }
    }
}
