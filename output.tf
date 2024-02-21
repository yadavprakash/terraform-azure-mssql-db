
output "sql_server_id" {
  description = "The primary Microsoft SQL Server ID"
  value       = azurerm_sql_server.sql_server.id
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the primary Azure SQL Server"
  value       = azurerm_sql_server.sql_server.fully_qualified_domain_name
}


output "sql_server_admin_user" {
  description = "SQL database administrator login id"
  value       = azurerm_sql_server.sql_server.administrator_login
  sensitive   = true
}

output "sql_server_admin_password" {
  description = "SQL database administrator login password"
  value       = azurerm_sql_server.sql_server.administrator_login_password
  sensitive   = true
}

output "sql_database_id" {
  description = "The SQL Database ID"
  value       = azurerm_sql_database.db.id
}

output "sql_database_name" {
  description = "The SQL Database Name"
  value       = azurerm_sql_database.db.name
}

output "sql_server_private_endpoint" {
  description = "id of the Primary SQL server Private Endpoint"
  value       = element(concat(azurerm_private_endpoint.pep[*].id, [""]), 0)
}


output "sql_server_private_dns_zone_domain" {
  description = "DNS zone name of SQL server Private endpoints dns name records"
  value       = var.enable_private_endpoint ? azurerm_private_dns_zone.dnszone[*].name : null
}


output "sql_server_private_endpoint_fqdn" {
  description = "Priamary SQL server private endpoint IPv4 Addresses "
  value       = element(concat(azurerm_private_dns_a_record.arecord[*].fqdn, [""]), 0)
}

