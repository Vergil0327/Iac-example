output "ami_id" {
  value = "${aws_instance.relajet_kws_web.ami}"
}

output "availability_zone" {
  value = "${aws_instance.relajet_kws_web.availability_zone}"
}

output "instance_state" {
  value = "${aws_instance.relajet_kws_web.instance_state}"
}

output "instance_type" {
  value = "${aws_instance.relajet_kws_web.instance_type}"
}

output "instance_public_dns_name" {
  value = "${aws_instance.relajet_kws_web.public_dns}"
}

output "instance_public_ip" {
  value = "${aws_instance.relajet_kws_web.public_ip}"
}

output "instance_tags" {
  value = "${aws_instance.relajet_kws_web.tags}"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # #

output "s3_bucket_name" {
  value = "${aws_s3_bucket.terraform_state_storage_s3.id}"
}

output "s3_bucket_tags" {
  value = "${aws_s3_bucket.terraform_state_storage_s3.tags}"
}

output "s3_bucket_domain_name" {
  value = "${aws_s3_bucket.terraform_state_storage_s3.bucket_domain_name}"
}

output "s3_bucket_region" {
  value = "${aws_s3_bucket.terraform_state_storage_s3.region}"
}
