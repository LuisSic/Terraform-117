
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "C:/Users/Luis Sic/.aws/credentials"
}
module "lambda" {
  source = "./modules/lambda"
  stack_name = "sluis"
  table_arn   = "${module.dynamoDb.table_arn}"
}
module "dynamoDb" {
  source = "./modules/dynamoDB"
}
module "apiGateway" {
  source = "./modules/apiGateway"
  lambda_get_arn = "${module.lambda.lambda_get_arn}"
  lambda_get_name = "${module.lambda.lambda_get_name}"
  lambda_post_arn = "${module.lambda.lambda_post_arn}"
  lambda_post_name = "${module.lambda.lambda_post_name}"
  lambda_delete_arn = "${module.lambda.lambda_delete_arn}"
  lambda_delete_name = "${module.lambda.lambda_delete_name}"
  lambda_update_arn = "${module.lambda.lambda_update_arn}"
  lambda_update_name = "${module.lambda.lambda_update_name}"
}


