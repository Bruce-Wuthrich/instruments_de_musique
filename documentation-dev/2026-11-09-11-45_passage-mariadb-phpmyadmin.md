# Passage de PostgreSQL à MariaDB + phpMyAdmin

- **Date** : 2026-11-09 11:45
- **Branche** : feature/01-install-claude

## Fichiers modifiés ou créés

- `.env` — modifié : la ligne `DATABASE_URL` PostgreSQL est commentée ; la ligne MariaDB est la seule active (`serverVersion=11.4.0-MariaDB`).
- `compose.yaml` — modifié : le service `database` utilise `mariadb:11.4` (variables `MARIADB_*`, healthcheck MariaDB, volume `/var/lib/mysql`) et monte `docker/db/init.sql`.
- `compose.override.yaml` — modifié (dev uniquement) : MariaDB exposé sur `3306:3306`, nouveau service `phpmyadmin` sur http://localhost:8080 (connexion automatique avec l'utilisateur `app`). Mailpit inchangé.
- `docker/db/init.sql` — créé : donne à l'utilisateur `app` les droits sur les bases `app_test*` (base de test Doctrine).
- `CLAUDE.md` — modifié : ligne `docker compose up -d` mise à jour.

## Raisons

La stack prévue dans `CLAUDE.md` est MariaDB + phpMyAdmin, alors que le projet était encore configuré pour PostgreSQL (et `.env` contenait deux `DATABASE_URL` actives, PostgreSQL l'emportant).

## Agents utilisés

- Aucun (Claude Code seul).

## Points d'attention / suite

- Non testé : Docker Desktop n'était pas lancé. Pour vérifier :
  ```bash
  docker compose up -d
  docker compose ps                     # database doit être "healthy"
  php bin/console doctrine:database:create --if-not-exists
  php bin/console --env=test doctrine:database:create
  ```
- `init.sql` ne s'exécute qu'à la **création** du volume. Si un volume `database_data` existe déjà : `docker compose down -v` (efface les données).
- Le port 3306 doit être libre sur la machine (pas d'autre MySQL/MariaDB local).
- `config/packages/doctrine.yaml` garde une préférence `identity` pour PostgreSQL : sans effet sous MariaDB.
- Les mots de passe `!ChangeMe!` sont pour le dev uniquement.
