# Architecture & Design Decisions

This document outlines the architecture and design choices for the CI/CD pipeline and infrastructure setup.

---

## 📊 Architecture Overview

### 1. CI/CD Pipeline Flow

The CI/CD pipeline, orchestrated by **Jenkins**, follows this end-to-end flow:

#### Simplified Flow
```
GitHub → Jenkins → Docker (build) → ECR (push) → Helm (deploy) → EKS/Minikube (run) → Slack (notify)
```

#### Detailed Expanded Flow
```
GitHub → Jenkins (CI: Checkout → Lint/Test → Build Docker ) → Docker Registry (Docker Hub / ECR) → Jenkins (CD: Deploy via Helm) → Kubernetes (EKS / Minikube) → Slack (notify)
```

### 2. Core Components

| Layer                  | Tool/Service                        | Purpose                                              |
| ---------------------- | ----------------------------------- | ---------------------------------------------------- |
| CI/CD Orchestration    | Jenkins                             | Automates the full pipeline (build → deploy).        |
| Version Control        | GitHub                              | Source code management.                              |
| Build & Packaging      | Docker                              | Containerizes the Node.js app.                       |
| Container Registry     | Docker Hub / Amazon ECR             | Stores Docker images securely.                       |
| Infrastructure as Code | Terraform, Ansible, Shell           | Provisions AWS infrastructure and automates setup.   |
| Kubernetes             | Amazon EKS (prod), Minikube (local) | Orchestrates containers in cloud/local environments. |
| Deployment Tool        | Helm                                | Manages Kubernetes manifests and deployments.        |
| Monitoring & Feedback  | Slack (via Jenkins plugin)          | Notifies team of pipeline results.                   |

---

## 3. Deployment Environment Flow

### 🔧 Local Setup

* Provisioned with shell scripts (`infrastructure.sh`) and Minikube.
* Application built, deployed, and tested locally using Helm.

### ☁️ Cloud Setup (Optional)

* **Terraform** provisions:

  * Amazon **EKS** cluster
  * **ECR** repository (optional)
  * IAM roles with scoped permissions
* Application deployed to `staging` and `production` environments via Helm.

---

## 4. CI/CD Flow (Detailed)

The CI/CD process is divided into two coordinated pipelines — **CI** and **CD** — for modular, scalable deployment management:

### Continuous Integration (CI) Pipeline

1. **Checkout**: Jenkins checks out source code from GitHub.
2. **Lint & Quality Check**:

   * Lint Kubernetes YAML manifests with tools like Kubeconform and YAMLLint.
   * Lint Helm charts to catch configuration issues early.
3. **Unit Tests**: Run Node.js unit tests in the `app/` directory.
4. **Build Docker Image**:

   * Build a Docker image tagged with the Jenkins build number.
   * Push the image to a container registry (currently Docker Hub, with optional Amazon ECR support).
5. **Trigger Deployment Pipeline**:

   * On success, trigger the CD pipeline (`app/cd-job`) with parameters: app name, version (build number), and target environment (`dev` by default).
6. **Notifications**: Send Slack alerts for pipeline success, failure, or abortion.

### Continuous Deployment (CD) Pipeline

1. **Parameters**: Receives deployment parameters (`APP_NAME`, `APP_VERSION`, `ENV`).
2. **EKS Login**: Authenticate to the Amazon EKS cluster using securely stored AWS credentials.
3. **Deploy with Helm**: Install or upgrade Helm charts in the Kubernetes namespace corresponding to the target environment (`dev`, `staging`, `production`).
4. **Error Handling**: On deployment failure, perform Helm rollback to minimize downtime.
5. **Manual Promotion**: Deployment to staging is automatic; production deploys require manual approval.
6. **Notifications**: Slack notifications provide real-time feedback on deployment status.

---

## 5. Security & Access Control

* Jenkins IAM role is scoped with minimal necessary permissions (ECR push, EKS read).
* For testing, IAM role maps to `system:masters`. In production, a dedicated `ci-deployer` RBAC role should limit permissions per namespace.

---

## 6. Long-Term Maintenance & Improvements

| Area                  | Suggested Improvement                                                                                                                    |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Pipeline Reuse**    | Use Jenkins Shared Libraries for common build and deploy logic to reduce duplication.                                                    |
| **Deployment Model**  | Adopt GitOps approaches with ArgoCD or Flux for improved deployment traceability.                                                        |
| **Security**          | Integrate vulnerability scanning tools like Trivy or Snyk for container and code scanning.                                               |
| **Secret Management** | Integrate HashiCorp Vault for centralized, dynamic secret storage and management, reducing secret sprawl and enhancing security posture. |
| **Cost Optimization** | Use Karpenter or Cluster Autoscaler with Spot instances to optimize cluster costs.                                                       |

---