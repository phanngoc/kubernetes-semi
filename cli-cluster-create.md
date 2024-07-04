## Check ip cluster of pods

```
nslookup redis-slave-0.redis-slave.learn-k8s.svc.cluster.local
nslookup redis-slave-1.redis-slave.learn-k8s.svc.cluster.local
nslookup redis-slave-2.redis-slave.learn-k8s.svc.cluster.local
nslookup redis-master-0.redis-master.learn-k8s.svc.cluster.local
nslookup redis-master-1.redis-master.learn-k8s.svc.cluster.local
nslookup redis-master-2.redis-master.learn-k8s.svc.cluster.local
```

## Create a redis cluster

CLUSTER MEET 10.244.1.163 6379
CLUSTER MEET 10.244.1.165 6379
CLUSTER MEET 10.244.1.167 6379
CLUSTER MEET 10.244.1.166 6379
CLUSTER MEET 10.244.1.168 6379

kubectl exec -it redis-master-0 -n learn-k8s -- sh redis-cli CLUSTER MEET 10.96.0.10 6379
kubectl exec -it redis-master-0 -n learn-k8s -- sh redis-cli CLUSTER MEET 10.244.1.165 6379



redis-cli --cluster create \
  redis-master-0.redis-master.learn-k8s.svc.cluster.local:6379 \
  redis-master-1.redis-master.learn-k8s.svc.cluster.local:6379 \
  redis-master-2.redis-master.learn-k8s.svc.cluster.local:6379 \
  redis-slave-0.redis-slave.learn-k8s.svc.cluster.local:6379 \
  redis-slave-1.redis-slave.learn-k8s.svc.cluster.local:6379 \
  redis-slave-2.redis-slave.learn-k8s.svc.cluster.local:6379 \
  --cluster-replicas 1

nslookup redis-master-0.redis-master.learn-k8s.svc.cluster.local
nslookup redis-master-1.redis-master.learn-k8s.svc.cluster.local
nslookup redis-master-2.redis-master.learn-k8s.svc.cluster.local
nslookup redis-slave-0.redis-slave.learn-k8s.svc.cluster.local
nslookup redis-slave-1.redis-slave.learn-k8s.svc.cluster.local
nslookup redis-slave-2.redis-slave.learn-k8s.svc.cluster.local

redis-cli cluster meet redis-master-1.redis-master.learn-k8s.svc.cluster.local 6379
redis-cli --cluster rebalance redis-master-1.redis-master.learn-k8s.svc.cluster.local 6379
  
127.0.0.1:6379> CONFIG GET *cluster*
 1) "cluster-require-full-coverage"
 2) "yes"
 3) "cluster-replica-no-failover"
 4) "no"
 5) "cluster-slave-no-failover"
 6) "no"
 7) "cluster-enabled"
 8) "no"
 9) "cluster-allow-reads-when-down"
1)  "no"
2)  "cluster-announce-ip"
3)  ""
4)  "cluster-replica-validity-factor"
5)  "10"
6)  "cluster-slave-validity-factor"
7)  "10"
8)  "cluster-migration-barrier"
9)  "1"
10) "cluster-announce-bus-port"
11) "0"