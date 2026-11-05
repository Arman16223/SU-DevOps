# SU-DevOps — Enterprise DevOps Mini Projects

| Field | Detail |
|---|---|
| **Student Name** | Arman |
| **PRN** | 2125UMLM1097 |
| **GitHub Username** | [Arman16223](https://github.com/Arman16223) |
| **Repository URL** | [https://github.com/Arman16223/SU-DevOps](https://github.com/Arman16223/SU-DevOps) |
| **Default Branch** | `main` |

---

## 📌 Executive Summary

This repository consolidates the academic DevOps mini-projects and practical coursework covering modern end-to-end software delivery practices:

1. **Unit 1 – Product Engineering & Design Thinking**: Enterprise Smart Library Management Platform conceptualization, REST API design, domain data modeling, and unit testing.
2. **Unit 2 – Agile & Scrum Management**: Product vision, user personas, product backlog, user stories, Sprint planning, velocity metrics, and release roadmap.
3. **Unit 3 – CI/CD, Containerization & Kubernetes**: Docker containerization, Jenkins Declarative pipeline automation (build, test, lint, Docker image push), and Kubernetes declarative deployment and service configuration.
4. **Unit 4 – Cloud Infrastructure Automation**: Infrastructure as Code (IaC) with HashiCorp Terraform on AWS (dedicated VPC, public subnet, security group, EC2 instance, encrypted & versioned S3 bucket), automated configuration management with Ansible (Docker, Nginx reverse proxy, Flask service), and automated S3 database backup routines.

---

## 🏗️ Repository Layout

```text
SU-DevOps/
├── app/                                            # Core Flask Library Application
│   ├── models/                                     # Data models (Book, User)
│   ├── routes/                                     # API endpoints (/api/books, /api/users, /api/borrow)
│   ├── services/                                   # Business logic layer (LibraryService)
│   ├── templates/                                  # Web frontend template (index.html)
│   └── __init__.py                                 # Application factory
├── database/                                       # In-memory / mock database engine
│   └── db.py
├── tests/                                          # Automated Pytest suite (48 test cases)
│   ├── test_api_endpoints.py
│   ├── test_book_service.py
│   ├── test_borrow_return.py
│   ├── test_models.py
│   └── test_user_service.py
├── k8s/                                            # Kubernetes manifests
│   ├── deployment.yaml                             # Deployment manifest with resource requests/limits
│   └── service.yaml                                # NodePort service manifest (Port 5000)
├── Unit-4/                                         # Cloud Infrastructure Automation
│   ├── docs/                                       # Architectural specifications & execution runbook
│   │   ├── ARCHITECTURE.md
│   │   └── LAB_MANUAL_WALKTHROUGH.md
│   ├── library-ansible/                            # Ansible playbooks and modular roles
│   │   ├── ansible.cfg                             # Ansible configuration
│   │   ├── inventory.ini.example                   # Inventory template with placeholders
│   │   ├── site.yml                                # Master playbook
│   │   └── roles/                                  # Roles: common, docker, nginx, library_app
│   ├── library-app/                                # Unit 4 containerized Flask service
│   │   ├── app.py
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   ├── library-terraform/                          # AWS Infrastructure as Code
│   │   ├── backend.tf                              # Remote state configuration template
│   │   ├── main.tf                                 # AWS VPC, Subnet, IGW, Route Table, SG, EC2, S3
│   │   ├── outputs.tf                              # Terraform outputs (IP, DNS, S3 Bucket)
│   │   ├── providers.tf                            # AWS Provider specification
│   │   ├── terraform.tfvars.example                # Example variables file
│   │   └── variables.tf                            # Input variables definition
│   ├── scripts/                                    # Automation and test scripts
│   │   ├── backup_to_s3.sh                         # SQLite to Amazon S3 backup routine
│   │   ├── deploy_all.sh                           # End-to-end Terraform + Ansible orchestrator
│   │   ├── setup_workstation.sh                    # Workstation baseline installation
│   │   ├── test_api.py                             # API endpoint verification script
│   │   ├── test_endpoints.sh                       # cURL endpoint integration test
│   │   └── verify_backup.sh                        # S3 backup validation script
│   ├── project_report.md                           # Unit 4 academic project report
│   └── README.md                                   # Unit 4 documentation
├── Dockerfile                                      # Root Docker container image definition
├── Jenkinsfile                                     # Declarative CI/CD pipeline definition
├── requirements.txt                                # Python application and test dependencies
├── run.py                                          # Application entrypoint
├── Arman_2125UMLM1097_DevOps_Unit1_MiniProject.docx# Unit 1 project report
├── Arman_2125UMLM1097_DevOps_Unit2_MiniProject.docx# Unit 2 Agile project report
├── .dockerignore                                   # Docker build exclusion rules
└── .gitignore                                      # Git version control ignore rules
```

---

## 🚀 Quick Start: Local Application Setup

### Prerequisites
- Python 3.11+
- Git
- pip

### 1. Clone the Repository
```bash
git clone https://github.com/Arman16223/SU-DevOps.git
cd SU-DevOps
```

### 2. Create and Activate Virtual Environment
On Linux / macOS:
```bash
python3 -m venv .venv
source .venv/bin/activate
```

On Windows (PowerShell):
```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Run the Application
```bash
python run.py
```
The application will start on `http://127.0.0.1:5000`.

---

## 🧪 Testing and Code Quality

### Automated Unit Testing
Run the 48-case Pytest test suite:
```bash
pytest -v
```

### Code Quality and Linting
Run Flake8 to ensure PEP 8 compliance:
```bash
flake8 app database tests run.py
```

---

## 🐳 Docker Containerization

### Build the Image
```bash
docker build -t library-management-platform:latest .
```

### Run the Container
```bash
docker run -d --name library-app -p 5000:5000 library-management-platform:latest
```

### Verify Container Health
```bash
curl http://localhost:5000/api/health
```

---

## ☸️ Kubernetes Deployment

Deploy the containerized application onto a Kubernetes cluster (e.g., Minikube, EKS):

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Check resource rollout:
```bash
kubectl get deployments,pods,services
kubectl rollout status deployment/smart-library
```

---

## 🔄 Jenkins CI/CD Pipeline

The `Jenkinsfile` implements an enterprise declarative pipeline with automated stages:

1. **Checkout**: Checks out source code from Git SCM.
2. **Install Dependencies**: Creates an isolated CI virtual environment and installs pinned dependencies.
3. **Code Quality**: Enforces code style and catches syntax bugs using `flake8`.
4. **Run Tests**: Executes the automated `pytest` test suite.
5. **Build & Push Docker Image**: Packages the application into a container image tagged with `${BUILD_NUMBER}` and `latest`, authenticating with Docker Hub via Jenkins credentials (`dockerhub-creds`).
6. **Deploy to Kubernetes**: Updates the Kubernetes deployment image with zero-downtime rolling update.
7. **Verify Deployment**: Validates pod, deployment, and service health.

---

## ☁️ Unit 4: AWS Infrastructure Automation

Unit 4 automates cloud infrastructure and configuration:

- **Terraform (`Unit-4/library-terraform/`)**:
  - Provisions a custom AWS VPC (`10.0.0.0/16`), public subnet (`10.0.1.0/24`), Internet Gateway, Route Table, Security Group (ports 22, 80, 5000), EC2 Ubuntu instance, and encrypted/versioned S3 bucket for database backups.
- **Ansible (`Unit-4/library-ansible/`)**:
  - Configures the EC2 instance via SSH: installs Docker, sets up Nginx reverse proxy, builds/runs the application container, and mounts persistent database volumes.
- **Backup & Recovery (`Unit-4/scripts/`)**:
  - `backup_to_s3.sh` creates timestamped SQLite backups and uploads them to the provisioned encrypted S3 bucket.

> **Security Note**: Never commit real AWS credentials, SSH private keys, `inventory.ini`, or `.tfstate` files. Use `inventory.ini.example` and `terraform.tfvars.example` as templates.

---

## 🔒 Security and Repository Standards

- **Zero Credentials Policy**: No passwords, tokens, API keys, or private keys are tracked.
- **Exclusion Rules**: `.gitignore` and `.dockerignore` protect sensitive files, virtual environments (`.venv/`, `.venv-ci/`), Terraform state files (`*.tfstate`), and local SQLite databases.
- **Template Configurations**: Configuration files provide clear placeholders (e.g. `inventory.ini.example`, `terraform.tfvars.example`).
