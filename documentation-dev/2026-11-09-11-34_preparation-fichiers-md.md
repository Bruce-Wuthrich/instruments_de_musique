# Préparation des fichiers .md de fonctionnement de Claude

- **Date** : 2026-11-09 11:34
- **Branche** : feature/01-install-claude

## Fichiers modifiés ou créés

- `CLAUDE.md` — créé (via `/init`) puis complété par l'équipe ; ajout des sections « Commandes » et « Conventions », lien vers le modèle de documentation, correction de la coquille `template.html.twwig`.
- `documentation-dev/README.md` — créé : règles de nommage et modèle des fiches.
- `documentation-dev/2026-11-09-11-34_preparation-fichiers-md.md` — créé : cette fiche.

## Raisons

Donner à Claude Code le contexte du projet (objectif, stack, commandes, conventions) et mettre en place le journal des modifications demandé dans `CLAUDE.md`.

## Agents utilisés

- Aucun (Claude Code seul).

## Points d'attention / suite

- `.env` contient deux lignes `DATABASE_URL` actives (MariaDB puis PostgreSQL) : la dernière l'emporte, c'est donc PostgreSQL qui est utilisé. Commenter la ligne PostgreSQL.
- `compose.yaml` lance encore PostgreSQL ; il faut le remplacer par MariaDB + phpMyAdmin pour suivre la stack prévue.
- `CLAUDE.md` indique PHP 8.5 alors que `composer.json` demande `>=8.2` : vérifier la version installée (`php -v`) et éventuellement relever la contrainte.
- La « cible » dans `CLAUDE.md` mentionne les instruments « de types bois » : à vérifier (le site porte sur les cordes frottées).
