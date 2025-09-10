terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_ecs_cluster" "idp_cluster" {
  name = "my-idp-cluster"
}
resource "aws_ecs_task_definition" "idp_task" {
  family = "my-idp-task"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  execution_role_arn = "arn:aws:iam::429554648388:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([{
    name  = "idp-service"
    image = "hstanslalom/idp-service:latest"
    essential = true
    portMappings = [{ containerPort = 3000, hostPort = 3000, protocol = "tcp" }]
  }])
}
resource "aws_ecs_service" "idp_service" {
  name            = "my-idp-service"
  cluster         = aws_ecs_cluster.idp_cluster.id
  task_definition = aws_ecs_task_definition.idp_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-646f9228"]
    security_groups  = ["sg-812ec490"]
    assign_public_ip = true
  }
}