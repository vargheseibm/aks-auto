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


variable "resource_group_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = ""
}


variable "location" {
  type = string
  description = "Azure Region where all these resources will be provisioned"
  default = ""
}