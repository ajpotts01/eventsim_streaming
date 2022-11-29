####
# ECS INSTANCE - VPC/SECURITY GROUP
####
resource "aws_default_vpc" "default" {
}

resource "aws_subnet" "default_subnet" {
    vpc_id                  = aws_default_vpc.default.id
    cidr_block              = "172.31.0.0/20"
}

resource "aws_security_group" "service_security_group" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.app_name}-service-sg"
    Environment = var.app_environment
  }
}

####
# ECS INSTANCE - IAM ROLE
####
data "aws_iam_policy_document" "assume_role_policy" {
    statement {
        actions = ["sts:AssumeRole"]

        effect = "Allow"

        principals {
          type = "Service"
          identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "ecsInstanceRole" {
    name = "ecsInstanceRole"
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

    # Does this need tags?
    tags = {
        Name        = "${var.app_name}-iam"
        Environment = var.app_environment
    }
}

resource "aws_iam_policy_attachment" "ecsInstanceRole_policy" {
    name = "${var.app_name}-${var.app_environment}-iam-policy"
    roles = [aws_iam_role.ecsInstanceRole.name]
    #policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecsInstanceRole_profile" {
  name = "ecs-agent"
  role = aws_iam_role.ecsInstanceRole.name
}

####
# ECS INSTANCE - CLOUDWATCH LOGGING
####
resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.app_name}-${var.app_environment}-logs"

  tags = {
    Application = var.app_name
    Environment = var.app_environment
  }
}

####
# ECS INSTANCE - ECR REPOSITORY
####
resource "aws_ecr_repository" "eventsim_streaming" {
    name = "${var.app_name}-${var.app_environment}-ecr"
    image_tag_mutability = "MUTABLE" # AWS default
    force_delete = true

    image_scanning_configuration {
      scan_on_push = false # AWS default
    }
}

####
# ECS INSTANCE - EC2 INSTANCE/AUTOSCALING SET
####
resource "aws_launch_configuration" "ecs_launch_config" {
  image_id = "ami-06bb074d1e196d0d4"
  user_data = "#!/bin/bash\necho \"ECS_CLUSTER=${var.app_name}-${var.app_environment}-ecs\" >> /etc/ecs/ecs.config"
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceRole_profile.name
  security_groups = [aws_security_group.service_security_group.id]
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "ecs_asg" {
  name = "asg"
  vpc_zone_identifier = [aws_subnet.default_subnet.id]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name
  desired_capacity = 1
  min_size = 1
  max_size = 1
  health_check_grace_period = 300
  health_check_type = "EC2"
}

####
# ECS INSTANCE - ECS CLUSTER
####
resource "aws_ecs_cluster" "eventsim-streaming-cluster" {
  name = "${var.app_name}-${var.app_environment}-ecs"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
}

resource "aws_ecs_task_definition" "eventsim-streaming-task" {
  family = "${var.app_name}-task"

  # NOTE: "cpu: 256 = 0.5 vCPU"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.app_name}-${var.app_environment}-container",
      "image": "${aws_ecr_repository.eventsim_streaming.repository_url}:dev",
      "entryPoint": [],
      "environment": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "ap-southeast-2",
          "awslogs-stream-prefix": "${var.app_name}-${var.app_environment}"
        }
      },
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecsInstanceRole.arn
  task_role_arn            = aws_iam_role.ecsInstanceRole.arn

  tags = {
    Name        = "${var.app_name}-ecs-td"
    Environment = var.app_environment
  }
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.eventsim-streaming-task.family
}

resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.app_name}-${var.app_environment}-ecs-service"
  cluster              = aws_ecs_cluster.eventsim-streaming-cluster.id
  task_definition      = "${aws_ecs_task_definition.eventsim-streaming-task.family}:${max(aws_ecs_task_definition.eventsim-streaming-task.revision, data.aws_ecs_task_definition.main.revision)}"
  desired_count        = 1
  force_new_deployment = true
  launch_type = "EC2"

  network_configuration {
    subnets = [aws_subnet.default_subnet.id]
    #assign_public_ip = true
    security_groups = [ aws_security_group.service_security_group.id ]
  }

#   network_configuration {
#     subnets          = aws_subnet.private.*.id
#     assign_public_ip = false
#     security_groups = [
#       aws_security_group.service_security_group.id,
#       aws_security_group.load_balancer_security_group.id
#     ]
#   }
}