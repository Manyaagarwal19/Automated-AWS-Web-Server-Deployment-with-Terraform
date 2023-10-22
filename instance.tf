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


resource "aws_instance" "web01" {
  ami                    = "ami-0df435f331839b2d6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name               = "keyterr"
  tags = {
    Name = "webos"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./keyterr.pem")
    host        = aws_instance.web01.public_dns
    agent       = false
  }

  provisioner "remote-exec" {
    # script = "./script.sh"#
    inline = [
      "sudo mkdir manya",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo mkfs.ext4 /dev/sdb",
      "sudo mount /dev/sdb /var/www/html",
      "sudo yum install git -y",
      "sudo git clone https://github.com/Manyaagarwal19/php.git  /var/www/html/web",
    ]

  }
}



