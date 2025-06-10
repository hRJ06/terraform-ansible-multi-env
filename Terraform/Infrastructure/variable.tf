variable "env" {
  description = "This is the environment for Infrastructure."
  type        = string
}

variable "bucket_name" {
  description = "This is the S3 bucket name for Infrastructure."
  type        = string
}

variable "instance_count" {
  description = "This is the number of EC2 instance for Infrastructure."
  type        = number
}

variable "ec2-ami" {
  description = "value"
  type        = string
}

variable "instance_type" {
  description = "This is the instance type for EC2 instance in Infrastructure."
  type        = string
}

variable "hash_key" {
  description = "This is the Hash Key for DynamoDB in Infrastructure."
  type        = string
}

variable "volume_size" {
  description = "This is the size of Root EBS for EC2 instance in Infrastructure."
  type        = number

}
