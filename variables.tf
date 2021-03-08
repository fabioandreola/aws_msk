variable "vpc_id" {
    description = "The vpc id for the MSK cluster"
}

variable "subnet_az1" {
    description = "Subnet for AZ1"
}

variable "subnet_az2" {
    description = "Subnet for AZ2"
}

variable "instance_type" {
    description = "The MSK instance type"
    default = "kafka.t3.small"
}

variable "kafka_version" {
    description = "The Kafka version to be provisioned"
    default = "2.2.1"
}

variable "kafka_cluster_name" {
     description = "The name for the MSK cluster"
}

variable "kafka_sg_ingress_cidr" {
    description = "The allowed IP to access this Kafka cluster"
}

variable "kafka_client_instance_type" {
    description = "Instance type for the EC2 kafka client"
    default = "t2.micro"
}