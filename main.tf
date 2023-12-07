resource "aws_key_pair" "mykey" {
  key_name   = "${var.project_name}-${var.project_env}-key"
  public_key = file("mykey.pub")

    tags = {
    Name    = "${var.project_name}-${var.project_env}"
    Project = var.project_name
    Env = var.project_env
    }
}

