resource "aws_budgets_budget" "budget_total" {
  name              = "Month_budget"
  budget_type       = "COST"
  limit_amount      = "120"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2022-04-01_00:00"
  time_unit         = "MONTHLY"

  

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["karasekkarasek97@gmail.com"]
  }
}
