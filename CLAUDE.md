# Instrument de musique : Cordes frottées

ce sera un site de presentation des instruments de musique de type cordes frottés (Violon, alto, violoncelle, contrebasse, viole de gambe, etc), on devra pouvoir y poster différents modèles d instruments d un meme type.

**cible** : les passionnés de musiques , et particulierement des instruments de types bois .

**Langue** : tout en francais pour le moment (meme notre conversation et les commandes), d autres (anglais espagnol , etc) suivront sur le site , mais dans un second temps.

**architecture**: La page d accueil sera un historique de la famille des cordes frottées .Les sections seront `Violon`, `alto`,`violoncelle`,`contrebasse`, `viole de gambe`et `Monocorde à clavier`. on pourra y inserer des instruments avec des photos et un extrait sonore( si disponible ) . un Admin pourra ajouter et ou modifier des instruments et des sections. les autres utilisateurs pourront poster  des commentaires à valider.

**stack** :
- on travaille en wsl2 unbuntu sous windows 11 
- symfony 7.4 LTS avec webapp
- PHP 8.5
- frontend avec  Importmap et ux.symfony (https://ux.symfony.com/), les templates sont en twig
- base de donnée : Mariadb avec PHPMyAdmin
- Mailpit pour les mails en dev
- Docker pour travailler localement

**github** : git@github.com:Bruce-Wuthrich/instruments_de_musique.git


## Project

"Instruments de musique : Cordes frottées" — a Symfony 7.4 web application (PHP >= 8.2) at the skeleton stage: `src/Controller`, `src/Entity` and `src/Repository` are still empty, so most features will be built with MakerBundle. The repo lives in WSL (Ubuntu 22.04); run PHP/Composer/Docker commands inside WSL, not from Windows.


## Architecture notes

- **Frontend**: AssetMapper + importmap (`importmap.php`), node.js non nécessaire. point d'entrée `assets/app.js`; Stimulus controllers dans `assets/controllers/` (auto-registered via `assets/stimulus_bootstrap.js`), Turbo enabled. Templates dans `templates/` (Twig, étendu d'un `template.html.twwig` enfant de  `base.html.twig`).
- **Database**: Doctrine ORM 3 avec mapping d'attributs; `DATABASE_URL` dans `.env` en MariaDB.
- **Services**: autowired/autoconfigured de `src/` (`config/services.yaml`); routes sont chargées par les attributs de contrôlleurs.
- Langue par défaut du projet `en`; mais nous utiliserons en premier le `fr` via `translations/`.



## Commits et documentation

Claude ne peut pas créer de branches ni faire de commit lui-même.
Il doit par contre documenter chaque modification dans le dossier `documentation-dev`
- format : YYYY-MM-DD-HH-MM_description-courte.md
- contenu minimal : date, fichiers modifiés ou créés, raisons, liste des agents utilisés

