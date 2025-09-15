variable "foo" {
    type = string
}

# The order in the command is important, terraform apply -var foo=blue -var-file=custom.tfvars will choose what is in custom.tfvars
# The last value set with -var will be chosen, in this case the file custom.tfvars

# !!!! load order is terraform.tfvars > default.auto.tfvars > any command -var or -var-file

# You can export the environment variable TF_VAR_foo with export TF_VAR_foo="value" and to see its value
# use the command echo $TF_VAR_foo

# To use this value when running terraform apply, you will need to comment out the corresponding line
# in the terraform.tfvars and default.auto.tfvars files