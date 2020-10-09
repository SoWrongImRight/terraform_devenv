
resource "digitalocean_droplet" "test-01" {
  image = "centos-8-x64"
  name = "test-01"
  region = "nyc1"
  size = "s-2vcpu-4gb"
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform_do.id
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
    #install programs
    "sudo yum -y update",
    "sudo yum install -y epel-release",
    "sudo yum -y install vim wget git python3 snapd",
    "sudo yum -y install snapd",
    "sudo systemctl enable --now snapd.socket",
    "sudo ln -s /var/lib/snapd/snap /snap",
    "sudo snap install heroku --classic",
    "sudo rebbot"
    ]
  }
}

