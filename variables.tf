variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
  type        = string
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
  type        = string
}

variable "threat_detection_policy" {
  description = ""
  default     = "Disabled"
  type        = string
}

variable "sqlserver_name" {
  description = "SQL server Name"
  default     = ""
  type        = string
}

variable "admin_username" {
  description = "The administrator login name for the new SQL Server"
  default     = null
  type        = string
}

variable "admin_password" {
  description = "The password associated with the admin_username user"
  default     = null
  type        = string
}

variable "database_name" {
  description = "The name of the database"
  default     = ""
  type        = string
}

variable "sql_database_edition" {
  description = "The edition of the database to be created"
  default     = "Standard"
  type        = string
}

variable "sqldb_service_objective_name" {
  description = " The service objective name for the database"
  default     = "S1"
  type        = string
}

variable "identity" {
  description = "If you want your SQL Server to have an managed identity. Defaults to false."
  default     = false
  type        = bool
}

variable "enable_private_endpoint" {
  description = "Manages a Private Endpoint to SQL database"
  default     = true
  type        = bool
}

variable "virtual_network_id" {
  description = "The resoruce id of existing Virtual network"
  default     = null
  type        = string
}

variable "subnet_id" {
  description = "The resource id of existing subnet"
  default     = null
  type        = string
}

variable "existing_private_dns_zone" {
  description = "Name of the existing private DNS zone"
  default     = null
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "sql_server_version" {
  type        = string
  default     = null
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)"
}

variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `mssql`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = ""
  description = "ManagedBy, eg 'Opz0'."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}


