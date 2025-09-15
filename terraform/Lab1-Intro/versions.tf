terraform {
    
    required_providers{

        random = {
            source = "hashicorp/random"
            version = ">= 3.1.0"
        }

    }

}

# This defines the required providers for the project
# With ~> we allow Terraform to use any lower version up to 4.0.0, also called "Patch releases"