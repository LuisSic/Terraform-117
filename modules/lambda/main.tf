data "archive_file" "lambda_post" {
  type        = "zip"
  source_dir  = "${path.module}/code/post"
  output_path = "${path.module}/lambda_post.zip"
}

data "archive_file" "lambda_delete" {
  type        = "zip"
  source_dir  = "${path.module}/code/delete"
  output_path = "${path.module}/lambda_delete.zip"
}
data "archive_file" "lambda_get" {
  type        = "zip"
  source_dir  = "${path.module}/code/get"
  output_path = "${path.module}/lambda_get.zip"
}

data "archive_file" "lambda_update" {
  type        = "zip"
  source_dir  = "${path.module}/code/put"
  output_path = "${path.module}/lambda_put.zip"
}
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role_${var.stack_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "apigateway.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name = "lambda-policy-sms-${var.stack_name}"
  role = "${aws_iam_role.lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "logs:*"
         ],
         "Resource": [
            "*"
         ]
      },
      {
         "Effect": "Allow",
         "Action": [
            "dynamodb:*"
         ],
         "Resource": [
            "${var.table_arn}"
         ]
      }
  ]
}
EOF
}

resource "aws_lambda_function" "post" {
  filename         = "${data.archive_file.lambda_post.output_path}"
  function_name    = "${var.stack_name}-postGame"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${filebase64sha256("${data.archive_file.lambda_post.output_path}")}"
  publish          = true
  timeout          = 5
}

resource "aws_lambda_function" "update" {
  filename         = "${data.archive_file.lambda_update.output_path}"
  function_name    = "${var.stack_name}-updateGame"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${filebase64sha256("${data.archive_file.lambda_update.output_path}")}"
  publish          = true
  timeout          = 5
}

resource "aws_lambda_function" "delete" {
  filename         = "${data.archive_file.lambda_delete.output_path}"
  function_name    = "${var.stack_name}-deleteGame"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${filebase64sha256("${data.archive_file.lambda_delete.output_path}")}"
  publish          = true
  timeout          = 5
}

resource "aws_lambda_function" "get" {
  filename         = "${data.archive_file.lambda_get.output_path}"
  function_name    = "${var.stack_name}-getGame"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${filebase64sha256("${data.archive_file.lambda_get.output_path}")}"
  publish          = true
  timeout          = 5
}