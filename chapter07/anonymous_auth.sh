#!/bin/bash
minikube start --extra-config=apiserver.authorization-mode=AlwaysAllow --extra-config=apiserver.anonymous-auth=false --extra-config=kubelet.authorization-mode=AlwaysAllow --extra-config=kubelet.anonymous-auth=false
minikube ssh -- 'ps aux | grep kube-api' 
