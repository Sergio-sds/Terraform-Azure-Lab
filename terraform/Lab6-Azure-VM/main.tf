resource "azurerm_resource_group" main {
    name = "rg-${var.application_name}-${var.environment_name}"
    location = var.primary_location
}

#this will create a public ip named vm1 for our virtual machine
resource "azurerm_public_ip" "vm1" {
  name                = "pip-${var.application_name}-${var.environment_name}-vm1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

#we create a reference of the subnet we want, the one we  made on previous lab
/*
data "azurerm_subnet" "alpha" {
  name                 = "snet-alpha"
  virtual_network_name = "vnet-network-dev"
  resource_group_name  = "rg-network-dev"
}
*/
data "azurerm_subnet" "bravo" {
  name                 = "snet-bravo"
  virtual_network_name = "vnet-network-dev"
  resource_group_name  = "rg-network-dev"
}

#this will create a virtual network interface

resource "azurerm_network_interface" "vm1" {
  name                = "nic-${var.application_name}-${var.environment_name}-vm1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  #this NIC will be in the public and private network
  ip_configuration {
    name                          = "public"
    #subnet_id                     = data.azurerm_subnet.alpha.id
    subnet_id                     = data.azurerm_subnet.bravo.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1.id
  }
}

#with the next resource block, we create an SSH Key for our Virtual Machine

resource "tls_private_key" "vm1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#with the following 2 resources we create a private and public key for our ssh connections to the VM
/*resource "local_file" "private_key" {
    content = tls_private_key.vm1.private_key_pem
    filename = pathexpand("~/.ssh/vm1")
    file_permission = "0600"
}*/


#we proceed to create a key vault to store the ssh private and public MD hash
resource "azurerm_key_vault_secret" "vm1_ssh_private" {
  name         = "vm1-ssh-private"
  value        = tls_private_key.vm1.private_key_pem
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault" "main" {
  name                = "kv-devops-dev-grghtsx"
  resource_group_name = "rg-devops-dev"
}

resource "azurerm_key_vault_secret" "vm1_ssh_public" {
  name         = "vm1-ssh-public"
  value        = tls_private_key.vm1.public_key_openssh
  key_vault_id = data.azurerm_key_vault.main.id
} 
/*resource "local_file" "public_key" {
    content = tls_private_key.vm1.public_key_openssh
    filename = pathexpand("~/.ssh/vm1.pub")
}*/


#with the following line, we create the virtual machine its recommended to not use "-" or any symbol 

resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vm1${var.application_name}${var.environment_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_D2_v2_Promo"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm1.id,
  ]

    identity {
        type = "SystemAssigned"
    }

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.vm1.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


#
resource "azurerm_virtual_machine_extension" "entra_id_login" {
  name                 = "${azurerm_linux_virtual_machine.vm1.name}-AADSSHLogin"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm1.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADSSHLoginForLinux"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
}

data "azurerm_client_config" "current" {}

#we assign a role for user login to the virtual machine
resource azurerm_role_assignment entra_id_user_login {
    scope = azurerm_linux_virtual_machine.vm1.id
    role_definition_name = "Virtual Machine User Login"
    #principal_id = data.azurerm_client_config.current.object_id
    principal_id = azuread_group.remote_access_users.object_id
}
