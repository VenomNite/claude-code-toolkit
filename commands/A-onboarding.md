---
description: "Genera guía de onboarding clara, breve y detallada, adaptada al rol."
argument-hint: [--developer | --designer | --devops | --comprehensive | --interactive]
model: sonnet
---

# Developer Onboarding Guide Generator

## Context
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`

## Contexto del Proyecto
- Detecta stack: @package.json | @requirements.txt | @Cargo.toml
- Documentación existente: @README.md | @docs/

## Tareas

1. **Resumen del Proyecto**
   - Qué hace el proyecto y por qué existe.
   - Stack principal detectado y arquitectura en 3–5 bullets.
   - Principales módulos/carpetas y qué contienen.

2. **Setup Rápido**
   - Herramientas mínimas a instalar (lenguaje, framework, dependencias).
   - Comandos paso a paso para levantar el entorno.
   - Cómo comprobar que todo funciona.

3. **Flujo de Trabajo**
   - Cómo desplegar o simular el deploy local.

4. **Tips y Recursos**
   - 2–3 prácticas coding standards o reglas del proyecto ("Less is sometimes better", modularidad).
   - Preguntas frecuentes o errores típicos.

## Output
- Una guía en Markdown, lista para entregar a un nuevo miembro.
- Estructurada en secciones, sin relleno innecesario.
- Detallada, completa pero de fácil lectura, comprensión y asimilación.

## DoD
- Stack detectado correctamente desde package.json/requirements.txt/Cargo.toml
- Guía generada y adaptada al rol específico solicitado
- Cuatro secciones completas: Resumen, Setup Rápido, Flujo de Trabajo, Tips
- Documentación existente (README, docs/) analizada e incorporada
- Comandos de instalación/setup validados y funcionales
- Formato Markdown estructurado, legible y sin relleno innecesario