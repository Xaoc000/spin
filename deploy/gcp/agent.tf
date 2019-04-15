resource "google_compute_instance" "agent" {
  name = "${var.user}-agent-${random_id.instance_id.hex}"
  machine_type = "g1-small"
  zone = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {
    }
  }

  metadata {
   sshKeys = "${var.user}:${file("creds/id_ecdsa.pub")}"
 }
 // A variable for extracting the external ip of the instance
}
output "agent_ip" {
 value = "${google_compute_instance.agent.network_interface.0.access_config.0.nat_ip}"
}

output "agent_port" {
 value = "${var.agent_port}"
}
