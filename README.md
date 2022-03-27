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
az account set -s e8dcd51a-4d15-4531-94c3-06c5d11f091f
az deployment group create --resource-group test-rg --template-file main.bicep -c


az deployment group create --resource-group test-rg --template-file main.bicep --mode Complete            

az deployment group create --resource-group test-rg --template-file cosmos.bicep

https://docs.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline?view=azure-devops&tabs=java%2Ctfs-2018-2%2Cbrowser


 az deployment group create --resource-group sh-dev --template-file main.bicep --parameters params.json

az deployment group show --resource-group sh-dev --name main  --query properties.outputs.endpoints.value

az deployment group create --resource-group test-rg --template-file cosmos.bicep

az deployment group show --resource-group test-rg --name cosmos  --query properties.outputs.dbConnectionStrings.value