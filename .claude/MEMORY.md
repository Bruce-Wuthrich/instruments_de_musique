# Mémoire partagée du projet

Ce fichier est importé par `CLAUDE.md` : il est chargé à chaque session Claude Code, sur toutes les machines qui ont le dépôt à jour.
**À tenir à jour à la fin de chaque session** (état d'avancement, décisions, prochaines étapes). Le détail de chaque modification est dans `documentation-dev/`.

Dernière mise à jour : 2026-11-09 12:20 — branche `feature/01-install-claude`

## Où on s'est arrêté (session du 2026-11-09)

- Fin de la phase **installation** (environnement + configuration de Claude). Aucun code métier écrit.
- Conteneurs Docker **arrêtés** (`docker compose stop`) : les relancer avec `docker compose up -d` (ou `docker compose start`).
- Modifications **non commitées** à la fin de la session : `CLAUDE.md`, `README.md` (section « Arrêter l'environnement »), `.claude/MEMORY.md`, `.claude/agents/designer.md`, `.claude/agents/documentaliste.md`, fiches `documentation-dev/` de 12-05 à 12-19 (dont le renommage des fiches mal datées). Vérifier avec `git status` et commiter avant de changer de machine.
- Prochaine action prévue : étape 1 des « Prochaines étapes » ci-dessous (modèle de données avec l'agent `architecte`).
- Agents disponibles seulement après redémarrage de Claude Code (`/agents` pour vérifier).

## État d'avancement

### Fait
- Squelette Symfony 7.4 webapp ; PHP minimum 8.4 (`composer.json`).
- Environnement Docker opérationnel et testé : PHP 8.4 + Apache (`docker/php/`), MariaDB 11.4, phpMyAdmin, Mailpit (adresses dans `README.md`).
- Envoi de mail vers Mailpit testé (`mailer:test`).
- Base `app` et base de test `app_test` créées.
- Agents Claude dans `.claude/agents/` (voir `CLAUDE.md`, section Agents).
- Journal des modifications : `documentation-dev/` (modèle dans `documentation-dev/README.md`).

### Pas encore fait
- Aucune entité, aucun contrôleur, aucune migration, aucun test.
- `template.html.twig` (enfant de `base.html.twig`) n'existe pas encore.
- Sécurité : fournisseur d'utilisateurs en mémoire provisoire (pas d'entité `User`).
- Traductions `fr` : aucune clé.
- Charte graphique : `assets/styles/app.css` ne contient qu'un fond `skyblue` provisoire ; `design/CHARTE.md` à créer.

## Décisions prises

- Base de données : **MariaDB** (pas PostgreSQL) ; le conteneur `php` reçoit `DATABASE_URL` avec l'hôte `database`, WSL utilise `127.0.0.1:3306` via `.env`.
- PHP **8.4** (version installée) : pas de syntaxe PHP 8.5.
- Commandes dans le conteneur **toujours en `-u www-data`** (uid 1000 = utilisateur WSL).
- Pas de fichier `.gitattributes` (refusé par l'équipe) ; écrire les fichiers en LF.
- Claude ne commit pas et ne crée pas de branche ; l'équipe commit elle-même.
- Heure des fiches `documentation-dev/` : toujours lue avec `date "+%Y-%m-%d-%H-%M"`, jamais estimée.
- Agent `designer` en opus (demande de l'équipe).

## Prochaines étapes proposées

1. `architecte` : modèle de données (Section, Instrument, Photo, ExtraitSonore, Commentaire, User) et règles d'accès (admin / utilisateur / visiteur).
2. `designer` : charte graphique et maquette de la page d'accueil (historique des cordes frottées).
3. `dev-symfony` : entités + première migration (crée aussi la table `messenger_messages`, nécessaire aux mails en async).
4. `dev-front` : `template.html.twig`, page d'accueil, navigation entre sections.

## Reprendre sur une autre machine

```bash
git clone git@github.com:Bruce-Wuthrich/instruments_de_musique.git
cd instruments_de_musique
docker compose up -d --build
docker compose exec -u www-data php composer install
docker compose exec -u www-data php php bin/console doctrine:migrations:migrate -n
```
Si l'UID WSL n'est pas 1000 : `docker compose build --build-arg UID=$(id -u) --build-arg GID=$(id -g) php`.

## Points ouverts / problèmes connus

- Mails de l'application routés en async : il faut une migration (table `messenger_messages`) puis `php bin/console messenger:consume async`.
- Port SMTP de Mailpit attribué au hasard côté hôte (l'interface web reste sur 8025).
- `config/reference.php` est régénéré par `cache:clear` (différence de fins de ligne uniquement).
