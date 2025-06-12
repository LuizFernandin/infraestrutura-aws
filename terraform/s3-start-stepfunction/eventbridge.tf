resource "aws_cloudwatch_event_rule" "s3_object_created" {
  name        = "S3PutObjectEventRule"
  description = "Dispara Step Function quando um objeto é criado no S3"
  event_pattern = jsonencode({
    source      = ["aws.s3"],
    "detail-type" = ["Object Created"],
    detail = {
      bucket = {
        name = [aws_s3_bucket.bucket.bucket]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "sfn_target" {
  rule      = aws_cloudwatch_event_rule.s3_object_created.name
  target_id = "StepFunctionExecution"
  arn       = aws_sfn_state_machine.machine.arn
  role_arn  = aws_iam_role.eventbridge_invoke_stepfn.arn
}
