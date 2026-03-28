
output "ec2-public-ip" {
  value = [
    for instance in aws_instance.master_instance : instance.public_ip
  ]
}

output "ec2-private-ip" {
  value = [
    for instance in aws_instance.master_instance : instance.private_ip
  ]
}
