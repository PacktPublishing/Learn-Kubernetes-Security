#!/bin/bash

set -eux

aws s3api create-bucket \
    --bucket my-k8s-state-store \
    --region us-east-1
