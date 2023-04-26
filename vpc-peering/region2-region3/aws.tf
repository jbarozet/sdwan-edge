
provider "aws" {
  region                   = var.region_primary
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "ciscotme"
  alias = "primary"
}

provider "aws" {
  region                   = var.region_secondary
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "ciscotme"
  alias = "secondary"
}