param subscriptionId string = 'e8dcd51a-4d15-4531-94c3-06c5d11f091f'
param name string = 'sh-demo-dev-api'
param location string = 'East US 2'
param hostingPlanName string = 'sh-demo-dev-api'
param serverFarmResourceGroup string = 'sh-dev'
param storageAccountName string = 'shdemodevapi'
param use32BitWorkerProcess bool  = false
param linuxFxVersion string = 'Node|14'
param sku string = 'Dynamic'
param skuCode string = 'Y1'

resource name_resource 'Microsoft.Web/sites@2018-11-01' = {
  name: name
  kind: 'functionapp,linux'
  location: location
  tags: {}
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'node'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccountName_resource.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
      ]
      use32BitWorkerProcess: use32BitWorkerProcess
      linuxFxVersion: linuxFxVersion
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    clientAffinityEnabled: false
  }
  dependsOn: [
    hostingPlanName_resource
  ]
}

resource hostingPlanName_resource 'Microsoft.Web/serverfarms@2020-10-01' = {
  name: hostingPlanName
  location: location
  kind: 'linux'
  tags: {}
  properties: {
    reserved: true
  }
  sku: {
    tier: sku
    name: skuCode
  }
  dependsOn: []
}

resource storageAccountName_resource 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  tags: {}
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}
