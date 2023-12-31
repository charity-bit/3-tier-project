// Modules

#Networking
module "networking" {
  source  = "app.terraform.io/orina-org/networking/aws"
  version = "1.2.0"

  project =  var.project
  region =  var.region 
  tags =  var.tags

  connectivity_type =  var.networking_connectivity_type 
  map_public_ip_on_launch =  var.networking_map_public_ip_on_launch 
  private_data_subnet_cidrs =  var.networking_private_data_subnet_cidrs 
  private_subnet_cidrs =  var.networking_private_subnet_cidrs 
  public_subnet_cidrs =  var.networking_public_subnet_cidrs 
  vpc_cidr =  var.networking_vpc_cidr 
}


# Security Groups
module "web_sg" {
  source  = "app.terraform.io/orina-org/security-groups/aws"
  version = "1.1.0"

  project = var.project
  region = var.region
  tags = var.tags
  tier-name = "WEB-Tier"

  allowed_inbound_traffic = var.web_allowed_inbound_traffic
  vpc_id = module.networking.vpc_id
}

module "app_sg" {
  source  = "app.terraform.io/orina-org/security-groups/aws"
  version = "1.1.0"

  region = var.region
  project = var.project
  tags = var.tags
  tier-name = "APP-Tier"

  vpc_id = module.networking.vpc_id
  allowed_inbound_traffic = {
    ssh = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow inbound SSH traffic from anywhere through the IGW"
    cidr_blocks = []
    source_security_group_id = [module.web_sg.sg_id]
     },
       http = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow inbound HTTP traffic from anywhere through the IGW"
    cidr_blocks = ["0.0.0.0/0"]
    source_security_group_id = [module.web_sg.sg_id]
  },
  https = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Allow inbound HTTPS traffic from anywhere through the IGW"
    cidr_blocks = ["0.0.0.0/0"]
    source_security_group_id = [module.web_sg.sg_id]

  }
  }
}

module "db_sg" {
  source  = "app.terraform.io/orina-org/security-groups/aws"
  version = "1.1.0"

  region = var.region
  project = var.project
  tags = var.tags
  tier-name = "DATA-Tier"

  vpc_id = module.networking.vpc_id
  allowed_inbound_traffic = {
    tcp = {
    from_port   = 3306 #MySQL/Aurora
    to_port     = 3306 #MySQL/Aurora
    protocol    = "tcp"
    description = "Allow inbound from the app_sg"
    cidr_blocks = []
    source_security_group_id = [module.app_sg.sg_id]
  }
  }
}

#Route Tables
module "rtb" {
  source  = "app.terraform.io/orina-org/rtb/aws"
  version = "2.1.0"

  project = var.project
  region = var.region
  tags = var.tags
  
  vpc_id = module.networking.vpc_id
  igw_id = module.networking.nat_id
  nat_id = module.networking.nat_id
  private_app_attach_subnets_ids = module.networking.private_app_subnet_ids
  private_data_attach_subnets_ids = module.networking.private_db_subnet_ids
  public_attach_subnets_ids = module.networking.public_subnet_ids

  rtb_cidr = var.rtb_rtb_cidr
}

#EC2 Instances

module "web_app_frontend" {
  source  = "app.terraform.io/orina-org/ec2-asg/aws"
  version = "1.1.0"

  region = var.region
  project = var.project
  tags = var.tags
  tier-name = "WEB-Tier"


  instance_type = var.ec2_asg_instance_type
  ami = var.ec2_asg_ami
  key_name = var.ec2_asg_key_name
  ec2_name = "Web FrontEnd"
  user_data = "./frontend_setup.sh"
  vpc_security_group_ids = [module.web_sg.sg_id]


  vpc_zone_identifier = module.networking.public_subnet_ids
  min_size = var.ec2_asg_min_size
  max_size = var.ec2_asg_max_size
  desired_size = var.ec2_asg_desired_size
  health_check_grace_period = var.ec2_asg_health_check_grace_period
  health_check_type = var.ec2_asg_health_check_type
  target_group_arn = module.web_lb.lb_target_group_arn
}

module "web_app_backend" {
  source  = "app.terraform.io/orina-org/ec2-asg/aws"
  version = "1.1.0"

  region = var.region
  project = var.project
  tags = var.tags
  tier-name = "APP-Tier"


  instance_type = var.ec2_asg_instance_type
  ami = var.ec2_asg_ami
  key_name = var.ec2_asg_key_name
  ec2_name = "Web Backend"
  user_data = "./backend_setup.sh"
  vpc_security_group_ids = [module.app_sg.sg_id]


  vpc_zone_identifier = module.networking.private_app_subnet_ids
  min_size = var.ec2_asg_min_size
  max_size = var.ec2_asg_max_size
  desired_size = var.ec2_asg_desired_size
  health_check_grace_period = var.ec2_asg_health_check_grace_period
  health_check_type = var.ec2_asg_health_check_type
  target_group_arn = module.app_lb.lb_target_group_arn
}



#Load Balancers
module "web_lb" {
  source  = "app.terraform.io/orina-org/lb/aws"
  version = "2.0.0"

  project = var.project
  region = var.region
  tags = var.tags
  tier-name = "web"

  healthly_threshold = var.lb_healthly_threshold
  interval =  var.lb_interval
  lb_name = "Frontend-Load-Balancer"
  lb_type = var.lb_lb_type
  listener_port = var.lb_listener_port
  listener_protocol = var.lb_listener_protocol
  matcher =  var.lb_matcher
  path = var.lb_path
  priority = var.lb_priority
  
  security_groups = [module.web_sg.sg_id]
  subnets = module.networking.public_subnet_ids
  vpc_id = module.networking.vpc_id
  
  
  timeout = var.lb_timeout
  unhealthy_threshold = var.lb_unhealthy_threshold
  
}


module "app_lb" {
  source  = "app.terraform.io/orina-org/lb/aws"
  version = "2.0.0"

  project = var.project
  region = var.region
  tags = var.tags
  tier-name = "app"

  healthly_threshold = var.lb_healthly_threshold
  interval =  var.lb_interval
  lb_name = "app-lb"
  lb_type = var.lb_lb_type
  listener_port = var.lb_listener_port
  listener_protocol = var.lb_listener_protocol
  matcher =  var.lb_matcher
  path = var.lb_path
  priority = var.lb_priority
  
  security_groups = [module.app_sg.sg_id]
  subnets = module.networking.public_subnet_ids
  vpc_id = module.networking.vpc_id
  
  
  timeout = var.lb_timeout
  unhealthy_threshold = var.lb_unhealthy_threshold
  
}

#Database instances
# Master and Read Replica 
module "rds" {
  source  = "app.terraform.io/orina-org/rds/aws"
  version = "2.1.0"


  project = var.project
  region = var.region

  
  subnet_ids = module.networking.private_db_subnet_ids
  vpc_security_group_id = module.db_sg.sg_id


  allocated_storage = var.rds_allocated_storage
  allow_major_version_upgrade = var.rds_allow_major_version_upgrade
  backup_retention_period = var.rds_backup_retention_period
  db_engine = var.rds_db_engine
  db_engine_version = var.rds_db_engine_version
  db_instance_class = var.rds_db_instance_class
  db_password = var.rds_db_password
  multi_az = var.rds_multi_az
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot = var.rds_skip_final_snapshot
  storage_type = var.rds_storage_type
  username = var.rds_username
}