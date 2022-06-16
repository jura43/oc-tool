#!/bin/bash

echo "Enter your name"
read name
echo ""

echo "Type 1 to create"
echo "Type 2 to delete"
read input
echo ""

if [ $input -eq 1 ]
then
    cat deployment.yml | NAME=$name envsubst | oc create -f -
    cat nginx.yml | NAME=$name envsubst | oc create -f -
else
    cat deployment.yml | NAME=$name envsubst | oc delete -f -
    cat nginx.yml | NAME=$name envsubst | oc delete -f -
fi

echo "Done"
