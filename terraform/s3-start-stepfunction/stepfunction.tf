data "aws_iam_policy_document" "step_function_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "step_function_role" {
  name               = "StepFunctionExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.step_function_trust.json
}

resource "aws_iam_role_policy" "step_function_logging" {
  role = aws_iam_role.step_function_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "logs:*",
      Resource = "*",
      Effect  = "Allow"
    }]
  })
}

resource "aws_sfn_state_machine" "machine" {
  name     = "S3EventStepFunction"
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    Comment = "Triggered by S3 Event",
    StartAt = "HelloWorld",
    States = {
      HelloWorld = {
        Type   = "Pass",
        Result = "Arquivo recebido com sucesso!",
        End    = true
      }
    }
  })
}
