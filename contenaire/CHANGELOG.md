# Changelog

## v2.0 (2025-10-17)
### Fixed
- Correction problème SSL avec MySQL 8.0
- Ajout de l'option `--ssl=0` dans le script d'entrypoint
- Remplacement de `mariadb-connector-c` par `mariadb-client`

### Changed
- Amélioration du healthcheck
- Optimisation du temps de démarrage

## v1.0 (2025-10-04)
### Initial Release
- Architecture 3-tier WordPress
- Backend PHP-FPM
- Frontend Nginx
- Integration Redis
