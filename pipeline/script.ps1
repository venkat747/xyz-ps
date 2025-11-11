# Simple PowerShell script to run Terraform commands
param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("init", "plan", "apply", "destroy")]
    [string]$action = "plan"
)

# Set error action preference to stop on any error
$ErrorActionPreference = "Stop"

function Write-Log {
    param($Message)
    Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): $Message"
}

try {
    # Change to infrastructure directory
    $infraPath = "D:\XYZ-ps\Infrastucture"
    Write-Log "Changing to infrastructure directory: $infraPath"
    Set-Location $infraPath

    # Execute Terraform commands based on action
    switch ($action) {
        "init" {
            Write-Log "Initializing Terraform..."
            terraform init
        }
        "plan" {
            Write-Log "Creating Terraform plan..."
            terraform plan -out=tfplan
        }
        "apply" {
            Write-Log "Applying Terraform configuration..."
            terraform apply -auto-approve tfplan
        }
        "destroy" {
            Write-Log "Destroying infrastructure..."
            terraform destroy -auto-approve
        }
    }

    Write-Log "Terraform $action completed successfully"
}
catch {
    Write-Error "An error occurred: $_"
    exit 1
}