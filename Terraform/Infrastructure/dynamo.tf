resource "aws_dynamodb_table" "dynamodb-state-table" {
  name         = "${var.env}-Infrastructure-Application-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = {
    Name        = "${var.env}-infrastructure-application-table"
    Environment = var.env
  }
}