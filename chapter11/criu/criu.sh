#!/bin/bash

set -eux

docker run -d --name looper --security-opt seccomp:unconfined busybox /bin/sh -c 'i=0; while true; do echo $i; i=$(expr $i + 1); sleep 1; done'

# wait for a while
sleep 5

docker logs looper

# run criu checkpoint to save the state
docker checkpoint create --checkpoint-dir=/tmp looper checkpoint

# restore as a new container
docker create --name looper-clone --security-opt seccomp:unconfined busybox /bin/sh -c 'i=0; while true; do echo $i; i=$(expr $i + 1); sleep 1; done'

docker start --checkpoint-dir=/tmp --checkpoint=checkpoint looper-clone

sleep 5
docker logs looper-clone

docker rm -f looper looper-clone || true
