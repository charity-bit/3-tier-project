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
variable "lb_lb_name" {}
variable "lb_lb_type" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}
variable "lb_matcher" {}
variable "lb_path" {}
variable "lb_priority" {}
variable "lb_project" {}
variable "lb_region" {}
variable "lb_security_groups" {}
variable "lb_subnets" {}
variable "lb_tags" {}
variable "lb_tier-name" {}
variable "lb_timeout" {}
variable "lb_unhealthy_threshold" {}
variable "lb_vpc_id" {}




