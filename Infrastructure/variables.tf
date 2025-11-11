variable "resource_group_name"{
    type = string
    description = "resource group name"
}

variable "location" {
    type = string
    description = "location of the resource group"
}

variable "vnetsecuritygroup" {}

variable "virtual_network" {}

variable "tags" {}

variable "network_interface" {
    type = string
    description = "Name of the web Networj Interface"
}

variable "application_security_group" {
    type = string
    description = "Name of the web network security group"
}

variable "publicip" {
    type = string
    description = "Name of the public Ip"
}

variable "appgateway" {
    type = string
    description = "Name of the App gateway"
}

variable "wafpolicy" {
    type = string
    description = "Name of the waf policy"
}

variable "dbusername" {
    type = string
    description = "Name of the db dbusername"
}

variable "loginpassword" {
    type = string
    description = "Name of the db loginpassword"
}


variable "webAppName" {
    type = string
    description = "Name of the web application"
}

variable "app_service_plan" {
    type = string
    description = "Name of the App Service Plan"
}

variable "mssqldatabase" {
    type = string
    description = "Name of the SQL Database"
}

variable "sqlserver" {
    type = string
    description = "Name of the SQL Server"
}








