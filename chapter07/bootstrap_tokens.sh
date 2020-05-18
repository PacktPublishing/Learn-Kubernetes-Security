#!/bin/bash
minikube start
minikube ssh -- "ps aux | grep kube-api"
minikube ssh -- "ps aux | grep controller-manager"
