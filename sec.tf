resource "openstack_networking_network_v2" "network_1" {
    name = "network_1"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
    name = "subnet_1"
    network_id = "${openstack_networking_network_v2.network_1.id}"
    cidr = "192.168.99.0/24"
    ip_version = 4
}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
    name = "secgroup_1"
    description = "secgroup test"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "126.66.16.0/24"
    security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}


resource "openstack_networking_port_v2" "port_1" {
    name =  "port_1"
    network_id = "${openstack_networking_network_v2.network_1.id}"
    security_group_ids = ["${openstack_networking_secgroup_v2.secgroup_1.id}"]

    fixed_ip {
        "subnet_id" = "${openstack_networking_subnet_v2.subnet_1.id}"
        "ip_address" = "192.168.99.1"
    }
}
