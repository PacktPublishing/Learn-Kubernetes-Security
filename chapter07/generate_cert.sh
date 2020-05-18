#!/bin/bash
openssl genrsa -out priv.key 4096
openssl req -config ./csr.cnf -new -key priv.key -nodes -out new.csr
export BASE64_CSR=$(cat ./new.csr | base64 | tr -d '\n')
cat csr.yaml | envsubst | kubectl apply -f -
kubectl certificate approve mycsr
kubectl get csr mycsr -o jsonpath='{.status.certificate}' | base64 --decode > new.crt
cat new.crt
