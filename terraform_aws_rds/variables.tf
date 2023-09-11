# Common Variables
variable "region" {
    description = "default region for resources"
    type = string  
}
variable "project" {
    description = "Project Name"
    type = string
}

# variable "tier-name" {
#     type = string
  
# }

#RDS Variables
variable "subnet_ids" {
    type = list(string)
  
}
variable "allocated_storage" {
    description = "Allocated Storage in gigabytes"
    type = number
}

variable "storage_type" {
    description = "type of storage to use e.g gp2,standard"
   type = string
}

variable "db_engine" {
    description = "Database Engine to Use e.g postgres,msql "
    type = string
}

variable "db_engine_version" {
    description = "Version of DB engine e.g 5.7 for mySQL 5.7"
    type = string
}

variable "db_instance_class"{
    description = "The AWS instance type to use for the RDS instance"
    type = string
}

variable "username" {
    type = string  
}

variable "db_password" {
    type = string
    sensitive = true
}
variable "parameter_group_name" {
    description = "Parameter Group to associate with the RDS e.g default.mysql5.7"
    type = string 
}

variable "skip_final_snapshot" {
    description = "Setting this to true means that no final DB snapshot is created when the RDS instance is deleted."
    type = bool 
}

variable "vpc_security_group_id" {
    description = "Security Group to Associate with the RDS"
    type = string
}
