output "application_name" {
    value = var.application_name
}

output "environment_name" {
    value = var.environment_name
}

output "environment_prefix" {
    value = local.environment_prefix
}

output "suffix" {
    value = random_string.suffix.result
}

# Commands for output: terraform output application_name <- here goes the name of the variable you want to see
# It is important that after running terraform plan, if you want these changes to be applied, run terraform apply

output "api_key" {
    value = var.api_key
    sensitive = true
}

# output api_key allows us to see the value of the api_key variable, but if we set sensitive = true, the value will not be shown in the output
# this is not secure because with the command terraform output api_key the value will still be displayed on screen

# // In PowerShell
# // $env:Sergio_API_KEY = "foo" , creates or overwrites an environment variable called Sergio_API_KEY
# it will be assigned the value foo, and this variable will be available for any process you start in this same PS session
# if we close the PowerShell session, the variable will no longer exist
# there are ways to make the set variable persist

# // using the command $env:TF_VAR_api_key = "foo"
# this environment variable will be set so that Terraform recognizes it as an input variable
# this practice is considered a secure way to handle secrets (secret values) to pass them to Terraform without exposing them
# directly in the code
# If possible, avoid including secrets directly in configuration files

output primary_region {
    value = var.regions[0]
}

output "primary_region_instance" {
    value = var.region_instance_count["westus"]
}

output "kind" {
    value = var.sku_settings.kind
}

# This way we can reference existing modules from the Terraform Module Registry
# We will need to learn which input variables the module requires and which output variables it returns
# It is necessary to review the documentation of each module to know which variables it needs and which variables it provides

output "alpha" {
    value = module.alpha.random_string
}

output "bravo" {
    value = module.bravo.random_string
}

output "charlie" {
    value = module.charlie.random_string
}

output "regionA" {
    value = module.regional_stamps["foo"].name
}

output "regionB" {
    value = module.regional_stamps["bar"].name
}