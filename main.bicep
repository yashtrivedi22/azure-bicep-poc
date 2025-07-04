param dataFactoryName string = 'adf-template-bicep-gh'
param location string = resourceGroup().location

resource dataFactoryName_resource 'Microsoft.DataFactory/factories@2018-06-01' =  {
  name: dataFactoryName
  location: location
  properties: {}
}
