resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"


  dynamic "ingress" {
    for_each = [22, 80]
    iterator = port
    content {
      description = "shhforaws"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
