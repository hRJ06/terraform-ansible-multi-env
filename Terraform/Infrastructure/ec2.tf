# CREATE KEY PAIR
resource "aws_key_pair" "ec2_deployer" {
  key_name   = "${var.env}-infrastructure-application-key"
  public_key = file("ec2-security-key.pub")
  tags = {
    Environment = var.env
  }
}

# USE DEFAULT VPC
resource "aws_default_vpc" "default_vpc" {

}

# CREATE SECURITY GROUP
resource "aws_security_group" "ec2_allow_user_to_connect" {
  name        = "${var.env}-infrastructure-application-sg"
  description = "Allow inbound / outbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id
  # INBOUND PORT
  ingress {
    description = "Allow PORT 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow PORT 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow PORT 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # OUTBOUND PORT
  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-infrastructure-application-sg"
  }
}

resource "aws_instance" "ec2_instance" {
  count      = var.instance_count
  depends_on = [aws_security_group.ec2_allow_user_to_connect, aws_key_pair.ec2_deployer]
  ami        = var.ec2-ami

  instance_type   = var.instance_type
  key_name        = aws_key_pair.ec2_deployer.key_name
  security_groups = [aws_security_group.ec2_allow_user_to_connect.name]
  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }
  tags = {
    Name        = "${var.env}-infrastructure-application-instance"
    Environment = var.env
  }
}