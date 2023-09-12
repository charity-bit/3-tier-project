// Modules
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