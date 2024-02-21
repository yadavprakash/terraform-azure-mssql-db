output "primary_sql_server_id" {
  description = "The primary Microsoft SQL Server ID"
  value       = module.mssql-server.sql_server_id
}

output "primary_sql_server_fqdn" {
  description = "The fully qualified domain name of the primary Azure SQL Server"
  value       = module.mssql-server.sql_server_fqdn
}

output "sql_server_admin_user" {
  description = "SQL database administrator login id"
  value       = module.mssql-server.sql_server_admin_user
  sensitive   = true
}

output "sql_server_admin_password" {
  description = "SQL database administrator login password"
  value       = module.mssql-server.sql_server_admin_password
  sensitive   = true
}

output "sql_database_id" {
  description = "The SQL Database ID"
  value       = module.mssql-server.sql_database_id
}

output "sql_database_name" {
  description = "The SQL Database Name"
  value       = module.mssql-server.sql_database_name
}

output "primary_sql_server_private_endpoint" {
  description = "id of the Primary SQL server Private Endpoint"
  value       = module.mssql-server.sql_server_private_endpoint
}

output "sql_server_private_dns_zone_domain" {
  description = "DNS zone name of SQL server Private endpoints dns name records"
  value       = module.mssql-server.sql_server_private_dns_zone_domain
}

output "sql_server_private_endpoint_fqdn" {
  description = "Priamary SQL server private endpoint IPv4 Addresses "
  value       = module.mssql-server.sql_server_private_endpoint_fqdn
}