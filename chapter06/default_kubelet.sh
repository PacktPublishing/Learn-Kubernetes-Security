#!/bin/bash
minikube ssh -- 'ps aux | grep /kubelet'
