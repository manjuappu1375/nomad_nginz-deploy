job "nginx-demo" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count = 1

    scaling {
      enabled = true
      min     = 1
      max     = 5

      policy {
        cooldown            = "2m"
        evaluation_interval = "30s"

        check "cpu_usage" {
          source = "nomad-apm"
          query  = "avg_cpu"

          strategy "target-value" {
            target = 20
          }
        }

        check "memory_usage" {
          source = "nomad-apm"
          query  = "avg_memory"

          strategy "target-value" {
            target = 20
          }
        }
      }
    }

    network {
      port "http" {
        to = 80
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image      = "manjuappu1375/nginx-demo:latest"
        force_pull = true
        ports      = ["http"]
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}
