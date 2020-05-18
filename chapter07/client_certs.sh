#!/bin/bash
minikube start
minikube ssh -- 'ps aux | grep kube-api' 
