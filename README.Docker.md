# Configuration Docker

## Environnements Disponibles

L'application est configurée avec deux environnements distincts dans Docker Compose :

### Production (MySQL)
- Base de données : MySQL 8.0
- Port : 5000
- Variables d'environnement :
  - DB_TYPE: mysql
  - DB_HOST: mysql
  - DB_NAME: gestion_produits
  - DB_USER: root
  - DB_PASSWORD: root

### Développement (PostgreSQL)
- Base de données : PostgreSQL 15
- Port : 5001
- Variables d'environnement :
  - DB_TYPE: pgsql
  - DB_HOST: postgres
  - DB_NAME: gestion_produits
  - DB_USER: postgres
  - DB_PASSWORD: postgres

## Démarrage des Conteneurs

Pour lancer tous les services :
```bash
docker compose up -d
```

Pour lancer uniquement l'environnement de production :
```bash
docker compose up -d app-prod mysql
```

Pour lancer uniquement l'environnement de développement :
```bash
docker compose up -d app-dev postgres
```

## Accès aux Applications

- Production : http://localhost:5000
- Développement : http://localhost:5001

## Volumes Persistants

- `mysql_data` : Données MySQL (production)
- `postgres_data` : Données PostgreSQL (développement)
- `./php/www` : Code source de l'application
- `./database/gestion_produits.sql` : Script d'initialisation MySQL
- `./database/gestion_produits_pg.sql` : Script d'initialisation PostgreSQL

## Construction de l'Image

Pour construire l'image manuellement :
```bash
docker build -t gestion-produits:latest .
```

Pour une architecture différente (ex: déploiement cloud) :
```bash
docker build --platform=linux/amd64 -t gestion-produits:latest .
```

## Logs et Debugging

Pour voir les logs d'un service spécifique :
```bash
# Logs de l'application production
docker compose logs app-prod

# Logs de l'application développement
docker compose logs app-dev

# Logs des bases de données
docker compose logs mysql
docker compose logs postgres
```

## Extensions PHP
Les extensions PHP nécessaires sont configurées dans le Dockerfile. Pour ajouter de nouvelles extensions, modifiez le Dockerfile selon les besoins.

### PHP extensions
If your application requires specific PHP extensions to run, they will need to be added to the Dockerfile. Follow the instructions and example in the Dockerfile to add them.

### Deploying your application to the cloud

First, build your image, e.g.: `docker build -t myapp .`.
If your cloud uses a different CPU architecture than your development
machine (e.g., you are on a Mac M1 and your cloud provider is amd64),
you'll want to build the image for that platform, e.g.:
`docker build --platform=linux/amd64 -t myapp .`.

Then, push it to your registry, e.g. `docker push myregistry.com/myapp`.

Consult Docker's [getting started](https://docs.docker.com/go/get-started-sharing/)
docs for more detail on building and pushing.