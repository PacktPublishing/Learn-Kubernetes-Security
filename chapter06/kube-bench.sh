#!/bin/bash
kubectl apply -f nginx.yaml
git clone https://github.com/aquasecurity/kube-bench
cd kube-bench
kubectl apply -f job-gke.yaml
POD=`kubectl get pods | awk 'FNR == 2 {print $1}'`
kubectl wait --for=condition=completed $POD
kubectl logs $POD
