# Accès au cluster k3s

## Utilisation de kubectl

**kubectl** est l’outil en ligne de commande de Kubernetes qui permet de gérer et interagir avec les clusters. Il sert à déployer, configurer, surveiller et administrer les ressources Kubernetes via des commandes, offrant ainsi un contrôle total sur les applications et l’infrastructure du cluster.

Il s'utilise conjointement avec un fichier `kubeconfig`. On le définit souvent via la variable d'environnement KUBECONFIG.

➡️ [Cheatsheet kubectl](https://kubernetes.io/fr/docs/reference/kubectl/cheatsheet/)

## Fichier kubeconfig

Voici un exemple de fichier **kubeconfig**. Ce fichier est utilisé par `kubectl` pour stocker les informations de connexion et de configuration nécessaires pour se connecter à un cluster Kubernetes.

```yaml
apiVersion: v1
kind: Config
clusters:
- name: example-cluster
  cluster:
    server: https://example-cluster-endpoint:6443
    certificate-authority-data: <base64-encoded-ca-cert> # Certificat d'autorité du cluster
contexts:
- name: example-context
  context:
    cluster: example-cluster
    user: example-user
    namespace: default
current-context: example-context
users:
- name: example-user
  user:
    client-certificate-data: <base64-encoded-client-cert> # Certificat client pour l'authentification
    client-key-data: <base64-encoded-client-key> # Clé privée du certificat client
```

### Explications des Sections Principales

- **clusters** : Liste des clusters auxquels `kubectl` peut se connecter, incluant l’URL du serveur API et le certificat du cluster.
- **contexts** : Définit un ensemble de paramètres pour accéder à un cluster spécifique avec un utilisateur et un namespace par défaut.
- **current-context** : Context par défaut utilisé par `kubectl`.
- **users** : Informations d'identification pour l’authentification avec le cluster (certificats ou jetons).

### Utilisation

Pour spécifier un fichier kubeconfig personnalisé, utilisez :

```bash
kubectl --kubeconfig=/path/to/kubeconfig get pods
```

Ce fichier **kubeconfig** est essentiel pour gérer plusieurs clusters ou utilisateurs dans Kubernetes en stockant les informations de connexion de manière centralisée.
