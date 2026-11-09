# Version de PHP dans CLAUDE.md

- **Date** : 2026-11-09 11:55
- **Branche** : feature/01-install-claude

## Fichiers modifiés ou créés

- `CLAUDE.md` — modifié : stack « PHP 8.5 » remplacé par « PHP 8.4 ».

## Raisons

La version installée dans WSL est PHP 8.4 (confirmé par l'équipe). Claude ne doit pas utiliser de fonctionnalités propres à PHP 8.5.

## Agents utilisés

- Aucun (Claude Code seul).

## Points d'attention / suite

- `composer.json` exige toujours `php >= 8.2` : inchangé.
