# Create the main EC2 instance
# https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "this" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = local.availability_zone
  key_name               = aws_key_pair.this.id # the name of the SSH keypair to use for provisioning
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  subnet_id              = data.aws_subnet.this.id
  user_data              = sha1(local.reprovision_trigger) # this value isn't used by the EC2 instance, but its change will trigger re-creation of the resource
  tags                   = merge(var.tags, tomap({ "Name" = "${var.hostname}" }))
  volume_tags            = merge(var.tags, tomap({ "Name" = "${var.hostname}" })) # give the root EBS volume a name (+ other possible tags) that makes it easier to identify as belonging to this host

  root_block_device {
    volume_size = var.root_volume_size
  }

  connection {
    host        = self.public_ip
    user        = var.ssh_username
    private_key = file("${var.ssh_private_key_path}")
    agent       = false # don't use SSH agent because we have the private key right here
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.hostname}",
      "echo 127.0.0.1 ${var.hostname} | sudo tee -a /etc/hosts", # https://askubuntu.com/a/59517
    ]
  }

  provisioner "remote-exec" {
    script = "provision-docker.sh"
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  vpc      = true
}
