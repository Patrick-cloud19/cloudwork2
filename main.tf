# local variables
locals {
  vpcs = {
    vpc1 = {
      cidr_block        = var.cidr_vpc1,
      subnet_cidr_block = var.cidr_sub1,
      name              = "VPC1"
    }
    vpc2 = {
      cidr_block        = var.cidr_vpc2,
      subnet_cidr_block = var.cidr_sub2,
      name              = "VPC2"
    }
    vpc3 = {
      cidr_block        = var.cidr_vpc3,
      subnet_cidr_block = var.cidr_sub3,
      name              = "VPC3"
    }
  }

  # peering config
  vpc_peering_connections = [
    { source = "vpc1", target = "vpc2" },
    { source = "vpc1", target = "vpc3" },
    { source = "vpc2", target = "vpc3" }
  ]
  vpc_routes = [
    { source = "vpc1", target = "vpc2", peering_key = "vpc1_to_vpc2" },
    { source = "vpc1", target = "vpc3", peering_key = "vpc1_to_vpc3" },
    { source = "vpc2", target = "vpc1", peering_key = "vpc1_to_vpc2" },
    { source = "vpc2", target = "vpc3", peering_key = "vpc2_to_vpc3" },
    { source = "vpc3", target = "vpc1", peering_key = "vpc1_to_vpc3" },
    { source = "vpc3", target = "vpc2", peering_key = "vpc2_to_vpc3" }
  ]
}

# 1. Create VPCs
module "vpc" {
  source   = "./modules/vpc"
  for_each = local.vpcs

  cidr_block = each.value.cidr_block
  tags       = { Name = each.value.name }
}

# 2. Create Internet Gateways
module "internet_gateway" {
  source   = "./modules/igw"
  for_each = local.vpcs

  vpc_id     = module.vpc[each.key].vpc_id
  tags       = { Name = "${each.value.name}-igw" }
  depends_on = [module.vpc]
}

# 3. Create Route Tables (depends on IGW creation)
module "route_table" {
  source   = "./modules/route_table"
  for_each = local.vpcs

  vpc_id              = module.vpc[each.key].vpc_id
  internet_gateway_id = module.internet_gateway[each.key].internet_gateway_id
  subnet_id           = module.subnet[each.key].subnet_id
  tags                = { Name = "${each.value.name}-route-table" }

  depends_on = [module.internet_gateway]
}

# 4. Create Subnets
module "subnet" {
  source   = "./modules/subnet"
  for_each = local.vpcs

  vpc_id            = module.vpc[each.key].vpc_id
  cidr_block        = each.value.subnet_cidr_block
  availability_zone = var.availability_zone
  tags              = { Name = "${each.value.name}-subnet" }
}

# 5. Create Security Groups
module "security_group" {
  source   = "./modules/sg"
  for_each = local.vpcs

  vpc_id      = module.vpc[each.key].vpc_id
  cidr_blocks = [for vpc in local.vpcs : vpc.cidr_block]
  tags        = { Name = "${each.value.name}-sg" }
}

# 6. Create EC2 Instances
module "ec2" {
  source   = "./modules/ec2"
  for_each = local.vpcs

  ami               = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.subnet[each.key].subnet_id
  security_group_id = module.security_group[each.key].security_group_id
  instance_name     = "Instance-${each.key}"
  tags              = { Name = "${each.value.name}-instance" }
}

# 7. Create VPC Peering Connections
module "vpc_peering" {
  source   = "./modules/vpc_peering"
  for_each = { for idx, conn in local.vpc_peering_connections : "${conn.source}_to_${conn.target}" => conn }

  vpc_from_id   = module.vpc[each.value.source].vpc_id
  vpc_to_id     = module.vpc[each.value.target].vpc_id
  vpc_from_name = each.value.source
  vpc_to_name   = each.value.target
  depends_on    = [module.vpc, module.internet_gateway, module.route_table]
}

# 8. Create Peering Routes
module "peering_routes" {
  source   = "./modules/peering_route"
  for_each = { for idx, route in local.vpc_routes : "${route.source}_to_${route.target}" => route }

  route_table_id            = module.route_table[each.value.source].route_table_id
  destination_cidr_block    = local.vpcs[each.value.target].cidr_block
  vpc_peering_connection_id = module.vpc_peering[each.value.peering_key].vpc_peering_connection_id
  depends_on                = [module.vpc_peering]
}
