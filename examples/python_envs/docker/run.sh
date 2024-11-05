#!/bin/bash

if [ -z "$1" ]; then
  echo 'You must specify tag'
  exit 1
fi


docker build -t tancou/py-env:$1 .
docker push tancou/py-env:$1