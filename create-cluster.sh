#!/bin/sh

echo "Start script assign slots to master nodes"

pod_names="
  redis-slave-0.redis-slave.learn-k8s.svc.cluster.local
  redis-slave-1.redis-slave.learn-k8s.svc.cluster.local
  redis-slave-2.redis-slave.learn-k8s.svc.cluster.local
  redis-master-1.redis-master.learn-k8s.svc.cluster.local
  redis-master-2.redis-master.learn-k8s.svc.cluster.local
"

# Initialize arrays to store master and slave nodes
masters=()
slaves=()

# Initialize an array to store IPs
ips=""

# Function to perform nslookup and extract the IP address
get_ip() {
  nslookup $1 | grep 'Address: ' | grep -v '#' | awk '{print $2}'
}

# Retrieve the IP addresses for each pod
for pod in $pod_names; do
  ip=$(get_ip $pod)
  if [ -n "$ip" ]; then
    ips="$ips $ip"
  else
    echo "Failed to resolve IP for $pod"
    exit 1
  fi
done

# Join the Redis cluster using the resolved IPs
for ip in $ips; do
  # Check if Redis is accepting connections on port 6379
  while ! nc -z "$ip" 6379; do
    echo "Waiting for Redis at $ip to be ready..."
    sleep 5
  done
  echo "Redis at $ip is ready. Joining the cluster..."
  redis-cli CLUSTER MEET $ip 6379
done

echo "Fix slots"
echo "yes" | redis-cli --cluster fix 127.0.0.1:6379 --cluster-yes

echo "Done"
 