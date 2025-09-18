---
model: sonnet
description: Configura entorno Claude completo en proyecto actual con jStyle, memoria, notas y screenshots
argument-hint: [--full] [--docs-only]
---

# Setup Claude Environment

Configura el entorno completo de Claude en el proyecto actual: $ARGUMENTS

## Contexto
- Proyecto actual: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Fuente: Auto-detection con fallbacks:
  - Primario: ~/docs-link/docs/Claude/
  - Fallback WSL: /mnt/c/Proyectos/Documentación/docs/Claude/
  - Fallback Windows: C:\Proyectos\Documentación\docs\Claude\
- Estructura completa: Doc, MemoriaAgentes, Notas, Plan, Research, Screens

## Proceso
1. **Verificación**: Comprobar que no existe ./Claude/
2. **Copia**: Copiar estructura completa manteniendo symlinks
3. **Validación**: Confirmar que Screens/ mantiene el mklink
4. **Confirmación**: Mostrar estructura creada

## Output
- Carpeta Claude/ configurada en proyecto actual
- jStyle rules disponibles en Claude/Doc/
- Screenshots accesibles vía Claude/Screens/ (symlink)
- Memoria, notas y planificación listos

## Ejemplos
- `/A-setupclaude`
- `/A-setupclaude --full` (incluye validación extensa)

## DoD
- Verificación exitosa que no existe ./Claude/ previo
- Fuente detectada correctamente con fallback apropiado
- Estructura completa copiada: Doc, MemoriaAgentes, Notas, Plan, Research, Screens
- Symlinks preservados correctamente (especialmente Claude/Screens/)
- jStyle rules disponibles en Claude/Doc/jStyle-*
- Confirmación final mostrando estructura creada y funcional