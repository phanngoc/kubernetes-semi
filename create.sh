#!/bin/bash
kubectl apply -f pv/

sleep 2

kubectl apply -f configmap/
kubectl apply -f service/
kubectl apply -f statefulset/
kubectl apply -f deployment/