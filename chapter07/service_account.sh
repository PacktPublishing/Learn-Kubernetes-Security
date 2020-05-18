#!/bin/bash
minikube start
kubectl create serviceaccount test
kubectl get serviceaccounts test -o json
SECRET=`kubectl get serviceaccounts test -o json | jq -r .secrets[0].name`
kubectl get secret $SECRET -o yaml
