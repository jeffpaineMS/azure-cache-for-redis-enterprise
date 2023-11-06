


resource "azurerm_resource_group" "example" {
  name     = "example-redisenterprise"
  location = "eastus"
}

resource "azurerm_redis_enterprise_cluster" "example" {
  name                = "example-redisenterprise"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  sku_name = "Enterprise_E10-2"
}

resource "azurerm_redis_enterprise_cluster" "example1" {
  name                = "example-redisenterprise1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  sku_name = "Enterprise_E10-2"
}

resource "azurerm_redis_enterprise_database" "example" {
  name                = "default"
  resource_group_name = azurerm_resource_group.example.name

  cluster_id        = azurerm_redis_enterprise_cluster.example.id
  client_protocol   = "Encrypted"
  clustering_policy = "EnterpriseCluster"
  eviction_policy   = "NoEviction"
  port              = 10000

  linked_database_id = [
    "${azurerm_redis_enterprise_cluster.example.id}/databases/default",
    "${azurerm_redis_enterprise_cluster.example1.id}/databases/default"
  ]

  linked_database_group_nickname = "tftestGeoGroup"
}
