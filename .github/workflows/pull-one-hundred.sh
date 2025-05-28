#!/bin/bash

# Logout from Docker Hub registry
# echo "Logging out from Docker Hub registry..."
# regctl registry logout docker.io

# Check initial Docker Hub rate limits
#  regctl image ratelimit ubuntu:latest

# Initialize counter
counter=1

# Function to pull images
pull_images() {
    local round=$1
    echo "Starting Round $round..."
    
    images=(
        "alpine"
        "ubuntu"
        "nginx"
        "redis"
        "postgres"
        "node"
        "python"
        "golang"
        "mongo"
        "mysql"
        "busybox"
        "httpd"
        "debian"
        "traefik"
        "elasticsearch"
        "logstash"
        "kibana"
        "vault"
        "consul"
        "haproxy"
        "php"
        "ruby"
        "openjdk"
        "tomcat"
        "influxdb"
        "grafana/grafana"
        "prom/prometheus"
        "prom/alertmanager"
        "telegraf"
        "zookeeper"
        "cassandra"
        "rabbitmq"
        "bitnami/nginx"
        "bitnami/mariadb"
        "bitnami/redis"
        "bitnami/postgresql"
    )

    # Pull images sequentially
    for image in "${images[@]}"; do
        echo "Pull #$counter: Pulling $image..."
        if docker pull "docker.io/$image"; then
            echo "Successfully pulled $image"
            echo "Removing $image..."
            docker rmi "docker.io/$image" || true
        else
            echo "Failed to pull $image — skipping."
        fi
        ((counter++))
    done
}

# Run 8 rounds of pulls
for round in {1..8}; do
    pull_images $round
done

echo "All rounds completed!" 