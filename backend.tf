#In Cases Where you are storing your state files remote
# and you want your remote provider(terraform cloud or terraform enterprise) to manage your infra.


#Storing in s3
# terraform {
#   backend "s3" {
#       bucket = "bucket-name"
#       key    = "state/terraform.tfstate"
#       region = "region-name"
#       dynamodb_table = "dynamodb-table"
#       encrypt = "true"
#   }
# }


#Storing in terraform cloud
# terraform {
#   cloud {
#     organization = "orina-org"

#     workspaces {
#       name = "devops"
#     }
#   }
# }

#Terraform Enterprise

# terraform {
#   cloud {
#     hostname = "your-host-name"
#     organization = "your-organization-name"
#     workspaces {
#       name = "workspace-name"
#     }
#   }

# }
