#!/bin/bash

kubectl create rolebinding new-rolebinding-sa \
     --clusterrole=custom-clusterrole \
     --serviceaccount=default:demo-sa
