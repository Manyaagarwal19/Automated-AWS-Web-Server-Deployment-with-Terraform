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



