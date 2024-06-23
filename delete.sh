#!/bin/bash
kubectl delete configmap nginx-config -n learn-k8s
kubectl delete services --all --namespace learn-k8s
kubectl delete deployment --all -n learn-k8s
kubectl delete pvc --all -n learn-k8s
kubectl delete pv --all -n learn-k8s