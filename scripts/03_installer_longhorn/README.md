# Longhorn installation

- Version `1.7.2`
- Utilisation de Helm 3

C'est une installation générique sur le cluster, qu'une seule installation est nécessaire.

Sources : https://longhorn.io/docs/1.7.2/deploy/install/install-with-helm/

## Setup

```bash
helm repo add longhorn https://charts.longhorn.io
helm repo update
# helm search repo longhorn/longhorn --versions | head

helm upgrade longhorn longhorn/longhorn \
  --install \
  --namespace longhorn-system \
  --create-namespace \
  --version 1.7.2 \
  --set persistence.defaultClassReplicaCount=3
```

## Ingress de secours

Attention, il n'y a **pas** de login de sécurité sur cet ingress !

Pensez à mettre à jour l'URL de l'ingress !

```bash
kubectl apply -n longhorn-system -f ingress.yaml
```