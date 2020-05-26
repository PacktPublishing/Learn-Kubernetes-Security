#!/bin/bash
minikube start --kubernetes-version=v1.13.0
git clone https://github.com/aquasecurity/kube-hunter
cd kube-hunter
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/darwin/amd64/kubectl
chmod +x kubectl
./kubectl create -f job.yaml
POD=`kubectl get pods | awk 'FNR == 2 {print $1}'`
./kubectl wait --for=condition=completed --timeout=240s pod/$POD
sleep 5
./kubectl logs pod/$POD
