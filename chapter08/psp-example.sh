#!/bin/bash

set -eux

kubectl apply -f ns.yaml

kubectl apply -f sa.yaml

kubectl apply -f roles.yaml

# create psp
kubectl apply -f psp.yaml

# should success
kubectl apply -f pods-allow.yaml

# should fail
kubectl apply -f pods-deny.yaml
