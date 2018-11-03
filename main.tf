provider "openstack" {
    user_name   = ""
    tenant_name = ""
    password    = ""
    auth_url    = "https://identity.tyo1.conoha.io/v2.0"
}

resource "openstack_compute_instance_v2" "basic" {
    name = "basic"
    image_name  = "vmi-ubuntu-18.04-amd64-amd64-20gb"
    flavor_name = "g-512mb"
    key_pair    = "ed-key"

    security_groups = [
        "${openstack_networking_secgroup_v2.secgroup_1.name}",
    ]

    network {
        port = "${openstack_networking_port_v2.port_1.id}"
    }

    metadata {
        instance_name_tag = "test"
    }
}
