# Senior DevOps Engineer Tech Test Submission

This repository contains the solution for the Cartrawler DevOps technical test. The project sets up a CI/CD pipeline to build, test, and deploy a sample Node.js microservice to a Kubernetes cluster using Jenkins, Docker, Helm, and infrastructure automation tools.

The core technologies used are:

* **CI/CD**: Jenkins
* **Containerization**: Docker
* **Infrastructure as Code**: Ansible, Shell Scripts
* **Kubernetes Tooling**: Minikube, Helm, Kubectl

---

## 🚀 How to Run

### Prerequisites

Ensure the following are installed on your machine:

* Docker
* Ansible

### 1. Infrastructure Setup

Use the provided script to set up the infrastructure (includes Minikube, Helm, and Kubectl):

```bash
./scripts/infrastructure.sh setup
```

### 2. Build Docker Image

Build the Docker image for the application:

```bash
docker build -t ajaykumar4/cartrawler-devops-test-app:1.0.0 ./app
```

### 3. Push Docker Image

Push the image to Docker Hub:

```bash
docker push ajaykumar4/cartrawler-devops-test-app:1.0.0
```

### 4. Deploy via Helm Chart

Deploy the application using Helm:

```bash
./scripts/deploy.sh jenkins cartrawler-devops-test-app ./helm-chart ajaykumar4/cartrawler-devops-test-app 1.0.0
```

### 5. Test the Helm Deployment

Run Helm tests:

```bash
helm test cartrawler-devops-test-app -n jenkins
```

### 6. Verify Service is Running

Check that the service is accessible:

```bash
curl cartrawler.local
```

Expected Output:

```
Hello from Helm!
```

### 7. Destroy Infrastructure

To tear down the environment:

```bash
./scripts/infrastructure.sh destroy
```

---

### Optional: AWS Infrastructure Setup Using Terraform

If you'd like to provision the infrastructure on AWS using Terraform and deploy to an EKS cluster instead of local Minikube, follow the steps below.

#### Prerequisites

* AWS Account & CLI configured
* Terraform
* Kubectl
* Helm
* Docker
* A Jenkins instance with the Docker, Pipeline, and AWS plugins installed

#### 1. Provision AWS Infrastructure

The Terraform code will provision an EKS cluster and an ECR repository.

```bash
# Navigate to the terraform directory
cd terraform/

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

---

## 📁 Project Structure

* `app/`: Node.js application code
* `helm-chart/`: Helm chart definitions
* `scripts/`: Automation scripts for setup and deployment
* `docs/architecture`: Architecture and workflow documentation

---

## 📚 Documentation

See [docs/architecture](./docs/architecture) for architecture details.
