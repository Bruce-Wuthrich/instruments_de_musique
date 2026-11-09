# Mémoire partagée du projet

- **Date** : 2026-11-09 12:16
- **Branche** : feature/01-install-claude

## Fichiers modifiés ou créés

- `.claude/MEMORY.md` — créé : état d'avancement, décisions prises, prochaines étapes, procédure de reprise sur une autre machine, problèmes connus.
- `.claude/agents/documentaliste.md` — modifié : l'agent tient aussi `.claude/MEMORY.md` à jour.
- `CLAUDE.md` — modifié : section « Mémoire partagée » avec l'import `@.claude/MEMORY.md`.

## Raisons

Pouvoir reprendre le projet dans une autre session ou sur une autre machine. Claude Code ne charge pas `.claude/MEMORY.md` tout seul : l'import dans `CLAUDE.md` le fait charger à chaque session.

## Agents utilisés

- Aucun (Claude Code seul).

## Points d'attention / suite

- Le fichier doit être commité et poussé pour être disponible sur les autres machines.
- Le mettre à jour à la fin de chaque session (à demander à Claude ou à l'agent `documentaliste`).
