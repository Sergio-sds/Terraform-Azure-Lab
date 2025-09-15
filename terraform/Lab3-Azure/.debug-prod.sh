# set the subscription
export ARM_SUBSCRIPTION_ID="subID"

# set application / environment
export TF_VAR_application_name="observability"
export TF_VAR_environment_name="prod"

# set backend
export BACKEND_RESOURCE_GROUP="rg-Lab2Sergio-state-prod"
export BACKEND_STORAGE_ACCOUNT="st4vh0eybe2l"
export BACKEND_STORAGE_CONTAINER="tfstate"
export BACKEND_KEY=$TF_VAR_application_name-$TF_VAR_environment_name

# run terraform
terraform init \
    -backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP}" \
    -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT}" \
    -backend-config="container_name=${BACKEND_STORAGE_CONTAINER}" \
    -backend-config="key=${BACKEND_KEY}"

#this will allow more flexibility to the script
terraform $*

rm -rf .terraform