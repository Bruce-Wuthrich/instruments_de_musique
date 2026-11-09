# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

"Instruments de musique" — a Symfony 7.4 web application (PHP >= 8.2) at the skeleton stage: `src/Controller`, `src/Entity` and `src/Repository` are still empty, so most features will be built with MakerBundle. The repo lives in WSL (Ubuntu 22.04); run PHP/Composer/Docker commands inside WSL, not from Windows.

## Commands

```bash
composer install                     # also runs cache:clear, assets:install, importmap:install
docker compose up -d                 # PostgreSQL 16 (+ Mailpit in dev via compose.override.yaml)
symfony serve -d                     # or: php -S localhost:8000 -t public

php bin/console make:entity          # scaffolding (also make:controller, make:form, make:crud, make:user…)
php bin/console make:migration
php bin/console doctrine:migrations:migrate
php bin/console debug:router

php bin/phpunit                                  # full test suite
php bin/phpunit tests/Path/To/SomeTest.php       # single file
php bin/phpunit --filter testMethodName          # single test
```

There is no linter or static-analysis tool installed. PHPUnit (v13) is configured to **fail on deprecations, notices and warnings** (`phpunit.dist.xml`), so deprecated Symfony/Doctrine APIs break the build.

## Architecture

- **Services**: everything under `src/` is autowired/autoconfigured (`config/services.yaml`); namespace `App\` → `src/`, `App\Tests\` → `tests/`.
- **Routing**: attribute-based (`#[Route]` on controllers), loaded via `config/routes.yaml`.
- **Persistence**: Doctrine ORM 3 with attribute mapping in `src/Entity`, underscore naming strategy, PostgreSQL identity columns. Schema changes go through migrations in `migrations/`. The test env uses a separate database suffixed `_test` (create it with `php bin/console --env=test doctrine:database:create`).
- **Frontend**: no Node/Webpack — AssetMapper + importmap (`importmap.php`), Stimulus controllers in `assets/controllers/` (auto-registered), Turbo enabled. Add JS packages with `php bin/console importmap:require <pkg>`. Templates in `templates/`, base layout `templates/base.html.twig`.
- **Async**: Messenger uses the Doctrine transport (`MESSENGER_TRANSPORT_DSN=doctrine://default`); emails and notifier chat/SMS messages are routed `async`, so they are only sent when a worker runs: `php bin/console messenger:consume async`. Failures go to the `failed` transport.
- **Security**: `security.yaml` still uses an in-memory placeholder provider with no authenticator and no access_control rules — replace it once a `User` entity exists (`make:user`, `make:security:form-login`).
- **Environment**: defaults in `.env`, per-env in `.env.dev` / `.env.test`; put machine-specific overrides (e.g. a different `DATABASE_URL`) in the uncommitted `.env.local`.

## Conventions

- `.editorconfig`: UTF-8, **LF line endings**, 4-space indent (2 for `compose*.yaml`). Editing from Windows must keep LF.
- Work on feature branches (e.g. `feature/01-...`); `main` is the main branch.
