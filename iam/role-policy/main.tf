resource "aws_iam_role_policy" "policy" {
  name        = "${var.name}"
  role = "${var.role}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        ${var.action}
      ],
      "Effect": "${var.effect}",
      "Resource": "${var.resource}"
    }
  ]
}
EOF
}
