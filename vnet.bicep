param prefix string  
@description('Location for all resources.')  
param location string = resourceGroup().location  
  
var addressPrefix = '10.0.0.0/16'  
var subnetName = '${prefix}-Subnet01'  
var subnetPrefix = '10.0.0.0/24'  
var virtualNetworkName = '${prefix}-vnet'  
  
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {  
  name: virtualNetworkName  
  location: location  
  properties: {  
    addressSpace: {  
      addressPrefixes: [addressPrefix]  
    }  
    subnets: [  
      {  
        name: subnetName  
        properties: {  
          addressPrefix: subnetPrefix  
        }  
      }  
    ]  
  }  
}  
  
output virtualNetworkId string = virtualNetwork.id  
