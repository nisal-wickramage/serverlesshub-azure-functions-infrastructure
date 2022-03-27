param storageAccountNames array

resource myFirstStorageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = [for storageAccountName in storageAccountNames: {
  name: '${storageAccountName}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

output endpoints array = [for (name, i) in storageAccountNames: {
  storageAccountName: name
  endPoint: myFirstStorageAccount[i].properties.primaryEndpoints.blob
}]
