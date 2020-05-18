#!/bin/bash
minikube start
minikube ssh -- 'ps aux | grep kube-api'
kubectl apply -f limitrange.yaml
kubectl apply -f pod_limit.yaml
