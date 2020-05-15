#!/bin/bash

kubectl create rolebinding new-rolebinding-group \
     --clusterrole=custom-clusterrole \
     --group=group-1 \
     --namespace=default
