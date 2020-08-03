provider "vultr" {
  api_key = "WE4TSWV47YW7CO63MOZTOH2P5BMYXHPNUWEA"
  rate_limit = 700
  retry_limit = 3
}

module "vpc" {
  source = "git::https://github.com/therodfather/Scripts.git"
}

data "vultr_ssh_key" "my_ssh_key" {
  filter {
    name   = "my_ssh_key"
    values = ["my_ssh_key"]
  }
}
  
resource "vultr_server" "my_server" {
    plan_id = "201"
    region_id = "6"
    os_id = "387"
    label = "Prom1"
    tag = "promtest"
    hostname = "Promo1"
    enable_ipv6 = false
    auto_backup = false
    ddos_protection = false
    notify_activate = false
    ssh_key_ids = ["${data.vultr_ssh_key.my_ssh_key.id}"]
    provisioner "file" {
      source      = "installpro.sh"
      destination = "/tmp/script.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/script.sh",
        "/tmp/script.sh args",
      ]
    }
}

output "vultr_server" {
  value = "Installation finished"
}
