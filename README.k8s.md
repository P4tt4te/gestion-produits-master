# Déploiement avec Minikube

Ce guide explique comment déployer l'application localement avec Minikube, en configurant deux environnements : production (MySQL) et développement (PostgreSQL).

## Prérequis

- Minikube installé
- kubectl installé
- Docker installé
- Windows PowerShell ou Command Prompt

## Configuration Initiale

### 1. Démarrer Minikube

```bash
# Démarrer Minikube avec suffisamment de ressources
minikube start --cpus 2 --memory 4096
```

### 2. Activer les Addons Nécessaires

```bash
# Activer l'addon Ingress
minikube addons enable ingress

# Activer l'addon Storage Provisioner (pour les volumes persistants)
minikube addons enable storage-provisioner
```

### 3. Configurer Docker pour Utiliser le Daemon de Minikube

```bash
# Configurer l'environnement Docker pour utiliser Minikube
minikube docker-env | Invoke-Expression
```

Note : Cette commande doit être exécutée dans chaque nouveau terminal où vous souhaitez travailler avec les images Docker dans Minikube.

## Construction de l'Image

```bash
# Construire l'image dans l'environnement Minikube
docker build -t gestion-produits:latest .
```

## Déploiement

### 1. Créer les Namespaces

```bash
kubectl apply -f k8s/namespaces.yaml
```

### 2. Créer les Secrets

```bash
kubectl apply -f k8s/secrets.yaml
```

### 3. Déployer l'Environnement de Production

```bash
kubectl apply -f k8s/prod/
```

### 4. Déployer l'Environnement de Développement

```bash
kubectl apply -f k8s/dev/
```

### 5. Configurer l'Ingress

```bash
kubectl apply -f k8s/ingress.yaml
```

### 6. Démarrer le Tunnel Minikube

Dans un nouveau terminal, exécutez :
```bash
minikube tunnel
```
Gardez ce terminal ouvert pour maintenir l'accès aux services via Ingress.

## Accès aux Applications

### Configuration des Hôtes

Ajoutez les entrées suivantes à votre fichier hosts (`C:\Windows\System32\drivers\etc\hosts`) :
```
127.0.0.1 dev.domaine.fr
127.0.0.1 www.domaine.fr
```

### URLs d'Accès
- Production : https://www.domaine.fr
- Développement : https://dev.domaine.fr

## Vérification du Déploiement

### Vérifier les Pods

```bash
# Vérifier les pods de production
kubectl get pods -n prod

# Vérifier les pods de développement
kubectl get pods -n dev
```

### Vérifier les Services

```bash
# Vérifier les services de production
kubectl get svc -n prod

# Vérifier les services de développement
kubectl get svc -n dev
```

## Surveillance et Debugging

### Logs des Applications

```bash
# Logs de production
kubectl logs -n prod -l app=app-prod

# Logs de développement
kubectl logs -n dev -l app=app-dev
```

### Logs des Bases de Données

```bash
# Logs MySQL (production)
kubectl logs -n prod -l app=mysql

# Logs PostgreSQL (développement)
kubectl logs -n dev -l app=postgres
```

### Accès Direct aux Bases de Données

```bash
# Accès à MySQL (production)
kubectl port-forward -n prod svc/mysql 3306:3306

# Accès à PostgreSQL (développement)
kubectl port-forward -n dev svc/postgres 5432:5432
```

## Problèmes Courants

### ImagePullBackOff
Si vous rencontrez des erreurs ImagePullBackOff :
1. Vérifiez que vous avez bien configuré Docker pour utiliser Minikube (`minikube docker-env | Invoke-Expression`)
2. Reconstruisez l'image : `docker build -t gestion-produits:latest .`
3. Vérifiez que `imagePullPolicy: Never` est défini dans les déploiements

### Problèmes de Connexion
Si vous ne pouvez pas accéder aux applications :
1. Vérifiez que le tunnel Minikube est actif
2. Vérifiez les entrées dans le fichier hosts
3. Vérifiez l'état de l'Ingress : `kubectl get ingress -A`

## Nettoyage

Pour arrêter et nettoyer l'environnement :

```bash
# Supprimer les déploiements
kubectl delete -f k8s/prod/
kubectl delete -f k8s/dev/
kubectl delete -f k8s/ingress.yaml
kubectl delete -f k8s/secrets.yaml

# Arrêter le tunnel Minikube (dans le terminal dédié)
Ctrl+C

# Arrêter Minikube
minikube stop

# Optionnel : Supprimer le cluster Minikube
minikube delete
``` 