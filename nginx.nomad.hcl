job "nginx-demo" {

  datacenters = ["dc1"]

  type = "service"

  group "web" {

    count = 1

    network {
      port "http" {
        static = 81
      }
    }

    task "nginx" {

      driver = "docker"

      config {
        image = "manjuappu1375/nginx-demo:56b74c3"
        force_pull = true
        ports = ["http"]
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
