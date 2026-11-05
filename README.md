# SU-DevOps â€” DevOps Mini Projects

**Student:** Arman
**PRN:** 2125UMLM1097
**GitHub:** [Arman16223](https://github.com/Arman16223)
**Repository:** [SU-DevOps](https://github.com/Arman16223/SU-DevOps)

This repository contains academic mini-project material and implementation exercises covering software delivery, Agile planning, containerization, CI/CD, Kubernetes, and AWS infrastructure automation.

## Repository layout

```text
SU-DevOps/
â”œâ”€â”€ app/                         # Flask library application
â”œâ”€â”€ database/                    # Application data/service layer
â”œâ”€â”€ tests/                       # Automated application tests
â”œâ”€â”€ k8s/                         # Kubernetes deployment and service
â”œâ”€â”€ Unit-4/
â”‚   â”œâ”€â”€ docs/                    # Architecture and lab walkthrough
â”‚   â”œâ”€â”€ library-ansible/         # Ansible inventory template and roles
â”‚   â”œâ”€â”€ library-app/             # Unit 4 containerized Flask service
â”‚   â”œâ”€â”€ library-terraform/       # AWS infrastructure as code
â”‚   â””â”€â”€ scripts/                 # Setup, deployment and verification scripts
â”œâ”€â”€ Jenkinsfile                  # Jenkins CI/CD pipeline
â”œâ”€â”€ Dockerfile
â”œâ”€â”€ requirements.txt
â”œâ”€â”€ Arman_2125UMLM1097_DevOps_Unit1_MiniProject.docx
â””â”€â”€ Arman_2125UMLM1097_DevOps_Unit2_MiniProject.docx
```

## Local application setup

Requirements: Python 3.11+, Git, and pip.

```bash
git clone https://github.com/Arman16223/SU-DevOps.git
cd SU-DevOps

python -m venv .venv
# Linux/macOS:
source .venv/bin/activate
# Windows PowerShell:
# .venv\Scripts\Activate.ps1

pip install -r requirements.txt
python run.py
```

Run tests and lint checks:

```bash
pytest -q
flake8 app database tests run.py
```

## Docker

```bash
docker build -t library-management-platform:local .
docker run --rm -p 5000:5000 library-management-platform:local
```

## Jenkins CI/CD

The pipeline expects a Jenkins username/password credential with ID `dockerhub-creds`. The username is used as the Docker Hub namespace, so no personal Docker Hub account name is hard-coded in the repository.

The Jenkins agent must have Python, Docker, and (for deployment) `kubectl` configured. The Kubernetes context and target cluster must already be configured on the agent.

## Unit 4 â€” AWS infrastructure automation

Read `Unit-4/README.md` before provisioning resources. AWS resources can incur charges.

Important setup notes:

1. Configure AWS credentials using an approved local profile or environment-based authentication; never commit credentials.
2. Set `allowed_ssh_cidr` to your own public IP in CIDR notation (usually `/32`) when running Terraform.
3. Copy `Unit-4/library-ansible/inventory.ini.example` to `inventory.ini` and set the EC2 address. The real `inventory.ini` is ignored by Git.
4. Keep SSH private keys outside the repository.
5. Review `terraform plan` before applying infrastructure changes.

## Repository and submission safety

Follow the course submission instructions:

- Do not force-push.
- Do not commit or upload submission ZIP files.
- Do not commit `.venv`, `venv`, `.venv-ci`, credentials, API tokens, private keys, or Terraform state.
- Do not commit real `inventory.ini`, `terraform.tfvars`, generated plans, local databases, or cloud credentials.
- Review changes before pushing:

```bash
git status --short
git diff --stat
git diff --check
```

If a credential has ever been exposed, revoke or rotate it. Removing it from the latest version does not invalidate an exposed secret.
