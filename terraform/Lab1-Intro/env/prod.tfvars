environment_name = "prod"
instance_count = 7
enable = false
#the order in which they are defined (in regions) will not matter, they are separated by indexes (0,1,2... from left to right)
regions = ["westus", "eastus", "westus"]
region_instance_count = {
    "westus" = 4
    "eastus" = 8
}
region_set = ["westus","eastus"]

sku_settings = {
    kind = "P"
    tier = "Business"
}