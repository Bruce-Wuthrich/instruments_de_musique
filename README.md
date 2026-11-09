# Instruments de musique

## Démarrer l'environnement

```bash
docker compose up -d --build
docker compose exec -u www-data php composer install
```

## Arrêter l'environnement

À lancer dans WSL, à la racine du projet :

```bash
docker compose stop        # arrête les conteneurs (redémarrage rapide avec : docker compose start)
docker compose down        # arrête et supprime les conteneurs ; les données de la base sont conservées
docker compose ps -a       # vérifier : les services doivent être « Exited » ou absents
```

⚠️ `docker compose down -v` supprime aussi le volume de la base : **toutes les données MariaDB sont perdues**.

Sans terminal : Docker Desktop → onglet **Containers** → bouton ⏹ (Stop) sur le groupe `instruments_de_musique`.

## Adresses en local

| Service | Adresse | Port |
|---|---|---|
| Site Symfony | http://localhost:8000 | 8000 |
| phpMyAdmin | http://localhost:8080 | 8080 |
| Mailpit (interface web) | http://localhost:8025 | 8025 |

