# Accès au cluster k3s

# Utilisation de kubectl

**kubectl** est l’outil en ligne de commande de Kubernetes qui permet de gérer et interagir avec les clusters. Il sert à déployer, configurer, surveiller et administrer les ressources Kubernetes via des commandes, offrant ainsi un contrôle total sur les applications et l’infrastructure du cluster.

Il s'utilise conjointement avec un fichier `kubeconfig`. On le définit souvent via la variable d'environnement KUBECONFIG.

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

# Utilisation de Lens

**Lens** est un outil open-source et une interface graphique puissante conçue pour gérer et superviser des clusters Kubernetes. Lens permet aux développeurs, DevOps et administrateurs de visualiser et d’interagir avec leurs clusters en fournissant une vue centralisée et intuitive de leurs ressources Kubernetes.

### Caractéristiques principales de Lens

1. **Interface Utilisateur Intuitive** :
   - Lens propose une interface graphique qui simplifie la navigation entre les différentes ressources Kubernetes (pods, services, volumes, namespaces, etc.).
   - La visualisation des états, des logs et des métriques est facilement accessible, ce qui aide à diagnostiquer rapidement les problèmes.

2. **Support Multi-Cluster** :
   - Lens permet de se connecter et de gérer plusieurs clusters Kubernetes depuis une seule interface, facilitant la supervision de plusieurs environnements (développement, staging, production).

3. **Surveillance en Temps Réel** :
   - Lens offre une vue en temps réel des performances des ressources, notamment l’utilisation CPU et mémoire.
   - Intégration avec Prometheus pour fournir des métriques avancées et un monitoring détaillé des clusters.

4. **Gestion Simplifiée des Ressources** :
   - Lens permet de créer, modifier et supprimer des ressources Kubernetes directement depuis l’interface.
   - Les fichiers YAML peuvent être édités et appliqués rapidement, sans passer par des commandes en ligne de commande.

5. **Terminal Intégré** :
   - Un terminal intégré permet de se connecter directement à un conteneur ou à un pod, facilitant les opérations de débogage et de diagnostic.

6. **Extensions et Personnalisation** :
   - Lens propose des extensions qui permettent d'ajouter des fonctionnalités supplémentaires ou de l’intégrer à d’autres outils. Cette extensibilité le rend adaptable aux besoins spécifiques de chaque organisation.

### Avantages de Lens

- **Gain de Temps** : En regroupant les informations et actions dans une interface unique, Lens permet de réduire le besoin de basculer entre différentes fenêtres ou commandes.
- **Facilité de Prise en Main** : Lens simplifie l’accès aux fonctionnalités Kubernetes, rendant la gestion des clusters accessible même aux utilisateurs ayant peu d’expérience avec `kubectl`.
- **Diagnostic Amélioré** : Avec les visualisations des logs et métriques, Lens facilite la détection et la résolution des problèmes dans les clusters.

### Utilisation Typique de Lens

Lens est idéal pour :
- La **supervision quotidienne** des clusters et des ressources.
- Le **débogage rapide** de problèmes de performance ou de défaillance des applications.
- La **gestion multi-cluster** dans des environnements complexes.
- **Former des équipes** qui débutent avec Kubernetes en offrant une vue simplifiée de l’infrastructure.

### Installation

Lens est disponible pour Windows, macOS et Linux et peut être téléchargé sur le site officiel :
- [Lens - The Kubernetes IDE](https://k8slens.dev/)

En résumé, Lens est un outil pratique et puissant qui améliore considérablement l’expérience utilisateur dans la gestion de Kubernetes, en offrant des vues détaillées, une navigation simplifiée et un accès instantané aux données critiques des clusters.

## Configuration de l'accès