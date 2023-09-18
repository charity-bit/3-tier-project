#Common Variables
variable "region" {}
variable "tags" {}
variable "project" {}



#Networking Variables
variable "networking_connectivity_type" {}
variable "networking_map_public_ip_on_launch" {}
variable "networking_private_data_subnet_cidrs" {}
variable "networking_private_subnet_cidrs" {}
variable "networking_public_subnet_cidrs" {}
variable "networking_vpc_cidr" {}


// Security Groups
variable "web_allowed_inbound_traffic" {}

#Route Table Variables
variable "rtb_rtb_cidr" {}


#EC2 ASG Variables

variable "ec2_asg_ami" {}
variable "ec2_asg_desired_size" {}
variable "ec2_asg_ec2_name" {}
variable "ec2_asg_health_check_grace_period" {}
variable "ec2_asg_health_check_type" {}
variable "ec2_asg_instance_type" {}
variable "ec2_asg_key_name" {}
variable "ec2_asg_max_size" {}
variable "ec2_asg_min_size" {}

#Load Balancer Variables
variable "lb_healthly_threshold" {}
variable "lb_interval" {}
variable "lb_lb_type" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}
variable "lb_matcher" {}
variable "lb_path" {}
variable "lb_priority" {}
variable "lb_timeout" {}
variable "lb_unhealthy_threshold" {}



#RDS Variables
variable "rds_allocated_storage" {}
variable "rds_allow_major_version_upgrade" {}
variable "rds_backup_retention_period" {}
variable "rds_db_engine" {}
variable "rds_db_engine_version" {}
variable "rds_db_instance_class" {}
variable "rds_db_password" {}
variable "rds_multi_az" {}
variable "rds_parameter_group_name" {}
variable "rds_skip_final_snapshot" {}
variable "rds_storage_type" {}
#variable "rds_subnet_ids" {}
variable "rds_username" {}
#variable "rds_vpc_security_group_id" {}





