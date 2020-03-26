#
# MASTER
#

resource "aws_security_group" "elasticsearch_master" {
  name        = "elasticsearch-${var.cluster_name}-master"
  description = "Elasticsearch master group for ${var.cluster_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "elasticsearch-${var.cluster_name}-master"
    cluster = var.cluster_name
  }
}

# self: tcp/9300-9300
resource "aws_security_group_rule" "elasticsearch_master_self_9300" {
  security_group_id = aws_security_group.elasticsearch_master.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9300
  to_port           = 9300
  self              = true
}

# Rules to allow monitoring
resource "aws_security_group_rule" "monitoring_elasticsearch_master_9200" {
  security_group_id        = aws_security_group.elasticsearch_master.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9200
  to_port                  = 9200
  source_security_group_id = var.monitor_security_group_id
  description              = "Monitoring"
}

resource "aws_security_group_rule" "monitoring_elasticsearch_data_9200" {
  security_group_id        = aws_security_group.elasticsearch_data.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9200
  to_port                  = 9200
  source_security_group_id = var.monitor_security_group_id
  description              = "Monitoring"
}

# Egress Rule

resource "aws_security_group_rule" "elasticsearch_master_egress_all" {
  security_group_id = aws_security_group.elasticsearch_master.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

#
# DATA
#

resource "aws_security_group" "elasticsearch_data" {
  name        = "elasticsearch-${var.cluster_name}-data"
  description = "Elasticsearch data group for ${var.cluster_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "elasticsearch-${var.cluster_name}-data"
    cluster = var.cluster_name
  }
}

resource "aws_security_group_rule" "elasticsearch_data_elb_9200" {
  security_group_id = aws_security_group.elasticsearch_data.id

  source_security_group_id = aws_security_group.elb.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9200
  to_port                  = 9200
}

# Used Defined Ingress CIDRs
resource "aws_security_group_rule" "elasticsearch_data_user_cidrs_9200" {
  count = length(var.source_cidrs) > 0 ? 1 : 0

  security_group_id = aws_security_group.elasticsearch_data.id
  cidr_blocks       = var.source_cidrs
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9200
  to_port           = 9200
}

# Used Defined Ingress Groups
resource "aws_security_group_rule" "elasticsearch_master_elasticsearch_data_9300" {
  security_group_id        = aws_security_group.elasticsearch_data.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9300
  to_port                  = 9300
  source_security_group_id = aws_security_group.elasticsearch_master.id
}

# self: tcp/9300-9300
resource "aws_security_group_rule" "elasticsearch-data_self_9300" {
  security_group_id = aws_security_group.elasticsearch_data.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9300
  to_port           = 9300
  self              = true
}

# Egress Rule

resource "aws_security_group_rule" "elasticsearch-data_egress_all" {
  security_group_id = aws_security_group.elasticsearch_data.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

