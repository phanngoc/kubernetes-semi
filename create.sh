#!/bin/bash
kubectl apply -f pv/

sleep 2

kubectl apply -f configmap/
kubectl apply -f deployment/
kubectl apply -f service/