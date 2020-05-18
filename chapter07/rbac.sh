#!/bin/bash
minikube start
kubectl create -f deployment.yaml
POD=`kubectl get pods | awk 'FNR == 2 {print $1}'`
kubectl wait --for=condition=ready pod/$POD
kubectl config set-credentials employee --client-certificate=employee.crt --client-key=employee.key
kubectl config set-context employee-context --cluster=minikube --user=employee
kubectl --context=employee-context get pods || true
cat role.yaml
kubectl apply -f role.yaml
cat rolebinding.yaml
kubectl apply -f rolebinding.yaml
kubectl --context=employee-context get pods
kubectl --context=employee-context get deployments
