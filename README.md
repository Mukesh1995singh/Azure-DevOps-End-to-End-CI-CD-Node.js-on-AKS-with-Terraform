Azure DevOps End-to-End CI/CD Project — Node.js on AKS

1. Project Overview

This project demonstrates a complete production-style DevOps implementation for deploying a containerized Node.js application on Azure Kubernetes Service (AKS).

The project covers infrastructure provisioning using Terraform, containerization using Docker, image management using Azure Container Registry (ACR), CI/CD using Azure DevOps Pipelines, Kubernetes deployment, NGINX Ingress, HPA, PostgreSQL StatefulSet, Azure Key Vault, Secrets Store CSI Driver, Workload Identity, SonarQube, Mend, and Trivy.

The project uses two AKS clusters:

Non-Production AKS Cluster — hosts DEV and TEST environments using separate Kubernetes namespaces.
Production AKS Cluster — dedicated to the PROD environment.


2. Project Objectives

The main objectives are:

Build a Node.js application.
Containerize the application using Docker.
Store Docker images in Azure Container Registry.
Provision Azure infrastructure using Terraform.
Deploy the application to AKS.
Use Kubernetes namespaces for environment isolation.
Implement Kubernetes RBAC using Role and RoleBinding.
Install NGINX Ingress Controller using Helm.
Expose the application through Kubernetes Ingress.
Implement Horizontal Pod Autoscaler (HPA).
Deploy PostgreSQL using Kubernetes StatefulSet for learning purposes.
Use PersistentVolume and PersistentVolumeClaim for PostgreSQL storage.
Store database credentials in Azure Key Vault.
Retrieve secrets using Secrets Store CSI Driver.
Use Microsoft Entra Workload Identity for secure access to Key Vault.
Implement CI using Azure DevOps.
Perform code-quality analysis using SonarQube.
Perform dependency security scanning using Mend.
Perform container-image vulnerability scanning using Trivy.
Push versioned Docker images to ACR.
Implement CD from DEV → TEST → PROD.
Use production approval before PROD deployment.
Implement rollback and deployment verification.
Implement monitoring and troubleshooting.


3. High-Level Architecture
                         Developer
                             v
                       Azure Repos
                             |
                             v
                    Azure DevOps CI
                             |
              +--------------+--------------+
              |              |              |
              v              v              v
         Unit Tests      SonarQube         Mend
                                             |
                                             v
                                       Docker Build
                                             |
                                             v
                                           Trivy
                                             |
                                             v
                              Azure Container Registry
                                             |
                                             v
                                   Azure DevOps CD
                                             |
                       +---------------------+---------------------+
                       |                                           |
                       v                                           v
                AKS DEV/TEST                                  AKS PROD
                       |                                           |
                  +----+----+                                      |
                  |         |                                      |
                 DEV       TEST                                   PROD
                  |         |                                      |
                  +----+----+                                      |
                       |                                           |
                       v                                           v
                 NGINX Ingress                              NGINX Ingress
                       |                                           |
                       v                                           v
                  Node.js                                     Node.js
                  Deployment                                   Deployment
                       |                                           |
                       v                                           v
                     HPA                                         HPA
                       |                                           |
                       v                                           v
                 Node.js Pods                               Node.js Pods
                       |                                           |
                       +------------------+------------------------+
                                          |
                                          v
                                   PostgreSQL
                                   StatefulSet
                                          |
                                          v
                                      PVC / Disk


Azure Key Vault
      |
      v
Secrets Store CSI Driver
      |
      v
Workload Identity
      |
      v
Node.js Pod


4. Environment Strategy

The project uses two AKS clusters.

4.1 Non-Production AKS

The non-production cluster contains:

AKS-NONPROD
|
+-- dev namespace
|
+-- test namespace
|
+-- monitoring namespace

DEV and TEST are isolated using Kubernetes namespaces.

4.2 Production AKS

Production has a dedicated AKS cluster:

AKS-PROD
|
+-- prod namespace
|
+-- monitoring namespace

This provides stronger production isolation.


5. Technology Stack
Category	Technology
Application	Node.js
Source Control	Git
Repository	Azure Repos
CI/CD	Azure DevOps
Containerization	Docker
Container Registry	Azure Container Registry
Kubernetes	Azure Kubernetes Service
Infrastructure as Code	Terraform
Kubernetes Package Management	Helm
Ingress	NGINX Ingress Controller
Autoscaling	Kubernetes HPA
Database	PostgreSQL
Database Workload	StatefulSet
Storage	PersistentVolume / PersistentVolumeClaim
Secret Management	Azure Key Vault
Secret Integration	Secrets Store CSI Driver
Identity	Microsoft Entra Workload Identity
Code Quality	SonarQube
Dependency Security	Mend
Container Security	Trivy
Monitoring	Prometheus + Grafana
Azure CLI	Azure CLI
Kubernetes CLI	kubectl

# 1. Log in and set your subscription
az login
az account set --subscription "8f0127bd-4efc-47b7-830f-e9d98693dd57"

# 2. Create the resource group
az group create --name "rg-tfstate" --location "Central India"

# 3. Create the storage account
az storage account create --name "sttfstateapp123" --resource-group "rg-tfstate" --location "Central India" --sku Standard_LRS

# 4. Create the blob container (replace 'tfstate' with your backend container name)
az storage container create --name "tfstate" --account-name "sttfstateapp123"


# 1. Fetch credentials into your local kubeconfig
az aks get-credentials --resource-group app-grp-dev --name aks-nodejs-dev

# 2. Verify worker node readiness
kubectl get nodes

# 3. Install NGINX Ingress Controller via Helm CLI
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-basic --create-namespace


terraform init -upgrade
terraform validate
terraform plan -out=dev.tfplan
terraform apply "dev.tfplan"
Remove-Item -Recurse -Force .terraform, .terraform.lock.hcl, dev.tfplan
terraform fmt -recursive

#Get Cluster Credentials
az aks get-credentials --resource-group app-grp-dev --name aks-nodejs-dev
kubectl get nodes

#Authenticate with ACR
az acr login --name AcrNodeDemodev01

#Build & Push Docker Image
docker build -t AcrNodeDemodev01.azurecr.io/nodejs-app:v1 .
docker push AcrNodeDemodev01.azurecr.io/nodejs-app:v1
ecf5045ba150c50cb67c4f9955ca9ec4765da48c