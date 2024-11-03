# Chapitre 2 : Mise en Place d’un Cluster Kubernetes

Ce chapitre couvre la mise en place d’un cluster Kubernetes en utilisant **k3sup**, un outil léger et rapide pour déployer Kubernetes sur des environnements légers ou dans le cloud. Nous aborderons les étapes nécessaires pour préparer et configurer un cluster Kubernetes opérationnel.

Diapo [pdf](02_mise_en_place_d_un_cluster_kubernetes.pdf)

## 2.1 Préparation de l’Environnement

Avant de déployer Kubernetes, il est important de préparer l’environnement cible, qu'il s'agisse de machines locales, de machines virtuelles ou de serveurs en cloud.

### 2.1.1 Choix de l’Infrastructure

Kubernetes peut être installé sur différents types d’infrastructures :

- **Développement local** : Machines virtuelles ou Raspberry Pi pour un environnement de test.
- **Environnements on-premise** : Serveurs physiques au sein d’une entreprise.
- **Cloud** : AWS, Azure, GCP ou autres fournisseurs cloud. K3sup facilite l’installation sur ces environnements.

### 2.1.2 Prérequis Techniques

Avant de commencer l’installation, assurez-vous d’avoir :

- **SSH configuré** : k3sup utilise SSH pour se connecter aux nœuds et y installer Kubernetes.
- **Accès root** ou des permissions `sudo` sur les machines où Kubernetes sera installé.
- **k3sup installé** sur la machine de contrôle (souvent votre machine locale). Pour installer k3sup, exécutez la commande suivante :

  ```bash
  curl -sLS https://get.k3sup.dev | sh
  sudo install k3sup /usr/local/bin/
  ```

---

## 2.2 Installation de Kubernetes avec k3sup

**k3sup** permet d’installer Kubernetes de manière simple et rapide en automatisant le déploiement de **k3s**, une version allégée de Kubernetes adaptée aux environnements à faible empreinte mémoire.

### 2.2.1 Déploiement du Nœud Maître

Le nœud maître (control plane) est le centre de gestion du cluster. Pour l’installer, exécutez la commande suivante depuis votre machine de contrôle :

```bash
k3sup install --ip <IP_MASTER> --user <USER>
```

- Remplacez `<IP_MASTER>` par l’adresse IP de la machine qui servira de nœud maître.
- Remplacez `<USER>` par le nom de l’utilisateur ayant accès à cette machine.

Cette commande installe k3s sur le nœud spécifié et configure `kubectl` pour se connecter au cluster.

### 2.2.2 Ajout de Nœuds de Travail (Workers)

Une fois le nœud maître configuré, vous pouvez ajouter des nœuds de travail pour répartir les charges de travail. Exécutez la commande suivante pour chaque nœud que vous souhaitez ajouter :

```bash
k3sup join --ip <IP_AGENT> --server-ip <IP_MASTER> --user <USER>
```

- `<IP_AGENT>` : Adresse IP de la machine à ajouter en tant que nœud de travail.
- `<IP_MASTER>` : Adresse IP du nœud maître pour que le nouveau nœud puisse se connecter au cluster.
- `<USER>` : Nom de l’utilisateur sur le nœud de travail.

### 2.2.3 Vérification de l’Installation

Une fois les nœuds ajoutés, vérifiez que le cluster est fonctionnel et que tous les nœuds sont connectés :

```bash
kubectl get nodes
```

Cette commande devrait afficher la liste de tous les nœuds, indiquant leur statut et leur rôle dans le cluster.

---

## 2.3 Configuration et Gestion du Cluster

Une fois le cluster Kubernetes installé, il est important de le configurer et de le maintenir en bon état pour garantir ses performances et sa fiabilité.

### 2.3.1 Configurer `kubectl`

Pour interagir avec le cluster Kubernetes, vous utiliserez `kubectl`. Après l’installation, k3sup configure automatiquement `kubectl` pour qu’il pointe vers le cluster. Vous pouvez vérifier que la configuration est correcte avec la commande suivante :

```bash
kubectl config view
```

Cette commande affiche les informations de configuration de `kubectl` et les clusters configurés.

### 2.3.2 Gestion des Ressources et Allocation

Kubernetes utilise un **Scheduler** pour attribuer les pods aux nœuds disponibles, en fonction des ressources. Vous pouvez inspecter et ajuster l’allocation des ressources :

- **Lister les ressources disponibles** :
  ```bash
  kubectl describe nodes
  ```

- **Vérifier les pods en cours d'exécution** :
  ```bash
  kubectl get pods -A
  ```

### 2.3.3 Surveillance et Santé du Cluster

Pour garantir la disponibilité et la fiabilité du cluster, surveillez régulièrement l'état des nœuds et des pods. Quelques commandes de base pour vérifier la santé du cluster :

- **État des nœuds** :
  ```bash
  kubectl get nodes
  ```

- **État des pods dans un namespace spécifique** :
  ```bash
  kubectl get pods -n <NAMESPACE>
  ```

En production, il est recommandé d’intégrer des outils de surveillance avancée tels que Prometheus pour des métriques plus détaillées.

---

## 2.4 Maintien en Condition Opérationnelle (MCO) du Cluster

Le maintien en condition opérationnelle (MCO) est essentiel pour s'assurer que le cluster Kubernetes est performant et sécurisé.

### 2.4.1 Surveillance du Cluster

Pour surveiller les performances du cluster et anticiper les problèmes potentiels, des solutions comme **Prometheus** et **Grafana** peuvent être déployées pour :

- Collecter des métriques sur les ressources (CPU, RAM, etc.)
- Générer des alertes en cas de défaillance
- Visualiser l’utilisation des ressources en temps réel

### 2.4.2 Sécurisation du Réseau avec des Policies

Les **Network Policies** permettent de contrôler le trafic réseau entre les pods et de restreindre les accès selon des règles spécifiques. Pour configurer une Network Policy, créez un fichier YAML qui spécifie les règles de communication entre les pods.

Exemple de Network Policy YAML pour restreindre l’accès à un pod :

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-specific
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: frontend
```

Ce fichier autorise uniquement les pods ayant le label `role: frontend` à communiquer avec ceux ayant le label `role: backend`.

### 2.4.3 Bonnes Pratiques pour le MCO

- **Utiliser des quotas de ressources** : Limitez les ressources pour éviter que certains pods ne consomment toutes les ressources.
- **Mettre en place des alertes** : Configurez des alertes pour être notifié en cas de défaillance.
- **Automatiser les mises à jour** : Utilisez des solutions de CI/CD pour automatiser les déploiements et les mises à jour continues.

---

Ce chapitre vous a guidé dans la mise en place et la gestion d’un cluster Kubernetes avec k3sup. Vous êtes maintenant prêts à explorer les objets Kubernetes de base et à commencer à déployer vos premières applications conteneurisées.

