#!/bin/bash

set -eux

kubectl apply -f base-busybox.yaml

kubectl advise-psp inspect -n psp-test --grant
