#!/bin/bash

docker run --name sysdig-inspect -d -v /Users/kaizhehuang/demo/chapter11/sysdig:/captures -p3000:3000 sysdig/sysdig-inspect:latest
