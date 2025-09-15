# Terraform Labs

Hands-on Terraform practice covering variables, outputs, validation, state management, and Azure resource deployment.  
The goal is to build strong **Infrastructure as Code (IaC)** foundations while progressively learning how to provision resources in Azure.

---

## Repository Structure

## 📂 Repository Structure

- **Lab1-Intro/** – Terraform fundamentals  
  - `main.tf` → Core configuration  
  - `variables.tf` → Input variables  
  - `outputs.tf` → Output values  
  - `terraform.tfvars` → Variable assignments  
  - `validation.tf` → Input validation rules  
  - `versions.tf` → Provider/version constraints  

- **Lab2-Azure/** – First Azure integration  

- **Lab3-Azure/** – Additional Azure resources  

- **Lab4-Azure-KeyVault-Logs/** – Azure Key Vault + logging  

- **Lab5-Azure-Networking/** – Networking  

- **Lab6-Azure-VM/** – VM provisioning  

- **InputVariables/** – Focused lab on input variables and `.tfvars`  

- **.terraform/** – Terraform internal files (ignored in Git)  


---

## Labs Overview

### Lab1 — Intro to Terraform
- Practiced variables, outputs, validation rules, and version constraints.
- Managed `terraform.tfstate` and tested multiple `.tfvars` files.

### Lab2 — Azure Basics
- First connection to Azure provider.
- Deployed basic resources to understand authentication and setup.

### Lab3 — Azure Resources
- Expanded Azure deployments with more services.
- Reinforced modular code and reusable blocks.

### Lab4 — Azure Key Vault + Logs
- Created and managed secrets in Azure Key Vault.
- Implemented logging and diagnostics.

### Lab5 — Azure VM + Networking
- Provisioned virtual machines and configured network settings.
- Practiced security groups and connectivity.

### Lab6 — Azure VM
- Deep dive into VM lifecycle.
- Deployed and validated compute resources.

### InputVariables — Variables in Practice
- Worked with default, custom, and auto-loaded `.tfvars`.
- Observed dynamic configuration changes.

---

## 🛠️ How to Run

Initialize Terraform:
```bash
terraform init
