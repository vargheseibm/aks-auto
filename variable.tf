# Azure Location
variable "location" {
  type = string
  description = "Azure Region where all these resources will be provisioned"
  default = "Central US"
}

# Azure Resource Group Name
variable "resource_group_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = "RG-ADA---CAKE-Team"
}

# Azure AKS Environment Name
variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = "dev"
}


variable "client_secret" {
  type = string  
  description = "secret" 
  default = "1f18Q~9yaExFdagNeURPNXpEX_KK-yYLVe1zWc9q"
}



variable "cluster_name" {
  type = string  
  description = "cluster" 
  default = "kubecluster-02"
}


variable "node_count" {
  type = number  
  description = "cluster" 
  default = 1
}
