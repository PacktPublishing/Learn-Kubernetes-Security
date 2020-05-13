#!/bin/bash

set -eux

kubectl create namespace demo || true

kubectl config set-context --current --namespace=demo

# enable dev mode for demo purpose, so no unseal is required
helm install vault --set='server.dev.enabled=true' https://github.com/hashicorp/vault-helm/archive/v0.4.0.tar.gz

sleep 30

#kubectl exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json

#VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")

#kubectl exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY

# create policy and secrets in vault
kubectl cp ./vault-script.sh vault-0:/vault/vault-script.sh

kubectl exec vault-0 -- /vault/vault-script.sh
