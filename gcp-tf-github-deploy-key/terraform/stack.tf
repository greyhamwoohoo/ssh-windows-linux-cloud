resource "google_compute_instance" "linux_box" {
  name         = "linux-box"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      # https://cloud.google.com/compute/docs/images/os-details
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    sshKeys = "${var.linux_username}:${file(var.ssh_windows_to_linux_public_key_path)}",
  }

  # By having this here (instead of in metadata), the instance is recreated if metadata_startup_script changes
  metadata_startup_script = replace(templatefile("./bootstrapping/gcp-linux.txt",  { github_deploy_private_key_content = base64encode(file(var.github_deploy_key_private_key_path)), github_user_name = var.github_user_name, github_repo_name = var.github_repo_name, github_commit = var.github_commit }), "\r", "")
}

resource "google_compute_instance" "windows_box" {
  name         = "windows-box"
  machine_type = "e2-small"

  boot_disk {
    initialize_params {
      # https://cloud.google.com/compute/docs/images/os-details
      image = "windows-cloud/windows-2019"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  # It isn't obvious to me how to use the metadata_startup_script equivalent for Windows (is it possible?)
  # Without that: every change to the metadata requires a 'terraform taint google_computer_instance.windows_box' before the apply or the changes do not kick in
  metadata = {
    # Sysprep level (runs exactly once)
    sysprep-specialize-script-ps1 = file("./bootstrapping/sysprep-specialize-windows-2019.txt")

    # Runs every time on startup
    windows-startup-script-ps1 = templatefile("./bootstrapping/startup-windows-2019.txt",  { github_deploy_private_key_content = file(var.github_deploy_key_private_key_path), github_user_name = var.github_user_name, github_repo_name = var.github_repo_name, github_commit = var.github_commit })

    # Reasonably insecure - https://cloud.google.com/compute/docs/storing-retrieving-metadata; but probably OK for test environment(s)
    private-key-content = file(var.ssh_windows_to_linux_private_key_path)
  }
}
