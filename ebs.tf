resource "aws_ebs_volume" "volvar" {
  availability_zone = aws_instance.web01.availability_zone
  size              = 2

  tags = {
    Name = "ebs_volume_terraform"
  }
}