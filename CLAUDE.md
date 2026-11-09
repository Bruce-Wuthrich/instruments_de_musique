# Instrument de musique : Cordes frottées

ce sera un site de presentation des instruments de musique de type cordes frottés (Violon, alto, violoncelle, contrebasse, viole de gambe, etc), on devra pouvoir y poster différents modèles d instruments d un meme type.

**cible** : les passionnés de musiques , et particulierement des instruments à cordes frottées.

**Langue** : tout en francais pour le moment (meme notre conversation et les commandes), d autres (anglais espagnol , etc) suivront sur le site , mais dans un second temps.

**architecture**: La page d accueil sera un historique de la famille des cordes frottées .Les sections seront `Violon`, `alto`,`violoncelle`,`contrebasse`, `viole de gambe`et `Monocorde à clavier`. on pourra y inserer des instruments avec des photos et un extrait sonore( si disponible ) . un Admin pourra ajouter et ou modifier des instruments et des sections. les autres utilisateurs pourront poster  des commentaires à valider.

**stack** :
- on travaille en wsl2 unbuntu sous windows 11 
- symfony 7.4 LTS avec webapp
- PHP 8.4
- frontend avec  Importmap et ux.symfony (https://ux.symfony.com/), les templates sont en twig
- base de donnée : Mariadb avec PHPMyAdmin
- Mailpit pour les mails en dev
- Docker pour travailler localement

**github** : git@github.com:Bruce-Wuthrich/instruments_de_musique.git


## Project

"Instruments de musique : Cordes frottées" — a Symfony 7.4 web application (PHP >= 8.4) at the skeleton stage: `src/Controller`, `src/Entity` and `src/Repository` are still empty, so most features will be built with MakerBundle. The repo lives in WSL (Ubuntu 22.04); run PHP/Composer/Docker commands inside WSL, not from Windows.


## Architecture notes

- **Frontend**: AssetMapper + importmap (`importmap.php`), node.js non nécessaire. point d'entrée `assets/app.js`; Stimulus controllers dans `assets/controllers/` (auto-registered via `assets/stimulus_bootstrap.js`), Turbo enabled. Templates dans `templates/` (Twig, étendu d'un `template.html.twig` enfant de  `base.html.twig`).
- **Database**: Doctrine ORM 3 avec mapping d'attributs; `DATABASE_URL` dans `.env` en MariaDB.
- **Services**: autowired/autoconfigured de `src/` (`config/services.yaml`); routes sont chargées par les attributs de contrôlleurs.
- Langue par défaut du projet `en`; mais nous utiliserons en premier le `fr` via `translations/`.



## Commandes (à lancer dans WSL, à la racine du projet)

```bash
docker compose up -d --build                     # lance tout l'environnement (voir ci-dessous)
docker compose exec -u www-data php bash         # shell dans le conteneur PHP : toutes les commandes suivantes s'y lancent
                                                 # (toujours -u www-data, sinon les fichiers créés appartiennent à root)
composer install                                 # dépendances + cache:clear, assets:install, importmap:install

php bin/console make:entity                      # génération (make:controller, make:crud, make:user, make:form…)
php bin/console make:migration
php bin/console doctrine:migrations:migrate
php bin/console importmap:require <paquet>       # ajouter une dépendance JS
php bin/console messenger:consume async          # nécessaire pour envoyer les mails (routés en async)

php bin/phpunit                                  # tous les tests
php bin/phpunit tests/Chemin/VersTest.php        # un fichier
php bin/phpunit --filter nomDeLaMethode          # un test
```

Services Docker (`compose.yaml` + `compose.override.yaml` en dev) :
- `php` : image `docker/php/Dockerfile` (PHP 8.4 + Apache, Composer, extensions intl/pdo_mysql/zip/opcache) → site sur http://localhost:8000. Le projet est monté dans `/var/www/html` ; `www-data` a l'UID 1000 de l'utilisateur WSL.
- `database` : MariaDB 11.4, port 3306 (hôte `database` depuis les conteneurs, `127.0.0.1` depuis WSL — `DATABASE_URL` est surchargée dans le service `php`).
- `phpmyadmin` : http://localhost:8080 — `mailer` (Mailpit) : http://localhost:8025, utilisé par le conteneur `php` via `MAILER_DSN`.

Pour Claude Code (Git Bash sous Windows) : préfixer les commandes Docker par `export MSYS_NO_PATHCONV=1;`, sinon les chemins comme `/var/www/html` sont convertis en chemins Windows. Exemple : `docker compose exec -T -u www-data php php bin/console …`.

Depuis WSL (PHP 8.4 installé), les commandes `php bin/console …` fonctionnent aussi directement, en se connectant à MariaDB via `127.0.0.1:3306`.

PHPUnit échoue sur toute dépréciation, notice ou warning (`phpunit.dist.xml`). Les tests utilisent une base suffixée `_test` (`php bin/console --env=test doctrine:database:create`).

## Conventions

- `.editorconfig` : UTF-8, fins de ligne **LF**, indentation 4 espaces (2 pour `compose*.yaml`) — à respecter même en éditant depuis Windows.
- Surcharges locales (ex. `DATABASE_URL`) dans `.env.local`, jamais commité.
- Alias git de l'équipe : voir `RACCOURCIS.md`.

## Commits et documentation

Claude ne peut pas créer de branches ni faire de commit lui-même.
Il doit par contre documenter chaque modification dans le dossier `documentation-dev`
- format : YYYY-MM-DD-HH-MM_description-courte.md
- contenu minimal : date, fichiers modifiés ou créés, raisons, liste des agents utilisés
- modèle à suivre : `documentation-dev/README.md`


## Agents (`.claude/agents/`)

Répartir le travail selon la difficulté :

| Agent | Modèle | Pour quoi |
|---|---|---|
| `architecte` | opus | conception (entités, sécurité, architecture), découpage d'une fonctionnalité, revue critique, bugs complexes — ne modifie pas de fichiers |
| `dev-symfony` | sonnet | back-end : entités, migrations, contrôleurs, formulaires, sécurité, upload |
| `designer` | opus | charte graphique (`design/CHARTE.md`), variables CSS, maquettes, responsive, accessibilité visuelle |
| `dev-front` | sonnet | Twig, CSS, Stimulus, Turbo, Symfony UX |
| `testeur` | sonnet | tests PHPUnit et analyse des échecs |
| `traducteur` | haiku | clés de traduction, textes, orthographe |
| `verificateur` | haiku | lint, schéma, routes, tests, Docker, Mailpit — ne modifie pas de fichiers |
| `documentaliste` | haiku | fiche `documentation-dev/` après chaque modification |

Enchaînement type pour une fonctionnalité : `architecte` → (`designer` si la fonctionnalité a une interface) → `dev-symfony` / `dev-front` → `testeur` → `verificateur` → `documentaliste`. Une tâche simple et bien définie n'a pas besoin de passer par l'architecte.

## Mémoire partagée

État d'avancement, décisions et prochaines étapes : voir `.claude/MEMORY.md` (importé ci-dessous). Le mettre à jour à la fin de chaque session.

@.claude/MEMORY.md
