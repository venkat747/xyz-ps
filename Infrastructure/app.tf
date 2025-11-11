data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "contributor" {
name = "Contributor"
}

resource "azurerm_role_assignment" "role_assignment" {
scope = data.azurerm_subscription.current.id
role_definition_id = data.azurerm_role_definition.contributor.id
principal_id = azurerm_app_service_plan.app_service_plan.identity[0].principal_id
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.webappname
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

resource "azurerm_app_service_custom_hostname_binding" "custom_hostname_binding" {
  hostname            = "www.zentac.com"
  app_service_name    = azurerm_app_service.app_service.name
  resource_group_name = azurerm_resource_group.resource_group.name
}

