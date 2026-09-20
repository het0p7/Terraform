# key pair

resource "aws_key_pair" "deployer" {
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
}

# ec2 instance