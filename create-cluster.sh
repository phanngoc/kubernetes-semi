#!/bin/bash

# Define the pod DNS names
pod_names=(
  "redis-slave-0.redis-slave.learn-k8s.svc.cluster.local"
  "redis-slave-1.redis-slave.learn-k8s.svc.cluster.local"
  "redis-slave-2.redis-slave.learn-k8s.svc.cluster.local"
  "redis-master-0.redis-master.learn-k8s.svc.cluster.local"
  "redis-master-1.redis-master.learn-k8s.svc.cluster.local"
  "redis-master-2.redis-master.learn-k8s.svc.cluster.local"
)

# Initialize an array to store IPs
ips=()

# Function to perform nslookup and extract the IP address
get_ip() {
  nslookup $1 | grep 'Address: ' | grep -v '#' | awk '{print $2}'
}

# Retrieve the IP addresses for each pod
for pod in "${pod_names[@]}"; do
  ip=$(get_ip $pod)
  if [ -n "$ip" ]; then
    ips+=($ip)
  else
    echo "Failed to resolve IP for $pod"
    exit 1
  fi
done

# Join the Redis cluster using the resolved IPs
for ip in "${ips[@]}"; do
  kubectl exec -it redis-master-0 -n learn-k8s -- redis-cli CLUSTER MEET $ip 6379
done
