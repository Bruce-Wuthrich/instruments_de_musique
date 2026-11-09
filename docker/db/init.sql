-- Exécuté une seule fois, à la création du volume de la base.
-- Permet à l'utilisateur "app" de créer/utiliser les bases de test (app_test, app_test1…).
GRANT ALL PRIVILEGES ON `app\_test%`.* TO 'app'@'%';
FLUSH PRIVILEGES;
