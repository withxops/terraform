resource "aws_key_pair" "connect_key" {
  key_name = "terrakey"
  public_key = file("terrakey.pub")
}

resource "aws_default_vpc" "default_vpc" {
}
  
resource "aws_security_group" "ansible_sg" {
    name = "ansible_sg"
    description = "ansible_sg"
    vpc_id = aws_default_vpc.default_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allowing ssh from anywhere"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
       description = "allowing http"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
       description = "allowing all"
    }

}

resource "aws_instance" "master_instance" {
    for_each = tomap({
      xdevopsman-micro = "t3.micro",
      xdevopsman-small = "t3.small"
      xdevopsman-prod = "c7i-flex.large"
    })
    key_name = aws_key_pair.connect_key.key_name
    instance_type = each.value
    ami = var.ec2_ami_id
    security_groups = [aws_security_group.ansible_sg.name]

root_block_device {
  volume_size = var.env == "prod" ? 12 : var.ec2_root_volume_size
  volume_type = "gp3"
}

tags = {
  Name = each.key
  Environment= var.env
}
}