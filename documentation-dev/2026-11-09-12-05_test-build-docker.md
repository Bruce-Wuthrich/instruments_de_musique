# Test du build Docker et corrections

- **Date** : 2026-11-09 12:05
- **Branche** : feature/01-install-claude

## Fichiers modifiés ou créés

- `docker/php/Dockerfile` — modifié : création de `/var/www/.composer` appartenant à `www-data` (le cache Composer n'était pas accessible en écriture).
- `CLAUDE.md` — modifié : `docker compose exec -u www-data php bash` ; note `MSYS_NO_PATHCONV=1` pour les commandes Docker lancées depuis Git Bash.

## Raisons

Premier test réel de l'environnement Docker (Docker Desktop lancé).

## Résultats des tests

| Vérification | Résultat |
|---|---|
| `docker compose up -d --build` | OK, 4 services démarrés (`database` healthy) |
| PHP dans le conteneur | 8.4.27, extensions intl, pdo_mysql, zip, opcache présentes |
| `www-data` | uid/gid 1000 |
| `composer install` (en www-data) | OK, cache Composer fonctionnel après correction |
| http://localhost:8000 | page « Welcome to Symfony! » (statut 404 normal : aucune route) |
| http://localhost:8080 (phpMyAdmin) | 200 |
| http://localhost:8025 (Mailpit) | 200 |
| Connexion Doctrine → MariaDB | OK, `11.4.13-MariaDB` |
| Base de test | `app_test` créée (droits de `init.sql` OK) |
| `php bin/phpunit` | s'exécute, aucun test pour l'instant |

## Agents utilisés

- Aucun (Claude Code seul).

## Points d'attention / suite

- `doctrine:schema:validate` signale un schéma non synchronisé : normal, aucune migration n'existe encore (table `messenger_messages` notamment). Sera réglé par la première `make:migration`.
- Les commandes doivent être lancées en `-u www-data` dans le conteneur (l'utilisateur par défaut est root, nécessaire à Apache).
