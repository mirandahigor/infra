provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my_cluster"
}

resource "aws_ecs_service" "my_service" {
  name            = "my_service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1
  depends_on      = [aws_ecs_task_definition.my_task_definition]

  network_configuration {
    subnets          = [aws_subnet.my_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = "my_container"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "my_task_definition" {
  family                = "my_task_definition"
  container_definitions = jsonencode([{
    name      = "my_container"
    image     = "nginx:latest"
    cpu       = 256
    memory    = 512
    portMappings = [{
      containerPort = 80
    }
    ]
    }])     


