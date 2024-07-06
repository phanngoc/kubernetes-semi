#!/bin/bash

kubectl delete services --all --namespace learn-k8s
kubectl delete deployment --all -n learn-k8s
kubectl delete statefulsets --all -n learn-k8s
kubectl delete pvc --all -n learn-k8s
kubectl delete pv --all -n learn-k8s

# Check if the configmap exists before deleting
if kubectl get configmap nginx-config -n learn-k8s > /dev/null 2>&1; then
    kubectl delete configmap nginx-config -n learn-k8s
else
    echo "ConfigMap 'nginx-config' does not exist in namespace 'learn-k8s'"
fi