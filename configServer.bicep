@description('Name of the resource group')
param resourceGroupName string

@description('Location of the resources')
param location string = resourceGroup().location

@description('Name of the Azure Container Apps environment')
param acaEnvironmentName string

@description('Name of the Java Config Server component')
param javaConfigCompName string

@description('Git repository URI for Spring Cloud Config Server')
param gitUri string

@description('Username for accessing the Git repository')
param gitUsername string

@description('Password for accessing the Git repository')
@secure()
param gitPassword string

@description('Default label for the Git repository')
param gitDefaultLabel string = 'main'

resource acaEnvironment 'Microsoft.App/managedEnvironments@2024-02-02-preview' existing = {
  name: acaEnvironmentName

}

resource javaConfigServer 'Microsoft.App/managedEnvironments/javaComponents@2024-02-02-preview' = {
  parent: acaEnvironment
  name: javaConfigCompName
  properties: {
   componentType: 'SpringCloudConfig'
    configurations: {
      gitProperty: {
        uri: gitUri
        username: gitUsername
        password: gitPassword
        label: gitDefaultLabel
      }
    }
  }
}

