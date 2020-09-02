
resource "digitalocean_droplet" "test-01" {
  image = "centos-8-x64"
  name = "test-01"
  region = "nyc1"
  size = "s-2vcpu-4gb"
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.do-terraform-keypair.id
  ]

connection {
  host = self.ipv4_address
  user = "root"
  type = "ssh"
  private_key = file(var.pvt_key)
  timeout = "2m"
}

provisioner "remote-exec" {
  inline = [
    "export PATH=$PATH:/usr/bin",
    #install nginx
    "sudo yum -y update",
    "sudo yum -y install vim wget curl"
    ]
  }
}

