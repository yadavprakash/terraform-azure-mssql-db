module "labels" {
  source      = "git::https://github.com/yadavprakash/terraform-azure-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}


resource "azurerm_sql_server" "sql_server" {
  name                         = var.sqlserver_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  tags                         = merge({ "Name" = var.sqlserver_name }, var.tags, )

  dynamic "identity" {
    for_each = var.identity == true ? [1] : [0]
    content {
      type = "SystemAssigned"
    }
  }
}

resource "azurerm_sql_database" "db" {
  name                             = var.database_name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  server_name                      = azurerm_sql_server.sql_server.name
  edition                          = var.sql_database_edition
  requested_service_objective_name = var.sqldb_service_objective_name
  tags                             = merge({ "Name" = var.database_name }, var.tags, )

  threat_detection_policy {
    state = var.threat_detection_policy
  }
}

resource "azurerm_private_endpoint" "pep" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = format("%s-private-endpoint", var.sqlserver_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = merge({ "Name" = format("%s-private-endpoint", var.sqlserver_name) }, var.tags, )

  private_service_connection {
    name                           = "sqldbprivatelink"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_sql_server.sql_server.id
    subresource_names              = ["sqlServer"]
  }
}

data "azurerm_private_endpoint_connection" "pep_connection" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = azurerm_private_endpoint.pep[0].name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_sql_server.sql_server]
}

resource "azurerm_private_dns_a_record" "arecord" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = azurerm_sql_server.sql_server.name
  zone_name           = azurerm_private_dns_zone.dnszone[0].name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.pep_connection[0].private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone" "dnszone" {
  count               = var.existing_private_dns_zone == null && var.enable_private_endpoint ? 1 : 0
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
  tags                = merge({ "Name" = format("%s", "SQL-Private-DNS-Zone") }, var.tags, )
}

resource "azurerm_private_dns_zone_virtual_network_link" "vent-link" {
  count                 = var.enable_private_endpoint ? 1 : 0
  name                  = format("%s-mssql-private-zone-link", var.sqlserver_name)
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone[0].name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = true
  tags                  = merge({ "Name" = format("%s%s", var.sqlserver_name, "vnet-private-zone-link") }, var.tags, )
}