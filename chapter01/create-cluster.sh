#!/bin/bash

set -eux

export NODE_SIZE=${NODE_SIZE:-t2.large}
export MASTER_SIZE=${MASTER_SIZE:-t2.medium}
export ZONES=${ZONES:-"us-east-1d,us-east-1b,us-east-1c"}
# gs is for google cloud, s3 is for aws
export KOPS_STATE_STORE="s3://my-k8s-state-store2/"

kops create cluster k8s-clusters.k8s-demo-zone.com \
  --cloud aws \
  --node-count 2 \
  --zones $ZONES \
  --node-size $NODE_SIZE \
  --master-size $MASTER_SIZE \
  --networking calico \
  --kubernetes-version 1.14.3 \
  --yes \
