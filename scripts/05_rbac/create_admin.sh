#!/bin/bash

NAME="$1"
URL="${2:-URL}"

echo "Create service account"

kubectl -n default create serviceaccount $NAME

ROLEBINDING="kubeconfig-cluster-admin-$NAME-token"

echo "Assign role"
kubectl create clusterrolebinding \
	$ROLEBINDING \
	--clusterrole=cluster-admin \
	--serviceaccount=default:$NAME

cat <<EOF | kubectl create -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: $ROLEBINDING
  namespace: default
  annotations:
    kubernetes.io/service-account.name: $NAME
type: kubernetes.io/service-account-token
EOF

TOKEN=$(kubectl -n default get secret $ROLEBINDING  -o jsonpath='{.data.token}' | base64 --decode)

CERT_BASE64=$(kubectl get cm -o jsonpath='{.items[0].data.ca\.crt}' | base64 -w 0)
CONTEXT=$(kubectl config current-context)

echo "Here is the kubeconfig :"
echo ''
cat <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${CERT_BASE64}
    server: https://${URL}:6443
  name: $CONTEXT
contexts:
- context:
    cluster: $CONTEXT
    user: $NAME
  name: $CONTEXT
current-context: $CONTEXT
kind: Config
preferences: {}
users:
- name: $NAME
  user:
    token: $TOKEN
EOF