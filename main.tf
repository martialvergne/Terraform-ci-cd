# Pulls the image
resource "docker_image" "gitlab" {
  name = "gitlab/gitlab-ce:latest"
}

# Create Gitlab Network
resource "docker_network" "gitlab" {
  name = "gitlab"
}

# Create a container
resource "docker_container" "Gitlab" {
  image    = docker_image.gitlab.image_id
  name     = "Gitlab"
  restart  = "always
  volumes {
    host_path      = "${var.GITLAB_HOME}/config"
    container_path = "/etc/gitlab"
  }
  volumes {
    host_path      = "${var.GITLAB_HOME}/logs"
    container_path = "/var/log/gitlab"
  }
  volumes {
    host_path      = "${var.GITLAB_HOME}/data"
    container_path = "/var/opt/gitlab"
  }
  ports {
    internal = "80"
    external = "8080"
  }
  ports {
    internal = "443"
    external = "8443"
  }
}


# docker-compose.yml

    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost'

