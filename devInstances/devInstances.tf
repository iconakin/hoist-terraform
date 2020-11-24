# Create an EC2 instance
resource "aws_instance" "dev-server" {
  count         = 1
  ami           = "ami-00ddb0e5626798373"
  instance_type = "t2.micro"
  key_name      = "Camfield-KP"
  tags = {
    Name = "hoist-internal-development"
  }
}
