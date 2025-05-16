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

### 2. Construire et charger l'image Docker

```bash
# Construire l'image à partir du Dockerfile
docker build -t gestion-produits:mysql .

# Charger l'image dans Minikube
minikube image load gestion-produits:mysql
```

### 3. Déployer sur Kubernetes

```bash
# Créer l'espace de noms
kubectl apply -f namespace.yml

# Appliquer les secrets
kubectl apply -f mysql-secret.yml

# Créer les volumes persistants
kubectl apply -f storage.yml

# Déployer MySQL
kubectl apply -f mysql-deployment.yml

# Déployer l'application web
kubectl apply -f app-deployment.yml
```

### 4. Accéder à l'application

```bash
# Créer un tunnel pour accéder à l'application
minikube service gestion-produits -n prod
```

### 5. Tester la disponibilité et la tolérance aux pannes

```bash
# Voir la distribution des pods sur les nœuds
kubectl get pods -n prod -o wide
```

## Maintenance du cluster

### Arrêter le cluster

```bash
minikube stop
```

### Supprimer les ressources

```bash
# Supprimer tous les déploiements
kubectl delete namespace prod
```