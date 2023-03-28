resource "newrelic_cloud_aws_link_account" "sample" {
  account_id = var.NEWRELIC_ACCOUNT_ID
  arn        = aws_iam_role.newrelic_integrations.arn
  #PULL の場合は API polling になり PUSH の場合は Metric Streams での転送設定になります。
  metric_collection_mode = "PULL"
  name                   = "sample"

  # IAM Role や Policy を先に作成しないと実際に連携する際に権限不足になってしまうので作成するまで待つようにします。
  depends_on = [
    aws_iam_role.newrelic_integrations,
    data.aws_iam_policy_document.budget_access,
    data.aws_iam_policy_document.newrelic_integrations,
    aws_iam_role_policy_attachment.read_only_access
  ]
}

resource "newrelic_cloud_aws_integrations" "sample" {
  linked_account_id = newrelic_cloud_aws_link_account.sample.id
  billing {}
  cloudtrail {
    metrics_polling_interval = 6000
    aws_regions              = ["ap-northeast-1"]
  }
  health {
    metrics_polling_interval = 6000
  }
  trusted_advisor {
    metrics_polling_interval = 6000
  }
  vpc {
    metrics_polling_interval = 6000
    aws_regions              = ["ap-northeast-1"]
    fetch_nat_gateway        = true
    fetch_vpn                = false
    tag_key                  = "tag key"
    tag_value                = "tag value"
  }
  x_ray {
    metrics_polling_interval = 6000
    aws_regions              = ["ap-northeast-1"]
  }
}

resource "aws_iam_role" "newrelic_integrations" {
  name               = "NewRelicInfrastructure-Integrations-${var.NEWRELIC_ACCOUNT_ID}"
  assume_role_policy = data.aws_iam_policy_document.newrelic_integrations.json
}

data "aws_iam_policy_document" "newrelic_integrations" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    condition {
      test = "StringEquals"
      // NewRelic AccountID
      values   = [var.NEWRELIC_ACCOUNT_ID]
      variable = "sts:ExternalID"
    }

    principals {
      identifiers = [var.NEWRELIC_AWS_ACCOUNT_ID]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role_policy_attachment" "read_only_access" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.newrelic_integrations.id
}

resource "aws_iam_role_policy" "view_budget_access" {
  name   = "view-budget-access"
  policy = data.aws_iam_policy_document.budget_access.json
  role   = aws_iam_role.newrelic_integrations.id
}

data "aws_iam_policy_document" "budget_access" {
  statement {
    actions   = ["budgets:ViewBudget"]
    effect    = "Allow"
    resources = ["*"]
  }
  version = "2012-10-17"
}
