#!/bin/bash

set -x
kubectl get namespaces
kubectl apply -f nginx.yaml
kubectl wait --for=condition=ready pod/nginx
kubectl exec -it nginx -- bash -c "ps aux"
NODE=`kubectl get nodes | awk 'FNR == 2 {print $1}'`
gcloud compute ssh $NODE -- 'ps aux'
