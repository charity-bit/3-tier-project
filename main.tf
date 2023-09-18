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



