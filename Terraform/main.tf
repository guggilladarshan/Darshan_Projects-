resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_id

tags = {
    name = "my_vpc"
   }
}


resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidir

    map_public_ip_on_launch = true

    tags = {
        name = "my_subnet"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        name = "my_igw"
    }
}

resource "aws_route_table" "public_rt" {
     vpc_id = aws_vpc.my_vpc.id
     
     route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
     }

     tags = {
        name = "public_rt"
     }
}


resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id = aws_subnet.my_subnet.id
    route_table_id = aws_route_table.public_rt.id
}


resource "aws_security_group" "my_sg" {
    name = "myec2_sg"
    vpc_id = aws_vpc.my_vpc.id
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    
    }

     egress {
         from_port   = 0
         to_port     = 0
         protocol    = "-1"
         cidr_blocks = ["0.0.0.0/0"]
     }
}


resource "aws_instance" "my_instance" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.my_subnet.id
    security_groups = [aws_security_group.my_sg.id]
tags = {
    name = "Terrsform_EC2"
}
}

