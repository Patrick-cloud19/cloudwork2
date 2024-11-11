resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.vpc_from_id
  peer_vpc_id = var.vpc_to_id
  auto_accept = true

  tags = {
    Name = "${var.vpc_from_name}-to-${var.vpc_to_name}-peering"
  }
}