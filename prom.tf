provider "vultr" {
  api_key = "WE4TSWV47YW7CO63MOZTOH2P5BMYXHPNUWEA"
  rate_limit = 700
  retry_limit = 3
}

resource "vultr_ssh_key" "my_ssh_key" {
  name = "my-ssh-key"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC161MOpqIM+HRg4wVFhgmM3tVcmm0dFx5VTF3EZSHWkOY6qJrYQsUtEGIpDLWjG2AzXEZdDwCjmY+mCceJr9af+GoYNHUILnrCNWwP0hn1gSjGT8Vsr+tlt7E6RTQBvLSAxYK049cDQAGXim6TWHqzv/9nlm18sI5++5g6ytzqSR7yc7+SkD8fruKpT3YCoz26DdlN6NjbgKVdBniD5ol9WEArc8tguCrvseotJHYSUHNYhF4smbd39/tx42VyFpf3un21yJ7jyf0vgM5X6xRIJCDz7TWd4K80+cisVeclJhRJZErJnfOEDgW/XRs/ExK2o/Twe1Rm5/urAS8T0HxN rodfather@DESKTOP-7TDO7G3"
}

module "vpc" {
  source = "git::https://github.com/therodfather/Scripts.git"
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
    ssh_key_ids = ["my_ssh_key"]
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
