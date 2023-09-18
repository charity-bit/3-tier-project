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
#variable "ec2_asg_target_group_arn" {}
#variable "ec2_asg_user_data" {}
#variable "ec2_asg_vpc_security_group_ids" {}
#variable "ec2_asg_vpc_zone_identifier" {}




