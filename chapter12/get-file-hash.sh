#!/bin/bash

anchore-cli image add kaizheh/victim:nginx

anchore-cli --json image content kaizheh/victim:nginx files | jq '.content | .[] | select(.filename=="/tmp/minerd2")'
