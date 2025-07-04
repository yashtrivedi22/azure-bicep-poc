@description('Name of the AKS Cluster')
param aksClusterName string = 'demoaks${uniqueString(resourceGroup().id)}'

@description('Azure Region for AKS Cluster')
param location string = resourceGroup().location

@description('Number of nodes in the default node pool')
param agentCount int = 1

@description('VM Size for the agent nodes')
param agentVMSize string = 'Standard_DS2_v2'

resource aks 'Microsoft.ContainerService/managedClusters@2023-01-01' = {
  name: aksClusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: aksClusterName
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
        mode: 'System'
      }
    ]
    kubernetesVersion: ''  // uses default latest version
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}

output aksClusterName string = aks.name
output aksFqdn string = aks.properties.fqdn
