# AVD Accelerator – Enhanced for CI/CD and Brownfield Deployments
This repository is created on the baseline of ['Azure/avdaccelerator'](https://github.com/Azure/avdaccelerator/tree/main/) public project. Here, we have added features like pipeline to deploy images and session hosts, usage of customizer steps to work for app installations on hosts and cleanup, brownfield deployment of application group, session host schedulers, remove session hosts script for brownfield scenario.

----

# Overview
This project builds on the Azure Virtual Desktop (AVD) Accelerator foundation and introduces advanced capabilities for enterprise-scale deployments. Our enhancements focus on automation, integration, and flexibility to support both greenfield and brownfield environments.

## Key Enhancements
1. CI/CD Integration: Automated deployment pipelines for consistent and repeatable AVD environment provisioning.
1. Brownfield Support: Adaptable templates and scripts to integrate with existing infrastructure and legacy environments.
1. Enhanced Customizer steps: Updated to do software installations and later do cleanup of files from hosts.
1. Enterprise Governance: Incorporation of security, compliance, and operational best practices aligned with Microsoft’s Cloud Adoption Framework.

## Features

1. Modular Infrastructure as Code (IaC) templates using Bicep/ARM.
2. Support for custom image builds and session host scaling.
3. Multi-environment deployment and options for selection of deployment type.

---

## Getting Started

### Prerequisites
1. Azure subscription with required resource providers registered.
2. Access to AVD Accelerator base templates.
3. Azure CLI or PowerShell installed locally.

### Clone Repisorty
```
git clone https://github.com/SiddhiGupta10/avdaccelarator.git
cd avdaccelarator/IaC
```

### Deploy Using Bicep
```
az deployment sub create \
  --location <region> \
  --template-file main.bicep \
  --parameters @parameters.json
```

### CI/CD Integration
Refer to the /pipelines folder for sample YAML pipelines to automate deployments via Azure DevOps.

---

## Deployments

### Infrastructure Provisioning
Automated Deployment Includes:

1. Modular Resource Group Structure for clear separation of concerns and easier management.
1. Enforced Naming Conventions and Tagging through Infrastructure as Code (IaC) for consistency and governance.
1. Image Builder for creating and customizing session host images.
1. Image Build Scheduler to run image creation either once or on a recurring basis.
1. Host Pools for organizing session hosts.
1. Multiple session hosts provisioned and configured automatically.
1. Application Groups for publishing apps and desktops.
1. Session Host Schedulers to manage scaling and availability.
1. Supporting Resources such as networking, storage, and identity components.

### Repo Structure

```
📁 avm/
    └── Azure Verified Modules (AVMs): Standardized, reusable Bicep modules following Microsoft best practices - coming from [Azure/avdaccelerator](https://github.com/Azure/avdaccelerator/tree/main/avm)
📁 IAC/
    |
    ├── avd-main-subscription
        └── workload
        │   └── Example of Bicep files defining AVD main infrastructure deployments.
        ├── pipeline.deploy.baseline.yml
        │   └── Azure DevOps pipeline to deploy resources using Bicep templates.
        └── pipeline.variables.yml
        │   └── Contains variables used in the deployment pipeline
    ├── custom-image-subscription
        ├── parameters/
        │   └── Contains parameter values for brownfield and greenfield bicep files.
        ├── workload/
        │   └── Greenfield Bicep files defining AVD shared infrastructure deployments.
        ├── pipeline.custom.image.deploy.yml
        │   └── Azure DevOps pipeline to deploy resources using Bicep templates.
        └── pipeline.variables.yml
            └── Contains variables used in the deployment pipeline, such as:
    ├── uploadScripts
        ├── scripts/
        │   └── Contains scripts to upload on stoarge blob to be used for session hosts.
        ├── pipeline.upload.scripts.yml
        │   └── Azure DevOps pipeline to upload scripts to storage account.
📁 workload/
    └── Bicep templates and modules used for provisioning AVD infrastructure - coming from [Azure/avdaccelerator](https://github.com/Azure/avdaccelerator/tree/main/avm)
```

---

## Source of avm and workload Folders

The `avm/` and `workload/` folders are **cloned from the official AVD Accelerator GitHub repository**:

🔗 [https://github.com/Azure/avdaccelerator](https://github.com/Azure/avdaccelerator)

These folders contain **Azure Verified Modules (AVMs)** and deployment templates that follow Microsoft's best practices for AVD deployments.

We leverage these modules to:

* Reuse standardized Bicep components
* Customize the infrastructure as per our organizational requirements
* Maintain consistency and compliance across environments

### How to Use the `avm` and `workload` Folders**

The actual implementation of the deployment logic resides in the `iac/` folder, which includes the complete structure and orchestration required to provision **session hosts**, **application groups**, **workspaces**, **key vault**, **networking component** and **host pools** using Bicep templates.

The main orchestration file is:

📄 `iac/workload/deploy-baseline.bicep`
This file defines and links AVD components and uses the modules from the `avm/` and `workload/` folders.

**Customize and Extend `avm/`** and `workload/` **Templates**

The workload/ folder provides AVD-specific Bicep modules used in the deploy-baseline.bicep file. You can extend these templates to meet your AVD environment needs.
The avm/ folder contains reusable Azure Verified Modules (AVMs).

These can be extended or customized to include additional configuration such as monitoring, diagnostics, or custom image.

---

## Azure DevOps (ADO) Pipeline Workflow

### 1. Validation

* Checks for syntax errors in Bicep and parameter files
* Ensures templates are correctly structured and consistent
* Identifies issues early in the CI process before deployment
* Performs a "What-If" analysis of the deployment
* Simulates changes without applying them
* Shows which resources will be created, modified, or ignored

### 2. Deployment

* Executes the actual provisioning using Bicep templates and parameters
* Applies all changes as defined in the templates
* Creates or updates AVD infrastructure resources
* This stage uses defines Environment for deployment.
  
