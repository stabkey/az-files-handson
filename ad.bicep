param prefix string = 'mon'

param location string = resourceGroup().location
param vnetName string =  '${prefix}-Vnet'
param subnetName01 string = '${prefix}-Subnet01'
param subnetName02 string = '${prefix}-Subnet02'

@secure()
param adminPassword string
param publicIpName string = 'myPublicIP'
param publicIpSku string = 'standard'
@allowed([
  '2022-datacenter-azure-edition'
])
param OSVersion string = '2022-datacenter-azure-edition'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName01
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: subnetName02
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: '${prefix}-NSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          direction: 'Inbound'
          priority: 100
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
          sourceApplicationSecurityGroups: []
          destinationApplicationSecurityGroups: []
        }
      }
    ]
  }
}
