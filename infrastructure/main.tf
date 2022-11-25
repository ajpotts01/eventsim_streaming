terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 2.13.0"
        }
    }
}

provider "docker" {
    host = "npipe:////.//pipe//docker_enging"
}

resource "docker_image" "eventsim" {
    name = "eventsim_streaming:dev"
    keep_locally = false
}

resource "docker_container" "nginx" {
    image = docker_image.eventsim.dev
    name = "eventsim_streaming_infra"
    ports {
        internal = 80
        external = 8000
    }
}