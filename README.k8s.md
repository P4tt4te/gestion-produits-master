# Running the Application with Minikube

This guide explains how to run the application locally using Minikube with both development (PostgreSQL) and production (MySQL) environments.

## Prerequisites

- Minikube installed
- kubectl installed
- Docker installed
- Windows PowerShell or Command Prompt

## Environment Setup

The application is configured with two environments:

### Development Environment
- Uses PostgreSQL database
- Single app instance
- Accessible via dev.local
- Development-specific configurations

### Production Environment
- Uses MySQL database
- Two app instances (replicas)
- Accessible via prod.local
- Production-specific configurations

## Setup Steps

### 1. Start Minikube

```bash
minikube start
```

### 2. Enable Required Addons

Enable the Ingress addon:

```bash
minikube addons enable ingress
```

### 3. Configure Docker Environment

To build and use local images with Minikube, we need to configure Docker to use Minikube's Docker daemon:

```bash
# Configure your terminal to use Minikube's Docker daemon
minikube docker-env | Invoke-Expression
```

Note: You'll need to run this command in each new terminal window where you want to work with Docker images in Minikube.

### 4. Build Docker Image

```bash
# Build the image directly in Minikube's environment
docker build -t gestion-produits:latest .
```

Note: When building images this way, they will be automatically available to Minikube without needing to push to a registry.

### 5. Update Deployment Files

Make sure your deployment files (k8s/dev/app-deployment.yaml and k8s/prod/app-deployment.yaml) use the correct image name:

```yaml
image: gestion-produits:latest
imagePullPolicy: Never  # Important: This tells Kubernetes to always use the local image
```

### 6. Deploy the Application

```bash
# Create namespaces
kubectl apply -f k8s/namespaces.yaml

# Deploy development environment
kubectl apply -f k8s/dev/

# Deploy production environment
kubectl apply -f k8s/prod/

# Apply ingress configuration
kubectl apply -f k8s/ingress.yaml
```

### 7. Start Minikube Tunnel

Open a new terminal and run:

```bash
minikube tunnel
```

Keep this terminal open as it's required for ingress access.

### 8. Verify Deployment

Check if all pods are running in both environments:

```bash
# Check development environment
kubectl get pods -n dev

# Check production environment
kubectl get pods -n prod
```

You should see output similar to:
```
# Development
NAME                        READY   STATUS    RESTARTS   AGE
app-xxxxxxxxxx-xxxxx        1/1     Running   0          XXs
postgres-xxxxxxxxxx-xxxxx   1/1     Running   0          XXs

# Production
NAME                        READY   STATUS    RESTARTS   AGE
app-xxxxxxxxxx-xxxxx        1/1     Running   0          XXs
app-xxxxxxxxxx-yyyyy        1/1     Running   0          XXs
mysql-xxxxxxxxxx-xxxxx      1/1     Running   0          XXs
```

## Accessing the Application

The application is configured with the following ingress hosts:
- Development environment: http://dev.local
- Production environment: http://prod.local

To access these URLs, add the following entries to your hosts file (`C:\Windows\System32\drivers\etc\hosts`):

```
127.0.0.1 dev.local
127.0.0.1 prod.local
```

## Environment-Specific Configurations

### Development Environment
- Database: PostgreSQL
- Host: postgres:5432
- Single app instance
- Development-specific environment variables

### Production Environment
- Database: MySQL
- Host: mysql:3306
- Two app instances for high availability
- Production-specific environment variables

## Troubleshooting

### Image Pull Issues
If you encounter `ImagePullBackOff` errors:
1. Make sure you've configured the terminal to use Minikube's Docker daemon (`minikube docker-env | Invoke-Expression`)
2. Verify that the image was built successfully (`docker images`)
3. Ensure the deployment YAML files use `imagePullPolicy: Never`
4. Try rebuilding the image and redeploying the pods

### Docker Environment Issues
If you have problems with Docker:
1. Each new terminal needs to be configured with `minikube docker-env | Invoke-Expression`
2. If you restart Minikube, you'll need to:
   - Reconfigure the Docker environment
   - Rebuild the images
   - Redeploy the pods

### Database Connection Issues
- For development (PostgreSQL):
  1. Check if the postgres pod is running
  2. Verify the database credentials in the app deployment
  3. Check postgres logs: `kubectl logs -n dev deployment/postgres`

- For production (MySQL):
  1. Check if the mysql pod is running
  2. Verify the database credentials in the app deployment
  3. Check mysql logs: `kubectl logs -n prod deployment/mysql`

### Access Issues
If you can't access the application:
1. Ensure the Minikube tunnel is running
2. Verify that the ingress controller is working
3. Check if the hosts file is properly configured
4. Verify the correct domain is being used for each environment

## Cleanup

To clean up the resources:

```bash
# Delete all resources in both namespaces
kubectl delete -f k8s/dev/
kubectl delete -f k8s/prod/

# Stop Minikube
minikube stop
``` 