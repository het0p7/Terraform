# key pair

resource "aws_key_pair" "my_key" {
     key_name   = "terra-key-ec2"
     public_key = file("terra-key-ec2.pub")
} 

# VPC & security

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group" {
     name = "automate-sg"
     description = "this is tf generated"
     vpc_id = aws_default_vpc.default.id

     # inbound rules
     ingress {
          from_port = 22
          to_port = 22
          protocol = "tcp"
          cidr_blocks = [ "0.0.0.0/0" ]
          description = "SSH open"
     }

      ingress {
          from_port = 80
          to_port = 80
          protocol = "tcp"
          cidr_blocks = [ "0.0.0.0/0" ]
          description = "http open"
     }

     ingress {
          from_port = 8000
          to_port = 8000
          protocol = "tcp"
          cidr_blocks = [ "0.0.0.0/0" ]
          description = "flask app"
     }


     # outbound rules
     egress {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = [ "0.0.0.0/0" ]
          description = "all access"
     }

     tags = {
          Name = "automated-sg"
     }
}

# ec2 instance

resource "aws_instance" "my_instance" {
     key_name = aws_key_pair.my_key.key_name
     security_groups = [aws_security_group.my_security_group.name]
     instance_type = "t3.micro"
     ami = "ami-01a00762f46d584a1"

     root_block_device {
       volume_size = 15
       volume_type = "gp3"
     }

     tags = {
          Name = "terraform"
     }
     

  
}