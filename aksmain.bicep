param aksClusterName string = 'demoaks${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param nodeCount int = 1
param nodeVMSize string = 'Standard_DS2_v2'

resource aks 'Microsoft.ContainerService/managedClusters@2023-01-01' = {
  name: aksClusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: '${aksClusterName}-dns'
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: nodeCount
        vmSize: nodeVMSize
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
        mode: 'System'
      }
    ]
    kubernetesVersion: ''
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}

output aksClusterName string = aks.name
output aksFqdn string = aks.properties.fqdn
