#!/bin/bash

NAME="$1"

echo "Delete service account"

kubectl -n default delete serviceaccount $NAME

ROLEBINDING="kubeconfig-cluster-admin-$NAME-token"

echo "Delete cluster role binding"
kubectl delete clusterrolebinding $ROLEBINDING

echo "Delete secret"
kubectl delete secret -n default $ROLEBINDING

echo "Done."