provider{
    name: "aws"
    region: "us-east-1"
}

resource "aws_ecs_cluster" "my_cluster" {
    name = "my_cluster"
}


resource "aws_ecs_service" "my_service" {
    name            = "my_service"
    cluster         = aws_ecs_cluster.my_cluster.id
    task_definition = aws_ecs_task_definition.my_task_definition.arn
    desired_count   = 1

    network_configuration {
        subnets = [aws_subnet.my_subnet.id]
        security_groups = [aws_security_group.my_security_group.id]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.my_target_group.arn
        container_name   = "my_container"
        container_port   = 80
    }
}

resource "aws_ecs_task_definition" "my_task_definition" {
    family                   = "my_task_definition"
    container_definitions    = jsonencode([{
        name      = "my_container"
        image     = "nginx:latest"
        cpu       = 256
        memory    = 512
        portMappings = [{
            containerPort = 80
            hostPort      = 80
        }]
    }])
}

resource "aws_lb_target_group" "my_target_group" {
    name     = "my_target_group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_security_group" "my_security_group" {
    name        = "my_security_group"
    vpc_id      = aws_vpc.my_vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["
    }

    tags = {
        Name = "my_security_group"
    }   

}



