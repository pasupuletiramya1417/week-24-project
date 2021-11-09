# --- root/main.tf ---

module "networking" {
  source       = "./networking"
  vpc_cidr     = "10.0.0.0/16"
  public_cidrs = ["10.0.0.0/20"]
}

module "compute" {
  source        = "./compute"
  sg        = module.sg
  public_subnet = module.networking.public_subnet
}
