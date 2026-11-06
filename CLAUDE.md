# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

"Instruments de musique" — a Symfony 7.4 LTS `--webapp` project (PHP ≥ 8.2, PHP 8.4 used in dev) built as a CF2m training project. It is currently a fresh skeleton: `src/Controller`, `src/Entity`, `src/Repository` and `migrations/` are empty. The README (in French) documents setup steps under WSL2 on Windows 11; keep its step-by-step style ("Etape N") when adding to it. GitHub: https://github.com/WebDevCF2m/instruments_de_musique

The repo lives inside WSL (`/home/formaweb/instruments_de_musique`); run PHP/Symfony commands from a WSL shell, not Windows PowerShell.

## Commands

```bash
symfony serve -d                      # local web server (Symfony CLI)
docker compose up -d                  # PostgreSQL 16 (+ Mailpit via compose.override.yaml)
php bin/console make:entity           # maker-bundle generators (make:controller, make:form, make:crud...)
php bin/console make:migration
php bin/console doctrine:migrations:migrate
php bin/console importmap:require <pkg>   # add a JS dependency (no npm/webpack)
php bin/console messenger:consume async   # process async messages (emails, notifications)

php bin/phpunit                                   # all tests
php bin/phpunit tests/Path/To/SomeTest.php        # single file
php bin/phpunit --filter testMethodName           # single test
```

PHPUnit (v13) is configured with `failOnDeprecation`, `failOnNotice` and `failOnWarning` — deprecations in `src/` fail the suite. Tests run with `APP_ENV=test` (`.env.test`).

## Architecture notes

- **Frontend**: AssetMapper + importmap (`importmap.php`), no Node build step. Entry point `assets/app.js`; Stimulus controllers in `assets/controllers/` (auto-registered via `assets/stimulus_bootstrap.js`), Turbo enabled. Templates in `templates/` (Twig, extend `base.html.twig`).
- **Database**: Doctrine ORM 3 with attribute mapping; `DATABASE_URL` in `.env` defaults to PostgreSQL 16 (matches `compose.yaml`). Override locally in `.env.local` (git-ignored), not in `.env`.
- **Messenger**: async transport is Doctrine (`MESSENGER_TRANSPORT_DSN=doctrine://default`); emails, chat and SMS messages are routed to `async`, so they are not sent unless a worker runs `messenger:consume`. `MAILER_DSN` is `null://null` by default.
- **Services**: autowired/autoconfigured from `src/` (`config/services.yaml`); routes are loaded from controller attributes.
- Default locale is `en`; translations go in `translations/`.
