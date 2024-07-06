# Command to create a pod
kubectl describe pod nginxwebserver-g4bj5 | grep  Replica

kubectl get pods -l app=nginxwebserver

## Create a pod

## List services
kubectl expose replicaset nginxwebserver --port 80

kubectl get rs

kubectl get svc -n learn-k8s
curl http://localhost:80

kubectl scale replicaset nginxwebserver --replicas=5

## minikube image ls
registry.k8s.io/pause:3.9
registry.k8s.io/kube-scheduler:v1.30.0
registry.k8s.io/kube-proxy:v1.30.0
registry.k8s.io/kube-controller-manager:v1.30.0
registry.k8s.io/kube-apiserver:v1.30.0
registry.k8s.io/etcd:3.5.12-0
registry.k8s.io/coredns/coredns:v1.11.1
gcr.io/k8s-minikube/storage-provisioner:v5
docker.io/library/nginx:latest


### Rollout
kubectl rollout history deployments myapp-deployment

kubectl -n demo delete deployments.apps myapp-deployment

## Setup nodejs application.

docker build -t nodejs-express-app .
kubectl apply -f deployment.yml


## Get pods.

- Check pods by namespace
kubectl get pods -l app=redis -n default
kubectl get pods -n default
kubectl get pods -n learn-k8s

- Get pods with labels
kubectl get pods --show-labels

## Access the pod by exec into the pod
kubectl exec -it nodejs-express-deployment-654d5dbdc6-7tbjh -n learn-k8s -- /bin/sh

## Delete all pods
kubectl delete pods --all -n learn-k8s

kubectl delete -n learn-k8s pod pod-setup-redis-cluster

## Get logs
kubectl logs <pod_name> -n <namespace>

kubectl logs nodejs-express-deployment-78577c6c97-8p6jq -n learn-k8s
kubectl logs nginxwebserver -n learn-k8s

## Get events
kubectl get events -n learn-k8s

## Get all resources
kubectl get all -n learn-k8s


## Host local obstack
https://minikube.orb.localp/


## Apply resources
kubectl apply -f deployment
kubectl apply -f service
kubectl apply -f configmap
kubectl apply -f pv


## Get deployments
kubectl get deployments

kubectl delete deployment nodejs-express-deployment -n learn-k8s


phann123/nodejs-express-app:tagname

## Access site in docker nodejs.

http://minikube.orb.local:30002/

## Create configmap from external file
kubectl create configmap nginx-config --from-file=deployment/conf/nginx.conf -n learn-k8s

## Delete resources.

kubectl delete configmap nginx-config -n learn-k8s
kubectl delete services --all --namespace learn-k8s
kubectl delete deployment --all -n learn-k8s
kubectl delete pods --all -n learn-k8s
kubectl delete pvc --all -n learn-k8s
kubectl delete statefulset --all -n learn-k8s

## Restart deployment
- Restart a specific deployment.
kubectl rollout restart -n learn-k8s deployment nginxwebserver

- Restart all deployments.
kubectl rollout restart -n learn-k8s deployment

minikube service nodejs-express -n learn-k8s --url

## Mount host directory to minikube.

minikube mount /Users/ngocp/Documents/projects/kubernete/app:/mnt/data/nodejs

## Access service in minikube
  
minikube service nginx-service --url -n learn-k8s

## Restart statefulset
kubectl rollout restart statefulset redis-slave -n learn-k8s
kubectl rollout restart statefulset redis-master -n learn-k8s


## Create a redis cluster
kubectl exec -it redis-master-0 -n learn-k8s -- redis-cli --cluster create \
  127.0.0.1:6379 \
  redis-master-1.redis-master.learn-k8s.svc.cluster.local:6379 \
  redis-master-2.redis-master.learn-k8s.svc.cluster.local:6379 \
  redis-slave-0.redis-slave.learn-k8s.svc.cluster.local:6379 \
  redis-slave-1.redis-slave.learn-k8s.svc.cluster.local:6379 \
  redis-slave-2.redis-slave.learn-k8s.svc.cluster.local:6379 \
  --cluster-replicas 1
  
### Check cluster status.

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