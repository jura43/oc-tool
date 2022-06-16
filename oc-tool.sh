#!/bin/bash

echo "Enter your name"
read name

cat deployment.yaml | NAME=$name | oc create -f -
cat nginx.yaml | NAME=$name | oc create -f -

echo "Done"
