#!/bin/bash

POD="$1"

kubectl capture $POD -ns insecure-nginx
