provider "aws" {
    region = "eu-west-1"
}


resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm_profile"
  role = "EC2RoleForSSM"
}

resource "aws_instance" "kafka-client" {
  ami           = "ami-096f43ef67d75e998"
  instance_type = var.kafka_client_instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg-kafka.id]
  subnet_id = var.subnet_az1
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name = "Kafka client"
  }
}

resource "aws_security_group" "sg-kafka" {
  vpc_id = var.vpc_id

  ingress {
    description = "Kafka access"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = var.kafka_sg_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_kms_key" "kms" {
  description = "msk key"
}

resource "aws_msk_cluster" "kafka_cluster" {
  cluster_name           = var.kafka_cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = var.instance_type
    ebs_volume_size = 1
    client_subnets = [
      var.subnet_az1,
      var.subnet_az2
    ]
    security_groups = [aws_security_group.sg-kafka.id]
  }

  encryption_info {
      encryption_in_transit {
        client_broker = "TLS_PLAINTEXT"
      }
  }

  tags = {
    Name = "kafka upgrade demo"
  }
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.kafka_cluster.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "Kafka connection host:port pairs"
  value       = aws_msk_cluster.kafka_cluster.bootstrap_brokers
}
