#!/bin/bash
minikube start
minikube addons enable ingress
kubectl create namespace opa
kubectl config set-context opa-tutorial --user minikube --cluster minikube --namespace opa
kubectl config use-context opa-tutorial
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -out ca.crt -subj "/CN=admission_ca"
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/CN=opa.opa.svc" -config server.conf
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 100000 -extensions v3_req -extfile server.conf
kubectl create secret tls opa-server --cert=server.crt --key=server.key
kubectl apply -f opa.yaml
kubectl wait --for=condition=available --timeout=120s deployment/opa -n opa
export BASE64_CRT=`cat ca.crt | base64 | tr -d '\n'`
kubectl label ns kube-system openpolicyagent.org/webhook=ignore
kubectl label ns opa openpolicyagent.org/webhook=ignore
cat webhook-config.yaml | envsubst | kubectl apply -f -
kubectl create configmap pod --from-file=pod-blacklist.rego
kubectl logs -l app=opa -c opa
kubectl create namespace test
kubectl apply -f busybox.yaml -n test
