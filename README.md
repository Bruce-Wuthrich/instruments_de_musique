# Instruments de musique

## Démarrer l'environnement

```bash
docker compose up -d --build
docker compose exec -u www-data php composer install
```

## Adresses en local

| Service | Adresse | Port |
|---|---|---|
| Site Symfony | http://localhost:8000 | 8000 |
| phpMyAdmin | http://localhost:8080 | 8080 |
| Mailpit (interface web) | http://localhost:8025 | 8025 |

