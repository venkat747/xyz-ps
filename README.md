# XYZ Web Application Deployment Documentation

## Table of Contents
1. [Project Structure](#project-structure)
2. [Infrastructure as Code (Terraform)](#infrastructure-as-code)
3. [.NET Web Application](#net-web-application)
4. [Azure DevOps Pipeline](#azure-devops-pipeline)
5. [Deployment Instructions](#deployment-instructions)

## Project Structure
```
XYZ-ps/
├── Infrastructure/
│   ├── app.tf             # Web App and App Service Plan configuration
│   ├── Appgateway.tf      # Application Gateway configuration
│   ├── database.tf        # Azure SQL Database configuration
│   ├── keyvault.tf       # Azure Key Vault configuration
│   ├── output.tf         # Terraform outputs
│   ├── variables.tf      # Variable declarations
│   ├── variables.tfvars  # Variable values
│   ├── version.tf        # Provider and version configuration
│   └── vnet.tf          # Virtual Network configuration
├── Pipeline/
│   ├── azure-pipelines.yml  # Azure DevOps pipeline configuration
│   └── script.ps1           # PowerShell deployment script
└── src/
    └── XYZWebApp.Api/
        ├── Controllers/
        │   └── WeatherForecastController.cs
        ├── appsettings.json
        ├── Program.cs
        ├── WeatherForecast.cs
        └── XYZWebApp.Api.csproj
```

## Infrastructure as Code
The infrastructure is managed using Terraform and includes the following components:

### Azure Resources
1. **Resource Group**
   - Name: Defined in variables
   - Location: Defined in variables

2. **Virtual Network**
   - Address space: 10.0.0.0/24
   - DNS Servers configured
   - Multiple subnets for different components

3. **Application Gateway**
   - WAF enabled
   - SSL/TLS configuration
   - Backend pool configuration

4. **Azure SQL Database**
   - Server configuration
   - Database configuration
   - Firewall rules

5. **Web App**
   - App Service Plan
   - Web App configuration
   - Application settings

### Terraform Configuration
To deploy the infrastructure:

1. Initialize Terraform:
```powershell
cd Infrastructure
terraform init
```

2. Plan the deployment:
```powershell
terraform plan -var-file="variables.tfvars"
```

3. Apply the configuration:
```powershell
terraform apply -var-file="variables.tfvars"
```

## .NET Web Application
The solution includes a .NET 8.0 Web API project with the following features:

### Project Configuration
- Target Framework: .NET 8.0
- Nullable enabled
- Implicit usings enabled

### Dependencies
- Microsoft.AspNetCore.OpenApi
- Swashbuckle.AspNetCore

### API Endpoints
1. WeatherForecast
   - GET /weatherforecast
   - Returns sample weather data

## Azure DevOps Pipeline
The deployment pipeline is configured with multiple stages:

### Build Stage
```yaml
- Build .NET Application
  - Restore packages
  - Build solution
  - Run tests
  - Publish artifacts
```

### Deploy Stage
```yaml
- Deploy to Azure Web App
  - Download artifacts
  - Deploy to Azure Web App
  - Post-deployment validation
```

### Pipeline Features
- Self-hosted agent pool
- Environment-specific deployments
- Artifact management
- Automatic triggers on main branch

## Deployment Instructions

### Prerequisites
1. Install required tools:
   - .NET 8.0 SDK
   - Azure CLI
   - Terraform
   - PowerShell 7+

### Development Environment Setup
1. Clone the repository
2. Install dependencies:
```powershell
cd src/XYZWebApp.Api
dotnet restore
```

### Local Testing
1. Build and run the application:
```powershell
dotnet build
dotnet run
```
2. Access the API at: https://localhost:5001

### Azure Deployment
1. Configure Azure credentials:
```powershell
az login
```

2. Deploy infrastructure:
```powershell
cd Infrastructure
.\script.ps1 -action "apply"
```

3. Configure Azure DevOps:
   - Create a new project
   - Import the repository
   - Configure service connections
   - Set up pipeline variables
   - Run the pipeline

### Post-Deployment Verification
1. Check resource deployment in Azure Portal
2. Verify API accessibility
3. Test application functionality
4. Monitor application insights

## Security Considerations
1. Key Vault for secrets management
2. Network security groups
3. WAF policies
4. SQL Database firewall rules

## Monitoring and Maintenance
1. Application Insights integration
2. Log Analytics workspace
3. Azure Monitor alerts
4. Backup policies

## Troubleshooting
Common issues and solutions:
1. Pipeline failures
   - Check agent pool availability
   - Verify service connection permissions
   - Review build logs

2. Infrastructure deployment issues
   - Verify Azure credentials
   - Check resource name availability
   - Review Terraform state

3. Application issues
   - Check application logs
   - Verify configuration settings
   - Review deployment slots

## Support and Resources
- Azure Documentation: https://docs.microsoft.com/azure
- Terraform Documentation: https://www.terraform.io/docs
- .NET Documentation: https://docs.microsoft.com/dotnet