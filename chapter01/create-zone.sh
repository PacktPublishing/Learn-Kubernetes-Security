#!/bin/bash

set -eux

ID=$(uuidgen) && aws route53 create-hosted-zone --name k8s-clusters.k8s-demo.com --caller-reference $ID | jq .DelegationSet.NameServers
