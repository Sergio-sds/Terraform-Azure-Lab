
resource "random_string" "suffix" {
    length = 6
    upper = false
    special = false
}

# terraform plan = checks the changes in the infrastructure declared in the .tf
# terraform apply = applies the changes in the infrastructure declared in the .tf
# terraform destroy = destroys the infrastructure declared in the .tf

locals {
    environment_prefix = "${var.application_name}-${var.environment_name}-${random_string.suffix.result}"

    regional_stamps = {
        "foo" = {
            region = "westus"
            min_node_count = 4
            max_node_count = 8
        },
        "bar" = {
            region = "eastus"
            min_node_count = 4
            max_node_count = 8
        }
    }
}

# The use of $ is for concatenating variables in Terraform
# It is also used to assign values dynamically, making the code less static
# All of this is used to reference variables and resources more easily

# To create a new workspace use the command: terraform workspace new <workspace_name>
# To list the workspaces use the command: terraform workspace list
# To switch workspaces use the command: terraform workspace select <workspace_name>

# This will create a random string for an object reference called list
# The count property indicates that one object will be created for each element in the var.regions list

resource "random_string" "list"{

    count= length(var.regions)

    length = 6
    upper = false
    special = false
}

/*

this will create a random string for an object reference called map
the for_each property indicates that one object will be created for each element in the map var.region_instance_count
each object will have the map key as its key and the map value as its value

*/

resource "random_string" "map"{

    for_each = var.region_instance_count

    length = 6
    upper = false
    special = false
}


/*

this will create a random string for an object reference called if
the count property indicates that an object will be created if the variable var.enable is true
if it is false, nothing will be created
in case we create a resource when the value is true, if we change it to false and run apply
the resource will be automatically destroyed, and vice versa, if we change it from false to true, the resource will be created

this helps to have a more dynamic environment adaptable to the user's needs

*/

resource "random_string" "if" {

    # This will create a random string if the variable var.enable is true
    # If it is false, nothing will be created
    count = var.enable ? 1 : 0

    length = 6
    upper = false
    special = false
}

/*
every time we add a reference to a module, we need to run terraform init
this will download the module and add it to our project
*/


module "alpha" {
    source = "hashicorp/module/random"
    version = "1.0.0"
}

module "bravo" {
    source = "hashicorp/module/random"
    version = "1.0.0"
}


# we create a reference to a local module called rando

module "charlie" {
    source = "./modules/rando"
    
    length = 8
}

# we create a reference to a local module called regional_stamp
# this way we can create multiple instances of the module
# in a more dynamic way, adaptable to the user's needs

module "regional_stamps" {
    source = "./modules/regional-stamp"

    for_each = local.regional_stamps

    region = each.value.region
    name = each.key
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
}