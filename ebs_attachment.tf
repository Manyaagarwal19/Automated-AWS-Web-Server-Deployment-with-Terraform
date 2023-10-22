resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.volvar.id
  instance_id = aws_instance.web01.id
}