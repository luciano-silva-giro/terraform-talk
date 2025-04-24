# Cria uma instância EC2 usando um módulo oficial do Terraform
# Configura a instância com monitoramento, perfil IAM para SSM e um volume EBS
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "v5.7.1"

  name                        = "exemplo-2"
  instance_type               = "t3.micro"
  ami                        = "ami-005fc0f236362e99f" 
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.exemplo_sg.id]
  subnet_id                   = data.aws_subnet.public.id
  user_data                   = templatefile("./templates/user-data.tftpl", {})
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  root_block_device = [{
    volume_type           = "gp3"
    volume_size           = 10
    delete_on_termination = true
  }]
  tags = {
    name     = "exemplo-eip"
    ambiente = "devops"
  }
}

# Cria um grupo de segurança permitindo tráfego HTTP (porta 80) de entrada
# e todo tráfego de saída
resource "aws_security_group" "exemplo_sg" {
  name   = "exemplo"
  vpc_id = data.aws_vpc.this.id

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

  tags = {
    ambiente = "devops"
  }
}

# Cria um IP Elástico (EIP) na VPC
resource "aws_eip" "this" {
  domain = "vpc"
  tags = {
    name     = "exemplo-eip"
    ambiente = "devops"
  }
}

# Associa o IP Elástico criado à instância EC2
resource "aws_eip_association" "this" {
  instance_id   = module.ec2.id
  allocation_id = aws_eip.this.id
}