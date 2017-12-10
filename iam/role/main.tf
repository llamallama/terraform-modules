resource "aws_iam_role" "role" {
  name = "${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "${var.action}",
      "Principal": {
        "Service": "${var.service}"
      },
      "Effect": "${var.effect}",
      "Sid": "${var.sid}"
    }
  ]
}
EOF
}
