# Arrêt de Docker documenté dans le README

- **Date** : 2026-11-09 12:19
- **Branche** : feature/01-install-claude

## Fichiers modifiés ou créés

- `README.md` — modifié : section « Arrêter l'environnement » (`docker compose stop`, `down`, vérification `ps -a`, avertissement sur `down -v`, arrêt depuis Docker Desktop).

## Raisons

Demande de l'équipe : savoir arrêter l'environnement manuellement. Les conteneurs du projet ont été arrêtés avec `docker compose stop` (database, php, phpmyadmin, mailer : « Exited (0) »).

## Agents utilisés

- Aucun (Claude Code seul).
