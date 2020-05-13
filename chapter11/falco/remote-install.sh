#!/bin/bash
set -eu

SSH_KEY="~/.ssh/id_rsa"
SSH_USER="admin"
WORK_DIR="/tmp/falco"
INSTALL_SCRIPT="install-falco.sh"

# get worker nodes IPs
IPs=($(kubectl get nodes -l kubernetes.io/role=node -o json | jq '.items[] | .status.addresses | .[] | select(.type == "ExternalIP") | .address' -r | xargs))

for NODE_IP in "${IPs[@]}"
do
	echo "***Start enabling Falco at IP: $NODE_IP***"
	ssh -i $SSH_KEY "$SSH_USER@$NODE_IP" "sudo mkdir -p $WORK_DIR && sudo chown -R $SSH_USER:$SSH_USER $WORK_DIR"
	scp -i $SSH_KEY $INSTALL_SCRIPT "$SSH_USER@$NODE_IP:$WORK_DIR"
	ssh -o ConnectTimeout=10 -i $SSH_KEY "$SSH_USER@$NODE_IP" "sudo bash $WORK_DIR/$INSTALL_SCRIPT"
	echo "***End configuring Flaco at IP: $NODE_IP***"
done
