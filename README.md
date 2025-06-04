# Ecommerce Infrastructure Monorepo

This repository contains the infrastructure and application code for the ecommerce microservices platform.

## Repository Structure

```
.
├── infrastructure/           # Infrastructure as Code (Terraform)
│   ├── environments/        # Environment-specific configurations
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   ├── modules/            # Reusable Terraform modules
│   │   ├── aks/           # Azure Kubernetes Service
│   │   ├── acr/           # Azure Container Registry
│   │   └── networking/    # Network configuration
│   └── shared/            # Shared infrastructure components
├── kubernetes/            # Kubernetes manifests
│   ├── base/             # Base configurations
│   └── overlays/         # Environment-specific overlays
└── services/             # Microservices source code
    ├── service1/
    ├── service2/
    └── service3/
```

## Prerequisites

- Azure CLI
- Terraform >= 1.0.0
- kubectl
- Docker

## Getting Started

1. Clone this repository
2. Configure Azure credentials
3. Initialize Terraform:
   ```bash
   cd infrastructure/environments/dev
   terraform init
   ```
4. Apply the infrastructure:
   ```bash
   terraform plan
   terraform apply
   ```

## Infrastructure Components

- **Azure Kubernetes Service (AKS)**: Managed Kubernetes cluster
- **Azure Container Registry (ACR)**: Private container registry
- **Azure Monitor**: Monitoring and logging
- **Azure Virtual Network**: Network infrastructure

## Contributing

Please follow the standard Git workflow:

1. Create a feature branch
2. Make your changes
3. Submit a pull request

## License

MIT 