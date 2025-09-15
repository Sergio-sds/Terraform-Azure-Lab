environment_name = "devLAB1"
instance_count = 7
enable = false
#the order in which they are defined (in regions) will not matter, they are separated by indexes (0,1,2... from left to right)
regions = ["westus", "eastus"]
region_instance_count = {
    "westus" = 4
    "eastus" = 8
}
region_set = ["westus","eastus"]

sku_settings = {
    kind = "P"
    tier = "Business"
}

/* Using input variables for environment configuration
 using terraform apply -var-file <filename with extension> will extract the variables defined in the file
 for the target file, if it is in folders, use -var-file ./env/<filename with extension> 
 */