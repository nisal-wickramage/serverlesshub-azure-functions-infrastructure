param location string = 'centralus'
param apimName string = 'testnisal1234'
param organizationName string = 'testnisal1234'
param adminEmail string = 'theserverlesshub@gmail.com'
param tier string = 'Developer'
param capacity int = 1
param identity object =  {
  'type': 'None'
}
param virtualNetworkType string = 'None'
param vnet object = {}
param tripleDES bool = false
param http2 bool = false
param clientTls11 bool = false
param clientTls10 bool = false
param clientSsl30 bool = false
param backendTls11 bool = false
param backendTls10 bool = false
param backendSsl30 bool = false

var customPropertiesNonConsumption = {
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168': tripleDES
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': clientTls11
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': clientTls10
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30': clientSsl30
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': backendTls11
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': backendTls10
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': backendSsl30
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Protocols.Server.Http2': http2
}
var customPropertiesConsumption = {
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': clientTls11
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': clientTls10
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': backendTls11
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': backendTls10
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': backendSsl30
  'Microsoft.WindowsAzure.ApiManagement.Gateway.Protocols.Server.Http2': http2
}

resource virtualNetworkType_None_vnet9901_vnet_name 'Microsoft.Network/virtualNetworks@2020-04-01' = if (((!empty(vnet)) && (vnet.newOrExisting == 'new')) && (virtualNetworkType != 'None')) {
  name: ((virtualNetworkType == 'None') ? 'vnet9901' : vnet.name)
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ((virtualNetworkType == 'None') ? array('13.41.6.0/26') : vnet.addressPrefixes)
    }
    subnets: [
      {
        name: ((virtualNetworkType == 'None') ? 'default9901' : vnet.subnets.subnet.name)
        properties: {
          addressPrefix: ((virtualNetworkType == 'None') ? '13.41.6.0/26' : vnet.subnets.subnet.addressPrefix)
        }
      }
    ]
  }
}

resource apimName_resource 'Microsoft.ApiManagement/service@2019-01-01' = {
  name: apimName
  location: location
  sku: {
    name: tier
    capacity: capacity
  }
  identity: identity
  tags: json('{}')
  properties: {
    publisherEmail: adminEmail
    publisherName: organizationName
    virtualNetworkType: virtualNetworkType
    virtualNetworkConfiguration: ((virtualNetworkType != 'None') ? json('{"subnetResourceId": "${resourceId(vnet.resourceGroup, 'Microsoft.Network/virtualNetworks/subnets', vnet.name, vnet.subnets.subnet.name)}"}') : json('null'))
    customProperties: ((tier == 'Consumption') ? customPropertiesConsumption : customPropertiesNonConsumption)
  }
  dependsOn: [
    virtualNetworkType_None_vnet9901_vnet_name
  ]
}
