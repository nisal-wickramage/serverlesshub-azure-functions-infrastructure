# This repo contains infrastructure code for todo items 

bicep guide
https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI


## prerequisites

VS Code with Bicep extension
Azure CLI

## steps followed
`az login`
create resource group `main.bicep`
create deployment group `az group create --name exampleRG --location eastus`
see whats going to be deployed  `az deployment sub create --name serverlesshubDev -f ./main.bicep -l eastus -c`
delete `az deployment sub delete -n serverlesshubDev --subscription 00a295bd-ad6d-4103-9410-087f91c5cba1`

az login
az account set -s 1ebbb56e-2979-41cb-a605-97e7b35bcac9
az deployment group create --resource-group learn-dcb85bba-4a37-4a33-b38e-fe6cbeef4835 --template-file main.bicep -c


az deployment group create --resource-group learn-dcb85bba-4a37-4a33-b38e-fe6cbeef4835 --template-file main.bicep --mode Complete            

az deployment group create --resource-group learn-dcb85bba-4a37-4a33-b38e-fe6cbeef4835 --template-file cosmos.bicep