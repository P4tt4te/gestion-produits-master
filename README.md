# GESTION PRODUITS

## Environnements
L'application est configurée pour fonctionner dans deux environnements distincts :

### Environnement de Production
- Base de données MySQL 8.0
- Accessible via https://www.domaine.fr (configuré localement avec Minikube)
- Configuration haute disponibilité avec 2 réplicas d'application (sur un nœud unique Minikube)

### Environnement de Développement
- Base de données PostgreSQL 15
- Accessible via https://dev.domaine.fr (configuré localement avec Minikube)
- Configuration de développement avec 1 réplica

## Prérequis
- Docker et Docker Compose pour le développement local
- Minikube pour le déploiement Kubernetes local (cluster à nœud unique)
- kubectl installé
- PHP 8.0 ou supérieur
- MySQL 8.0 (production) ou PostgreSQL 15 (développement)

## Installation Locale (Docker)
1. Cloner le dépôt
2. Lancer les conteneurs :
   ```bash
   docker compose up -d
   ```
3. Accéder aux applications :
   - Production (MySQL) : http://localhost:5000
   - Développement (PostgreSQL) : http://localhost:5001

## Déploiement avec Minikube
Voir [README.k8s.md](README.k8s.md) pour les instructions détaillées de déploiement avec Minikube.

Les applications seront accessibles via :
- Production : https://www.domaine.fr (après configuration du fichier hosts)
- Développement : https://dev.domaine.fr (après configuration du fichier hosts)

## Connexion à l'Application
- Login : `admin`
- Mot de passe : `password`

## Fonctionnalités
L'application permet de :
- Lister les produits
- Afficher la fiche produit en lecture seule
- Ajouter des produits
- Modifier les produits
- Supprimer les produits
- Pour chaque produit, il est possible d'ajouter autant de photos que nécessaire

## Structure des Fichiers
- `compose.yaml` : Configuration Docker pour le développement local
- `k8s/` : Configurations Kubernetes pour le déploiement avec Minikube
  - `dev/` : Configurations pour l'environnement de développement (PostgreSQL)
  - `prod/` : Configurations pour l'environnement de production (MySQL)
- `php/www/` : Code source de l'application
- `database/` : Scripts d'initialisation des bases de données