# SentinelOne Automation Through ADO Pipeline

## Pipeline Requirements

The sentinelOne Module Package pipeline requires the following parameters to be defined
Paramaters:


| Name  | Displayname | type | Default | Values | Opional/Required | Comments |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| ProjectName | Name of the Project | string | 'SentinelOneInstall' | | Required | This enables to use different display name for the pipeline |
| initbackend | Remote Backend to be used for Terraform | string | 'azure' |'tfworkspace' / 'azure' | Required | This defines which templates to be taken in consideration |
| tfplancommandOptions | Extra command to be used with Terraform plan | string | '-out=tfplan -lock=false' || Optional | This defines the extra command to be used with Terraform plan command |
| applycommandOptions | Extra command to be used with Terraform apply | string | '-auto-approve'|| Required | This defines the extra command to be used with Terraform apply command |
| destroycommandOptions | Extra command to be used with Terraform destroy | string | '-auto-approve'|| Required | This defines the extra command to be used with Terraform destroy command |
| provider | Name of the Provider | string | 'azurerm' |  | Optional | This defines the provider to be used |
| backendServiceArm  | Azure Service connection to authorize backend access | string |  | | Optional | This defines Azure Service connection to authorize backend access |
| backendAzureRmResourceGroupName | Azure backend resource-group | string |  | | Optional | This defines the Azure backend resource-group |
| backendAzureRmStorageAccountName | Azure location shortname of the backend storage account | string |  |  | Optional | This defines the Azure location shortname of the backend storage account |
| backendAzureRmContainerName | Azure blob container to store the state file | string |  |  | Optional | This defines the Azure blob container to store the state file |
| backendAzureRmKey | Azure blob file name | string |  |  | Optional | This defines the Azure blob file name |
| environmentServiceNameAzureRM  | Azure Service Connection | String |  |  | Optional | This defines the Azure environment Service Connection |
| resource_group_container | Azure backend resource-group | string |  | | Required | This defines the Azure backend resource-group |
| storageAccountName | Azure location shortname of the backend storage account | string |  |  | Required | This defines the Azure location shortname of the backend storage account |
| containerName | Azure blob container to store the state file | string |  |  | Required | This defines the Azure blob container to store the state file |

  These parameters provide configuration options for the Terraform Module SentinelOne pipeline.

## Explanation of pipeline

### 1. Variable group

  ```yaml
variables:
- group: Installing S1 for Windows
  ```
The above variable group includes the value of sentinel_apikey and sentinel_token, which is required during the installation process.

### 2. Variables in pipeline
Make sure you pass the variable inside the pipeline as below
| Name  | Value |
| ------------- | ------------- |
| subscription_id | XXXXXXXXXXXX-XXXXXXXXXXXX-XXXXXXXXXXXX-XXXXXXXXXXXX |
| tenant_id | XXXXXXXXXXXX-a312-4660-9b7c-XXXXXXXXXXXXXX |
| client_id | XXXXXXXXXXXX-9c1a-452f-b95a-XXXXXXXXXXXX |
| client_secret | 8Pv8Q~XXXXXXXXXXXX.XXXXXXXXXXXXXXXx |

### 3. Azure Blob storage as Terraform Backend

  ```yaml
    - task: TerraformTaskV4@4
      displayName: 'Terraform Init Using Azure Backend for ${{ parameters.ProjectName }}'
      name: 'TerraformInitAzure'
      condition: eq( '${{ parameters.initbackend }}', 'azure')
      inputs:
        provider: 'azurerm'
        command: 'init'
        backendServiceArm: <service-connection>
        backendAzureRmResourceGroupName: ${{ parameters.resource_group_container }}
        backendAzureRmStorageAccountName: ${{ parameters.storageAccountName }}
        backendAzureRmContainerName: ${{ parameters.containerName }}
        backendAzureRmKey: '${{ resource_group.name }}-RG.tfstate'
        client_id: $(client_id)
        client_secret: $(client_secret)
  ```
In the above pipeline, the parameters are provided to configure the Terraform pipeline according to the desired build configuration and stages.
