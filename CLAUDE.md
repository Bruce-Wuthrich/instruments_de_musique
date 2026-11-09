# Instruments de musique : Les bois

Ce sera un site de présentation des instruments de musique de type bois (Clarinettes, Saxophones, etc...), On devra pouvoir y poster différents modèles d'instruments d'un même type.

**Cible** : Les passionnés de musique, et particulièrement des instruments de type bois.

**Langue** : tout en français pour le moment (même notre conversation et les commandes) , d'autres langues (Anglais, Espagnol, etc) suivront sur le site, mais dans un second temps.

**Architecture** : La page d'accueil sera un historique de la famille des bois. Les sections principales seront `flûtes à bec`, `hautbois`, `clarinettes`, `bassons`,  et `saxophones`. On pourra y insérer des instruments, avec des photos et un extrait sonore (si disponible). Un administateur pourra ajouter/modifier des instruments et des sections. Les autres utilisateurs pourront poster des commentaires à valider. 

**Stack** : 
- On travail en WSL2 Ubuntu sous Windows 11
- Symfony 7.4 LTS avec webapp
- PHP 8.5
- Frontend avec Importmap et ux.symfony (https://ux.symfony.com/), les templates sont en Twig
- Base de donnée : Mariadb avec PHPMyAdmin
- Mailpit pour les mails en dev
- Docker pour travailler localement

**GitHub**: https://github.com/WebDevCF2m/instruments_de_musique


## Architecture notes

- **Frontend**: AssetMapper + importmap (`importmap.php`), node.js non nécessaire. point d'entrée `assets/app.js`; Stimulus controllers dans `assets/controllers/` (auto-registered via `assets/stimulus_bootstrap.js`), Turbo enabled. Templates dans `templates/` (Twig, étendu d'un `template.html.twwig` enfant de  `base.html.twig`).
- **Database**: Doctrine ORM 3 avec mapping d'attributs; `DATABASE_URL` dans `.env` en MariaDB.
- **Services**: autowired/autoconfigured de `src/` (`config/services.yaml`); routes sont chargées par les attributs de contrôlleurs.
- Langue par défaut du projet `en`; mais nous utiliserons en premier le `fr` via `translations/`.
