#!/bin/bash


# Ajouter le packqge bitnami
helm repo add bitnami https://charts.bitnami.com/bitnami

# Voir la liste de ce que propose bitnami
helm search repo bitnami

# instancier un mysql avec le chart Helm de bitnami
helm upgrade \
  --install \
  --namespace tancrede-db \
  --create-namespace \
  --set auth.rootPassword="monsupermdp" \
  --set auth.database="ma_bd" \
  --set auth.username="isiuser" \
  --set auth.password="isipassword" \
  db1 \
  bitnami/mysql

helm upgrade \
  --install \
  --namespace tancrede-db \
  --create-namespace \
  --set ingress.enabled=true \
  --set ingress.hostname="db1-pma.tancrede-db.k8s.isitech.<domain>.fr" \
  --set db.host=db1-mysql \
  db1-pma \
  bitnami/phpmyadmin
