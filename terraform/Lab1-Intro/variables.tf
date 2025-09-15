variable "application_name" {
    description = "The name of the application"
    type        = string
    default     = "PruebaVariables"

    validation {
        # If the condition is false, it will show the error message that we have defined
        condition = length(var.application_name) <= 12
        error_message = "Application Name must be less or equal to 12 characters"
    }
}

#environment
 
variable "environment_name" {
    type = string
}

/*
^
 Variables are grouped into blocks; ideally, each block should contain a variable and its description
 and its type, and if it has a default value, it should be set there
 Variables without a default value are required
 Variables with a default value are optional
 Variables can be called with -var or -var-file on the command line
 Example: terraform apply -var="application_name=devLAB1"
 This is useful to avoid changing the code every time you want to change a variable
 Ideally, all variables should be grouped in a single file called variables.tf
 as if it were a variable library
^
*/



variable "api_key" {
    type = string
    sensitive = true
}
# The variable api_key allows us to see the value of the api_key variable, but if we set sensitive = true, the value will not be shown in the output




# The variable instance_count allows us to define the number of instances to create, and its default value is 1

variable "instance_count" {
    type = number

    # && = and, != = not equal to (in this case, if it is not equal to 0)
    # We can define the minimum and maximum values in the validation.tf file and reference them here
    validation {
        condition = var.instance_count >= local.min_nodes && var.instance_count <= local.max_nodes && var.instance_count % 2 !=0
        error_message = "Must be between 5 and 9 and never Even"
    }
}

# The variable enable allows us to enable or disable the application
variable "enable" {
    type = bool
}

# The variable regions allows us to define the regions where the application will be deployed
variable "regions" {
    type = list(string)
}

# The variable region_instance_count allows us to define the number of instances per region
variable "region_instance_count" {
    type = map(string)
}

# The variable region_set allows us to define a set of regions
variable "region_set" {
    type = set(string)
}

# The variable sku_settings will create an object with the SKU configuration, which will be used to define the SKU type (kind) and tier
variable "sku_settings" {
    type = object({
        kind = string
        tier = string
    })
}

