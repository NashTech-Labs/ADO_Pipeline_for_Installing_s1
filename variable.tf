variable "subscription_id" {}
variable "tenant_id" {}
variable "sentinel_apikey" {}
variable "sentinel_token" {}
variable "client_id" {}
variable "client_secret" {}
variable "resource_group" {}
variable "vm_names" {
  type        = list(string)
  default     = [ "xyz" ]
  description = "resource group of vms to add sentinel one to"
}
