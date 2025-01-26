resource "aws_instance" "web" {
    ami = var.ami
    count = var.ec2_count
    key_name = aws_key_pair.key.id
    subnet_id = element(var.public_subnet_ids, count.index % 2)
    vpc_security_group_ids = [
        var.internal_sg_id,
        var.internal_sg2_id
    ]
    instance_type = var.instance_type
    user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    echo "<html><body>Hello World!</body></html>" > /var/www/html/index.html
    systemctl enable --now httpd
    EOF
    root_block_device {
        volume_type = var.volume_type
        volume_size = var.volume_size
    }
    tags = {
        Name = "${var.env}-test.ec2"
    }
}

resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC++L6RVhDfHnPVZwrnpKYmLmNIX50kKLEAK+s99YUCK6ftPi9k8EKFLKRz6RXfAZkfLTzm/4akSfNjG7/5rUNAVuZoTJ821YPDkjXSQn2TzXngnB2nQHC/PRHE5CizeZmwo8KwxUzoeLwUsSY0NvkSxmQMxMuSQ8AkJFtCknZb9PNFd8v5dVU5yValOouOBrRn+E54hG4c0D4Iw8e3BBEYzXGRtpzXjlMBZNv024HOFfRnoLpxqc7b0/m5ZkOVf5TKNQgoymilD9mV4IBrCffnEW+3ihI25KEqaGqMrH788tebd4Tn4I3EBK/tvDASpUIFnIq+lxjXZFhZXnQXVUWa4ZZ+M4c0J4KKjSakmQPzo3dL/eZV6b29N5b4c22CMSB9C2jo8sM54Yma0TXvtGp3CWoEsfbrXglYutiln+rzWLgN6XcwHWMyIyxYtSRVmcCzJnLQ5Vqc2ZGUXqCpRKwoCJsdZpwVttzy0FLdRd8RxbES5pFfGs3xtwpx58RmhEHMt0iJlv5ApCZh7jhayoMu5pXveS9SaVgAke/dOQCBkGt8xWXzXeG/AyKsysc5QWP+JSJ5hoeMVTkBIZy6R9AP881XjOHgcJBoxqPbp05S3Cgv+8jxKd6VTpGsQHXhoOlU5hqiK5n5yftUFwu38v/VyWaWtNNoz+J9pZjtqGzuDQ== hayashi-terraform-key"
}
