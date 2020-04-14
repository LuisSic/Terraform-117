  
output "lambda_get_arn" {
  value = "${aws_lambda_function.get.invoke_arn}"
}
output "lambda_get_name" {
  value = "${aws_lambda_function.get.function_name}"
}

output "lambda_post_arn" {
  value = "${aws_lambda_function.post.invoke_arn}"
}
output "lambda_post_name" {
  value = "${aws_lambda_function.post.function_name}"
}

output "lambda_delete_arn" {
  value = "${aws_lambda_function.delete.invoke_arn}"
}
output "lambda_delete_name" {
  value = "${aws_lambda_function.delete.function_name}"
}

output "lambda_update_arn" {
  value = "${aws_lambda_function.update.invoke_arn}"
}
output "lambda_update_name" {
  value = "${aws_lambda_function.update.function_name}"
}