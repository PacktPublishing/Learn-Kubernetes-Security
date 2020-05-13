#!/bin/bash

#helm install falco --set falco.auditLog.enabled=true stable/falco

kubectl apply -f falco-account.yaml

kubectl apply -f falco-service.yaml

kubectl create configmap falco-config --from-file=./falco-config

kubectl apply -f falco-daemonset-configmap.yaml
