output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
