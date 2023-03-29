module "newrelic" {
  source                  = "github.com/kubokkey/terraform-newrelic"
  newrelic_account_id     = var.NEWRELIC_ACCOUNT_ID
  newrelic_aws_account_id = var.NEWRELIC_AWS_ACCOUNT_ID
  newrelic_api_key        = var.NEWRELIC_API_KEY
}
