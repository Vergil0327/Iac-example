output "ami_id" {
  value = "${aws_instance.example.ami}"
}

output "availability_zone" {
  value = "${aws_instance.example.availability_zone}"
}

output "instance_state" {
  value = "${aws_instance.example.instance_state}"
}

output "instance_type" {
  value = "${aws_instance.example.instance_type}"
}

output "public_dns_name" {
  value = "${aws_instance.example.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}

output "tags" {
  value = "${aws_instance.example.tags}"
}
