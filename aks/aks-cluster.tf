resource "azurerm_resource_group" "rg" {
  name     = "${var.azure_resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.name}"
  resource_group_name = "${var.azure_resource_group_name}"
  location            = "${var.location}"
  dns_prefix          = "${var.dns_prefix}"
  kubernetes_version  = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = "${chomp(file("~/.ssh/id_rsa"))}"
    }
  }

  agent_pool_profile {
    name            = "${var.name}"
    count           = "${var.node_count}"
    vm_size         = "${var.vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${chomp(file("../.config/sp_id.txt"))}"
    client_secret = "${chomp(file("../.config/sp_secret.txt"))}"
  }

  tags {
    Enviromnet = "dev"
  }
}

output "id" {
  value = "${azurerm_kubernetes_cluster.cluster.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.cluster.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.cluster.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.cluster.kube_config.0.host}"
}
