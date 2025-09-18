---
model: sonnet
description: Gestor To-Do en Markdown por scope con checkboxes y Due/Done
argument-hint: [add|complete|list|import|due|remove|undo] [texto] [--scope] [--due] [--n]
---

# ToDo Manager

Gestiona listas To-Do en Markdown con checkboxes: $ARGUMENTS

## Contexto
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Archivos destino: Claude/todos/<scope>.md (default: general.md)
- Si no existe, crear estructura básica

## Proceso
1. **add**: Añade - [ ] tarea [| Due: DD/MM/YYYY @HH:MM] en ## Active
2. **complete --n**: Mueve a Completed, añade | Done: timestamp
3. **list**: Muestra ítems numerados con conteos
4. **import**: Convierte bullets en ítems - [ ]
5. **due --n --due**: Asigna fecha límite
6. **remove/undo --n**: Elimina o regresa a Active

## Output
- Markdown en Claude/todos/<scope>.md
- Ítems ordenados por Due date
- Respuesta breve con numeración

## Ejemplos
- `/todo add "Revisar API" --scope fix --due "mañana 09:00"`
- `/todo complete --n 3 --scope audit`
- `/todo list --scope plan`

## DoD
- Archivo Claude/todos/<scope>.md creado/actualizado correctamente
- Formato Markdown con checkboxes válidos (- [ ] / - [x])
- Operación ejecutada según comando (add, complete, list, etc.)
- Timestamps aplicados: Due dates y Done timestamps cuando corresponda
- Estructura mantenida: ## Active y ## Completed organizados
- Conteos y numeración mostrados correctamente en respuestas