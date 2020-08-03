provider "vultr" {
  api_key = "WE4TSWV47YW7CO63MOZTOH2P5BMYXHPNUWEA"
  rate_limit = 700
  retry_limit = 3
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
}

module "consul" {
  source = "https://github.com/therodfather/Scripts/blob/master/installpro.sh"
  user_data = "${file("installpro.sh")}"
}

output "vultr_server" {
  value = "Installation finished"
}
