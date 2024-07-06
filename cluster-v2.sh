#!/bin/sh

# Function to perform nslookup and extract the IP address
get_ip() {
  local pod="$1"
  nslookup "$pod" | grep 'Address: ' | grep -v '#' | awk '{print $2}'
}

# Function to join Redis cluster node
join_cluster() {
  local node="$1"
  local ip="$2"
  echo "Check if Redis at $ip is accepting connections on port 6379"
  while ! nc -z "$ip" 6379; do
    echo "Waiting for Redis at $ip to be ready..."
    sleep 5
  done
  echo "Redis at $ip is ready. Joining the cluster..."
  redis-cli -h redis-master-0.redis-master.learn-k8s.svc.cluster.local CLUSTER MEET "$ip" 6379
}

# Function to set up replication
setup_replication() {
  local slave="$1"
  local master_node=$(echo "$slave" | sed 's/redis-slave/redis-master/')
  echo "Setting up replication for $slave to $master_node"
  redis-cli --cluster replicate "$master_node"
}

# Function to fix slots for master nodes
fix_slots() {
  local master="$1"
  echo "Fixing slots for $master"
  echo "yes" | redis-cli --cluster fix "$master":6379 --cluster-yes
}

# Main script
echo "Start script assign slots to master nodes"

pod_names="redis-master-0.redis-master.learn-k8s.svc.cluster.local
redis-master-1.redis-master.learn-k8s.svc.cluster.local
redis-master-2.redis-master.learn-k8s.svc.cluster.local
redis-slave-0.redis-slave.learn-k8s.svc.cluster.local
redis-slave-1.redis-slave.learn-k8s.svc.cluster.local
redis-slave-2.redis-slave.learn-k8s.svc.cluster.local"

# Join the Redis cluster and set up replication
for pod in $pod_names; do
  ip=$(get_ip "$pod")
  echo "Resolved IP for $pod: $ip"
  if [ -n "$ip" ]; then
    if echo "$pod" | grep -q "redis-master"; then
      join_cluster "$pod" "$ip"
      fix_slots "$pod"
    elif echo "$pod" | grep -q "redis-slave"; then
      setup_replication "$pod"
    else
      echo "Unknown pod type for $pod"
      exit 1
    fi
  else
    echo "Failed to resolve IP for $pod"
    exit 1
  fi
done

echo "Done"
