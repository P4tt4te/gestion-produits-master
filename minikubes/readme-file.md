# Guide de déploiement Kubernetes pour l'application "Gestion des Produits"

## Construction du cluster et déploiement de l'application

Suivez ces étapes pour déployer l'application sur un cluster Kubernetes avec Minikube.

### 1. Démarrer Minikube avec 3 nœuds

```bash
# Arrêter Minikube s'il est en cours d'exécution
minikube stop

# Démarrer un cluster à 3 nœuds
minikube start --nodes=3

# Vérifier que les 3 nœuds sont actifs
kubectl get nodes
```

### 2. Construire et charger les images Docker

```bash
# Construire l'image MySQL à partir du Dockerfile
docker build -t gestion-produits:mysql .

# Construire l'image PostgreSQL à partir du même Dockerfile
docker build -t gestion-produits:postgres .

# Charger les images dans Minikube
minikube image load gestion-produits:mysql
minikube image load gestion-produits:postgres

# Vérifier que les images sont bien chargées
minikube ssh "docker images | grep gestion-produits"
```

### 3. Déployer la version MySQL (Production)

```bash
# Créer l'espace de noms
kubectl apply -f namespace.yml

# Appliquer les secrets
kubectl apply -f mysql-secret.yml

# Créer les volumes persistants
kubectl apply -f storage.yml

# Déployer MySQL
kubectl apply -f mysql-deployment.yml

# Déployer l'application web MySQL
kubectl apply -f app-deployment.yml
```

### 4. Déployer la version PostgreSQL (Développement)

```bash
# Appliquer les secrets PostgreSQL
kubectl apply -f postgres-secret.yml

# Déployer PostgreSQL
kubectl apply -f postgres-deployment.yml

# Déployer l'application web PostgreSQL
kubectl apply -f app-postgres-deployment.yml
```

### 5. Accéder aux applications

```bash
# Accéder à la version MySQL (Production)
minikube service gestion-produits -n prod

# Accéder à la version PostgreSQL (Développement)
minikube service gestion-produits -n dev
```bash
# Accéder à la version MySQL (Production)
minikube service gestion-produits -n prod

# Accéder à la version PostgreSQL (Développement)
minikube service gestion-produits -n dev
```

### 6. Tester la disponibilité et la tolérance aux pannes

```bash
```bash
# Voir la distribution des pods sur les nœuds (Production)
kubectl get pods -n prod -o wide

# Voir la distribution des pods sur les nœuds (Développement)
kubectl get pods -n dev -o wide

# Vérifier l'état des services
kubectl get services --all-namespaces
```

### 7. Déboguer des problèmes potentiels

```bash
# Vérifier les logs d'un pod spécifique
kubectl logs <nom-du-pod> -n <namespace>

# Décrire un pod pour voir les détails et les erreurs
kubectl describe pod <nom-du-pod> -n <namespace>

# Si une image ne se charge pas (ErrImageNeverPull)
minikube ssh "docker images" # Vérifier les images disponibles
kubectl delete deployment <nom-du-déploiement> -n <namespace> # Supprimer le déploiement problématique
kubectl apply -f <fichier-de-déploiement>.yml # Recréer le déploiement
```

## Maintenance du cluster

### Arrêter le cluster

```bash
minikube stop
```

### Supprimer les ressources

```bash
# Supprimer les namespaces et toutes leurs ressources
kubectl delete namespace prod
kubectl delete namespace dev
```