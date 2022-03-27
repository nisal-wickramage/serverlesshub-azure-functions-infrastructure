param storageAccountNames array = [
  'shdevtest0021'
  'shdevtest0022'
]

resource myFirstStorageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = [for name in storageAccountNames: {
  name: '${name}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
