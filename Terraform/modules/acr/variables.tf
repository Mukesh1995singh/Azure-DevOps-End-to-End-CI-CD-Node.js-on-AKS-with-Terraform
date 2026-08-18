variable "acr_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "sku" {
  type        = string
  description = "SKU tier for Azure Container Registry (Basic, Standard, Premium)"
  default     = "Basic"
}
variable "tags" { type = map(string) }