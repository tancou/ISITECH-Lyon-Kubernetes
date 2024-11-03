# Kubernetes - Cours ISITECH Lyon

## Introduction Générale

Bienvenue dans le dépôt de support au cours Kubernetes dispensé à l’école **ISITECH Lyon** par **Tancrède SUARD**. Ce cours est destiné aux étudiants souhaitant acquérir des compétences fondamentales et avancées en orchestration de conteneurs avec Kubernetes, et à mettre en œuvre des applications dans un environnement moderne et évolutif.

### Objectifs du Cours

À l’issue de ce cours, vous serez capables de :

- **Comprendre le rôle de Kubernetes** dans les architectures modernes et ses cas d'usage.
- **Déployer et gérer un cluster Kubernetes** en utilisant des outils de déploiement adaptés comme k3sup.
- **Orchestrer des applications conteneurisées** et assurer leur disponibilité, mise à l'échelle et sécurité.
- **Mettre en place des pratiques avancées** pour la gestion des ressources, la sécurité et la surveillance des clusters.

### Prérequis Techniques

Avant de démarrer, vous devez disposer de quelques connaissances de base pour tirer pleinement parti de ce cours :

- **Connaissance des conteneurs** : Notions sur Docker ou un autre outil de conteneurisation.
- **Expérience de la ligne de commande** : Commandes Bash ou PowerShell.
- **Notions réseau** : Comprendre le routage de base et les réseaux locaux.
- **Accès à un environnement** capable de faire tourner Kubernetes : Un ordinateur avec **Linux** ou **Windows**, ou des serveurs en cloud, où k3sup sera utilisé pour l’installation du cluster Kubernetes.

### Organisation du Contenu

Ce dépôt est structuré en plusieurs fichiers markdown représentant les chapitres du cours, chacun couvrant des aspects théoriques et pratiques de Kubernetes. Les chapitres incluent des exercices pour mettre en pratique les connaissances acquises.

### Structure des Chapitres

- **Chapitre 1 : Introduction à Kubernetes**
  - Concepts fondamentaux et historique
  - Présentation de l'architecture

- **Chapitre 2 : Mise en place d'un cluster Kubernetes**
  - Installation et configuration avec k3sup (outil principal utilisé)
  - Gestion des nœuds et préparation de l’environnement

- **Chapitre 3 : Objets Kubernetes et premières manipulations**
  - Pods, services, volumes, et premières commandes `kubectl`

- **Chapitre 4 : Déploiement et gestion d'applications**
  - Configuration des déploiements et mises à jour continues

- **Chapitre 5 : Sécurité et bonnes pratiques**
  - Gestion des accès avec RBAC, Network Policies, Secrets et ConfigMaps

### Exécution des Exercices

Chaque chapitre est accompagné d’exercices pratiques. Les fichiers nécessaires se trouvent dans le dossier **exercices**, organisés par chapitre. Suivez les instructions pas à pas pour chaque exercice et utilisez les commandes `kubectl` fournies pour vous familiariser avec les opérations courantes dans Kubernetes.

### Lien avec le Support

Ce dépôt fait partie intégrante du cours et sert de support aux sessions pratiques et théoriques. Vous pouvez l'utiliser pour suivre le cours en autonomie ou pour réviser après les sessions.

---

**Bon apprentissage et bienvenue dans le monde de l'orchestration de conteneurs !**
# Chapitre 1 : Introduction au Concept de Kubernetes

Ce premier chapitre introduit Kubernetes, les défis auxquels il répond et son architecture générale. L’objectif est de vous fournir une compréhension claire de son rôle et de son fonctionnement dans la gestion d’applications conteneurisées.

## 1.1 Pourquoi Kubernetes ?

Les applications modernes, composées de multiples services, doivent être déployées, mises à jour et gérées de manière efficace et sans interruption. Kubernetes apporte une solution pour orchestrer ces applications en offrant :

- **Une haute disponibilité** : Grâce à des fonctionnalités d’auto-récupération et de gestion des pannes.
- **La scalabilité** : Kubernetes ajuste automatiquement le nombre d’instances en fonction des besoins.
- **Des mises à jour continues** : Permet de déployer progressivement des nouvelles versions avec peu ou pas de temps d’indisponibilité.

### 1.1.1 Les Défis Modernes du Déploiement

Les environnements applicatifs modernes ont des exigences spécifiques auxquelles Kubernetes répond efficacement :

- **Montée en charge dynamique** : Les applications peuvent s’adapter aux variations de trafic sans intervention manuelle.
- **Gestion des versions** : Avec les mises à jour continues, les versions peuvent être déployées de façon progressive.
- **Résilience** : Les conteneurs défaillants sont redémarrés automatiquement, et les applications restent disponibles.

### 1.1.2 Le Rôle de Kubernetes dans l’Infrastructure

Kubernetes facilite la transition vers des architectures microservices, en permettant de déployer et de gérer de nombreux services de manière indépendante. Son architecture découplée permet une meilleure résilience et une flexibilité accrue pour développer et maintenir les applications.

- **Modularité et découplage** : Chaque composant d’une application peut être développé et maintenu indépendamment, ce qui permet une meilleure évolutivité.
- **Automatisation des tâches opérationnelles** : Kubernetes assure automatiquement le placement des conteneurs sur les ressources disponibles, la gestion des ressources et le redémarrage des conteneurs en cas de panne.

---

## 1.2 Historique et Contexte de Kubernetes

Kubernetes a été conçu pour répondre aux besoins de gestion d'infrastructures massives et pour automatiser le déploiement de conteneurs.

### 1.2.1 Aux Origines : Google Borg

Kubernetes s’inspire de **Borg**, l'orchestrateur interne de Google, qui a introduit les bases de l’orchestration de conteneurs dans les années 2000. Borg permettait à Google de gérer des milliers de serveurs et d’automatiser l'exécution de ses services critiques.

### 1.2.2 L’Open-Source et la CNCF

En 2015, Google a rendu Kubernetes open-source et l’a transféré à la **Cloud Native Computing Foundation (CNCF)**. Cette organisation vise à promouvoir les technologies open-source pour le cloud et à garantir leur interopérabilité. Aujourd’hui, Kubernetes est le standard de facto pour l’orchestration de conteneurs.

### 1.2.3 Les Alternatives et la Concurrence

Bien que Kubernetes domine le marché, plusieurs solutions ont cohabité ou coexistent encore :

- **Docker Swarm** : Une solution plus simple mais moins évolutive.
- **Apache Mesos** : Utilisé pour orchestrer à la fois des conteneurs et d'autres ressources, mais avec une approche différente.
  
Cependant, la flexibilité et l’évolutivité de Kubernetes en ont fait la solution la plus populaire.

---

## 1.3 Principes de Base de l’Architecture Kubernetes

Kubernetes fonctionne selon une architecture en **cluster**. Chaque cluster comprend plusieurs composants qui gèrent et orchestrent les conteneurs.

### 1.3.1 Structure d’un Cluster Kubernetes

Un **cluster Kubernetes** est composé de plusieurs machines, appelées **nœuds**, qui exécutent les applications sous forme de conteneurs. Les deux types de nœuds principaux sont :

- **Control Plane (plan de contrôle)** : Gère l’état du cluster et orchestre les tâches :
  - **API Server** : Interface d’interaction avec le cluster.
  - **Scheduler** : Assigne les ressources aux nouvelles charges de travail.
  - **Controller Manager** : Surveille l’état des ressources et garantit la conformité aux spécifications souhaitées.
  - **ETCD** : Base de données clé-valeur pour stocker l’état du cluster.

- **Worker Nodes** : Exécutent les conteneurs et gèrent les pods à travers les composants :
  - **Kubelet** : S’assure que les conteneurs sont en cours d’exécution dans les pods.
  - **kube-proxy** : Assure la gestion des réseaux et de l’accès aux services.

### 1.3.2 Objets Principaux de Kubernetes

Les objets Kubernetes représentent les ressources déployées dans le cluster. Voici les principaux objets et leur rôle :

- **Pod** : L’unité de base de Kubernetes. Un pod peut contenir un ou plusieurs conteneurs qui partagent les mêmes ressources réseau et stockage.
- **Service** : Permet d’exposer un groupe de pods, rendant les applications accessibles au sein ou à l’extérieur du cluster.
- **Namespace** : Offre une isolation logique des ressources pour différents environnements (production, développement, etc.).
- **Deployment** : Décrit l’état souhaité pour un ensemble de pods, gère les mises à jour et garantit un certain nombre de répliques en cas de pannes.

### 1.3.3 Notions de Réseau et Communication dans Kubernetes

Kubernetes utilise un modèle de réseau **plat** pour permettre aux pods de communiquer librement. Quelques notions importantes à retenir :

- **Networking plugins** : Kubernetes permet d’utiliser des plugins comme **Calico**, **Flannel**, ou **Weave** pour gérer la communication entre les pods.
- **Service Discovery** : Les services sont identifiés par leurs noms dans le cluster, facilitant l’interconnexion entre eux.
  
Kubernetes fournit également des objets spécifiques pour gérer l’exposition des applications au monde extérieur (par exemple, les services **LoadBalancer** et **NodePort**).

### 1.3.4 Kubernetes et Docker : La Compatibilité des Conteneurs

Bien que Kubernetes puisse fonctionner avec divers runtimes de conteneurs grâce à l’interface **CRI** (Container Runtime Interface), Docker reste l’option la plus courante et bien intégrée. Kubernetes interagit avec Docker pour déployer et orchestrer les conteneurs dans le cluster.

---

Ce premier chapitre pose les bases pour comprendre pourquoi Kubernetes est un outil essentiel pour les infrastructures modernes. Dans le chapitre suivant, nous aborderons la mise en place pratique d’un cluster Kubernetes, en utilisant **k3sup** pour simplifier le processus d'installation.

# Chapitre 2 : Mise en Place d’un Cluster Kubernetes

Ce chapitre couvre la mise en place d’un cluster Kubernetes en utilisant **k3sup**, un outil léger et rapide pour déployer Kubernetes sur des environnements légers ou dans le cloud. Nous aborderons les étapes nécessaires pour préparer et configurer un cluster Kubernetes opérationnel.

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

# Chapitre 3 : Premiers Pas avec les Objets Kubernetes

Dans ce chapitre, nous allons explorer les objets de base de Kubernetes qui permettent de déployer, exposer et gérer des applications dans un cluster. Ces concepts sont essentiels pour comprendre comment Kubernetes orchestre les conteneurs.

## 3.1 Concepts Fondamentaux des Objets Kubernetes

Kubernetes organise les applications à l'aide de plusieurs objets, chacun ayant un rôle bien défini dans le cluster. Les objets de base incluent :

- **Pod** : L’unité de déploiement de base dans Kubernetes. Chaque pod contient un ou plusieurs conteneurs qui partagent les mêmes ressources réseau et stockage.
- **Service** : Expose les applications pour permettre la communication entre les pods et avec l’extérieur du cluster.
- **Volume** : Fournit un stockage persistant pour les applications au sein des pods.
- **Namespace** : Segmente le cluster pour isoler des groupes de ressources et faciliter la gestion de différents environnements (production, développement).

---

## 3.2 Pods : L'Unité Fondamentale de Déploiement

Un **pod** est la plus petite unité de déploiement dans Kubernetes et contient généralement un conteneur unique. Plusieurs pods peuvent être créés pour une même application, chacun étant géré individuellement par Kubernetes.

### 3.2.1 Création d’un Pod

Pour créer un pod, vous pouvez utiliser un fichier de configuration YAML qui spécifie les détails du conteneur et ses configurations.

Exemple de fichier `pod-example.yaml` :

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: my-app
spec:
  containers:
  - name: my-container
    image: nginx:latest
    ports:
    - containerPort: 80
```

Pour créer ce pod, exécutez :

```bash
kubectl apply -f pod-example.yaml
```

### 3.2.2 Vérification et Surveillance des Pods

Une fois le pod créé, vous pouvez vérifier son état avec les commandes suivantes :

- **Lister les pods** :
  ```bash
  kubectl get pods
  ```

- **Obtenir des détails sur un pod spécifique** :
  ```bash
  kubectl describe pod my-pod
  ```

- **Visualiser les logs d’un conteneur dans un pod** :
  ```bash
  kubectl logs my-pod
  ```

---

## 3.3 Services : Exposer les Applications

Les **services** permettent d’exposer les pods pour permettre aux applications de communiquer entre elles et avec l’extérieur.

### 3.3.1 Types de Services

Kubernetes offre plusieurs types de services en fonction des besoins d’exposition :

- **ClusterIP** : Accessible uniquement depuis le cluster, pour une communication interne.
- **NodePort** : Expose le service sur un port spécifique de chaque nœud du cluster.
- **LoadBalancer** : Expose le service via un équilibreur de charge (disponible principalement dans les environnements cloud).

### 3.3.2 Création d’un Service pour un Pod

Voici un exemple de fichier `service-example.yaml` pour exposer le pod créé précédemment :

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```

Pour appliquer ce service, exécutez :

```bash
kubectl apply -f service-example.yaml
```

### 3.3.3 Vérification de l’Accessibilité du Service

Pour vérifier que le service fonctionne correctement, utilisez la commande suivante pour lister les services disponibles :

```bash
kubectl get services
```

Vous pouvez ensuite tester l’accès au service à l’aide de l’IP du cluster et du port exposé, si applicable.

---

## 3.4 Volumes et Persistances des Données

Kubernetes permet d’associer des volumes aux pods pour conserver les données même si un pod est supprimé ou recréé.

### 3.4.1 Types de Volumes dans Kubernetes

Kubernetes propose différents types de volumes pour répondre aux besoins de persistance :

- **emptyDir** : Crée un volume temporaire pour stocker des données pendant la durée de vie du pod.
- **hostPath** : Monte un répertoire du nœud dans le pod.
- **PersistentVolume (PV)** et **PersistentVolumeClaim (PVC)** : Volumes persistants indépendants du cycle de vie des pods.

### 3.4.2 Création d’un Volume PersistentVolume (PV) et PersistentVolumeClaim (PVC)

Exemple de fichier `pv-example.yaml` pour un PersistentVolume :

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-example
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/data/pv-example"
```

Pour créer le PersistentVolume :

```bash
kubectl apply -f pv-example.yaml
```

Exemple de fichier `pvc-example.yaml` pour un PersistentVolumeClaim :

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-example
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
```

Pour créer le PersistentVolumeClaim :

```bash
kubectl apply -f pvc-example.yaml
```

Le PVC est maintenant prêt à être utilisé dans un pod pour assurer la persistance des données.

---

## 3.5 Namespaces : Gestion des Environnements

Les **namespaces** permettent de segmenter les ressources du cluster pour isoler des groupes de pods et d’objets en fonction des besoins (environnement de production, de développement, etc.).

### 3.5.1 Création d’un Namespace

Pour créer un namespace, vous pouvez exécuter la commande suivante :

```bash
kubectl create namespace dev-environment
```

Vous pouvez également utiliser un fichier YAML pour définir un namespace :

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev-environment
```

Ensuite, appliquez ce fichier :

```bash
kubectl apply -f namespace.yaml
```

### 3.5.2 Utilisation des Namespaces

Pour gérer des ressources dans un namespace spécifique, vous pouvez ajouter le paramètre `-n` dans vos commandes, par exemple :

```bash
kubectl get pods -n dev-environment
```

---

Ce chapitre introduit les principaux objets Kubernetes utilisés pour déployer et gérer des applications dans un cluster. Avec ces bases, vous êtes maintenant prêt à passer au chapitre suivant et à apprendre comment déployer des applications complètes dans Kubernetes.# Chapitre 4 : Déploiement et Maintien d’Applications

Dans ce chapitre, nous abordons le déploiement d’applications dans Kubernetes et les pratiques essentielles pour maintenir ces applications en production, y compris la mise à l’échelle, les mises à jour continues et les stratégies de surveillance.

## 4.1 Déploiement d’une Application Basique

Un déploiement dans Kubernetes définit l’état souhaité pour un ensemble de pods, permettant à Kubernetes de maintenir cet état en gérant le nombre de réplicas et en appliquant les mises à jour des conteneurs.

### 4.1.1 Création d’un Déploiement

Pour déployer une application, vous pouvez créer un objet **Deployment** qui spécifie le nombre de pods, l’image du conteneur et d'autres configurations.

Exemple de fichier `deployment-example.yaml` :

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx:latest
        ports:
        - containerPort: 80
```

Pour appliquer ce déploiement :

```bash
kubectl apply -f deployment-example.yaml
```

### 4.1.2 Vérification et Gestion du Déploiement

Après avoir créé le déploiement, vous pouvez vérifier son état avec les commandes suivantes :

- **Lister les déploiements** :
  ```bash
  kubectl get deployments
  ```

- **Obtenir les détails d’un déploiement spécifique** :
  ```bash
  kubectl describe deployment my-deployment
  ```

- **Vérifier les pods créés** :
  ```bash
  kubectl get pods -l app=my-app
  ```

---

## 4.2 Mise à l’Échelle des Applications

Kubernetes permet de mettre à l’échelle les applications en ajustant le nombre de réplicas d’un déploiement, ce qui est essentiel pour répondre aux variations de la demande.

### 4.2.1 Mise à l’Échelle Manuelle

Vous pouvez manuellement augmenter ou réduire le nombre de réplicas pour un déploiement avec la commande suivante :

```bash
kubectl scale deployment my-deployment --replicas=5
```

### 4.2.2 Mise à l’Échelle Automatique avec l’HPA

L’**Horizontal Pod Autoscaler (HPA)** ajuste automatiquement le nombre de pods en fonction des besoins en ressources, comme l'utilisation de la CPU.

Exemple de configuration pour un autoscaler basé sur la CPU :

```bash
kubectl autoscale deployment my-deployment --cpu-percent=50 --min=2 --max=10
```

Cette commande configure l’HPA pour maintenir l’utilisation de la CPU autour de 50%, avec un minimum de 2 pods et un maximum de 10.

Pour vérifier l’état de l’HPA :

```bash
kubectl get hpa
```

---

## 4.3 Mises à Jour Continues et Roulement

Kubernetes facilite les mises à jour continues (rolling updates), permettant de déployer des nouvelles versions d’une application sans interruption du service.

### 4.3.1 Mises à Jour avec Rolling Update

Par défaut, Kubernetes utilise le rolling update pour les déploiements. Lorsque vous mettez à jour l’image d’un déploiement, Kubernetes remplace progressivement les anciens pods par de nouveaux, réduisant ainsi les interruptions.

Pour mettre à jour l’image d’un déploiement :

```bash
kubectl set image deployment/my-deployment my-container=nginx:1.19
```

Kubernetes crée de nouveaux pods avec l’image mise à jour et arrête progressivement les anciens pods.

### 4.3.2 Revert et Rollback

Si une mise à jour entraîne des erreurs, vous pouvez revenir à une version précédente avec la commande **rollback** :

```bash
kubectl rollout undo deployment/my-deployment
```

Pour vérifier l’historique des déploiements et gérer les versions, utilisez :

```bash
kubectl rollout history deployment/my-deployment
```

---

## 4.4 Surveillance et Logs

La surveillance de l’état des applications est essentielle pour détecter rapidement les problèmes. Kubernetes offre des outils pour visualiser les logs et surveiller les ressources.

### 4.4.1 Consultation des Logs des Pods

Vous pouvez consulter les logs d’un pod pour identifier d’éventuels problèmes dans les applications conteneurisées :

```bash
kubectl logs <POD_NAME>
```

Pour visualiser les logs en temps réel :

```bash
kubectl logs -f <POD_NAME>
```

### 4.4.2 Utilisation de Probes pour Vérifier l’État des Applications

Kubernetes permet de configurer des probes pour surveiller l’état des applications :

- **Liveness probe** : Vérifie si le pod doit être redémarré en cas de défaillance.
- **Readiness probe** : Indique si le pod est prêt à recevoir du trafic.

Exemple de configuration de probes dans un déploiement :

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 10
readinessProbe:
  httpGet:
    path: /ready
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 10
```

Ces probes garantissent que Kubernetes peut gérer efficacement les pods défaillants et rediriger le trafic vers des pods prêts à recevoir des requêtes.

---

## 4.5 Bonnes Pratiques pour le Maintien des Applications

Pour garantir la disponibilité et la fiabilité des applications dans un environnement de production, suivez ces bonnes pratiques :

- **Configurer des limites de ressources** : Évitez que certains pods consomment toute la capacité du cluster en définissant des limites pour CPU et RAM.
- **Automatiser les mises à jour** : Utilisez des pipelines CI/CD pour déployer automatiquement les nouvelles versions des applications.
- **Surveiller les métriques** : Intégrez des outils de monitoring (par exemple, Prometheus et Grafana) pour obtenir des métriques détaillées sur l’utilisation des ressources et détecter les anomalies.
- **Activer les alertes** : Configurez des alertes pour recevoir des notifications en cas de défaillances ou de dépassements de seuils.

---

Ce chapitre vous a introduit aux techniques de déploiement et de maintien d’applications dans Kubernetes. Avec ces compétences, vous êtes maintenant prêt à explorer les stratégies de sécurité et à gérer l’accès aux ressources dans un cluster Kubernetes.
# Chapitre 5 : Gestion de la Sécurité dans Kubernetes

La sécurité est un aspect essentiel de la gestion d’un cluster Kubernetes, en particulier dans un environnement de production où les applications sont exposées à divers risques. Dans ce chapitre, nous abordons les principaux concepts de sécurité dans Kubernetes, notamment le contrôle des accès, la gestion des réseaux et la protection des informations sensibles.

## 5.1 Contrôle d’Accès Basé sur les Rôles (RBAC)

**RBAC (Role-Based Access Control)** permet de gérer les permissions et de restreindre les actions des utilisateurs ou des applications au sein d’un cluster Kubernetes. Grâce à RBAC, vous pouvez limiter les accès et les actions, augmentant ainsi la sécurité de votre environnement.

### 5.1.1 Principes de RBAC

RBAC repose sur trois concepts principaux :

- **Role** : Définit les permissions pour des ressources spécifiques dans un namespace. Par exemple, un rôle peut permettre la lecture des pods sans permettre leur suppression.
- **ClusterRole** : Similaire au Role, mais s’applique à l’ensemble du cluster et non à un seul namespace.
- **RoleBinding et ClusterRoleBinding** : Lient des rôles ou des ClusterRoles à des utilisateurs, des groupes ou des comptes de service, attribuant ainsi les permissions définies.

### 5.1.2 Exemple de Configuration RBAC

Exemple de fichier YAML pour un rôle permettant la lecture des pods dans un namespace spécifique :

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
```

Pour attribuer ce rôle à un utilisateur ou un compte de service, utilisez un **RoleBinding** :

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: dev
subjects:
- kind: User
  name: "user1"
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

Appliquez ces configurations pour restreindre les accès dans le namespace **dev**.

---

## 5.2 Politiques Réseau (Network Policies)

Les **Network Policies** contrôlent le trafic réseau entre les pods et les segments de réseau externes. Elles permettent de limiter la communication au sein du cluster pour empêcher des accès non autorisés.

### 5.2.1 Principes des Network Policies

Une Network Policy définit les règles de trafic entrant et sortant pour un groupe de pods sélectionné. Les Network Policies reposent sur deux éléments principaux :

- **Pod Selector** : Identifie les pods auxquels s’applique la règle.
- **Policy Types** : Précise si la règle s'applique au trafic entrant (Ingress) ou sortant (Egress).

### 5.2.2 Exemple de Configuration Network Policy

Voici un exemple de Network Policy permettant uniquement aux pods ayant le label `app: frontend` de communiquer avec les pods ayant le label `app: backend` dans le namespace **dev** :

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
  namespace: dev
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
```

Cette configuration limite l’accès aux pods ayant le label `app: backend` aux seuls pods `app: frontend`, bloquant ainsi tout autre trafic entrant.

---

## 5.3 Gestion des Secrets et ConfigMaps

Kubernetes utilise les **Secrets** pour gérer les informations sensibles, comme les mots de passe et les clés d'API. Les **ConfigMaps** permettent de stocker des données de configuration pour les applications sans avoir à les insérer dans le code des conteneurs.

### 5.3.1 Création et Utilisation des Secrets

Les **Secrets** dans Kubernetes sont encodés en base64 pour une protection de base des informations. Ils peuvent être créés manuellement ou à partir de fichiers existants.

Exemple de création d’un Secret pour stocker un mot de passe :

```bash
kubectl create secret generic my-secret --from-literal=password=MySuperSecretPassword
```

Exemple d’utilisation d’un fichier YAML pour un Secret :

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  password: bXlzdXBlcnNlY3JldHBhc3N3b3Jk # Encodé en base64
```

Vous pouvez utiliser ce Secret dans un pod en l’injectant comme variable d’environnement ou en le montant comme un fichier.

### 5.3.2 Création et Utilisation des ConfigMaps

Les **ConfigMaps** sont utilisés pour stocker des configurations non sensibles, comme des fichiers de configuration ou des variables d'environnement.

Exemple de création d’un ConfigMap à partir de lignes de commandes :

```bash
kubectl create configmap my-config --from-literal=key1=value1 --from-literal=key2=value2
```

Pour lier un ConfigMap à un pod, utilisez-le comme variable d’environnement ou montez-le comme un volume.

Exemple de fichier YAML pour utiliser un ConfigMap dans un pod :

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    envFrom:
    - configMapRef:
        name: my-config
```

---

## 5.4 Bonnes Pratiques pour la Sécurité dans Kubernetes

Pour sécuriser davantage votre cluster Kubernetes, appliquez les bonnes pratiques suivantes :

- **Utiliser des quotas de ressources** : Limitez les ressources attribuées aux pods pour prévenir les surcharges.
- **Activer l’audit** : Configurez l’audit de Kubernetes pour enregistrer et surveiller les actions dans le cluster.
- **Isoler les environnements** : Utilisez les namespaces pour séparer les environnements (développement, test, production).
- **Contrôler l’accès réseau** : Configurez des Network Policies pour restreindre les communications entre les services.
- **Gérer les Secrets** : Utilisez des outils externes de gestion de secrets (ex : HashiCorp Vault) pour stocker et contrôler l’accès aux informations sensibles.
- **Restreindre les permissions** : Appliquez le principe de moindre privilège en attribuant les rôles et les permissions minimales nécessaires.

---

Ce chapitre vous a introduit aux concepts de sécurité dans Kubernetes, avec un focus sur le contrôle des accès, les configurations réseau et la gestion des informations sensibles. Ces compétences sont essentielles pour garantir la sécurité et l’intégrité des applications dans un cluster Kubernetes.

# Chapitre 6 : Kubernetes Avancé et Bonnes Pratiques

Ce chapitre couvre des fonctionnalités avancées de Kubernetes pour optimiser les performances, garantir la haute disponibilité et faciliter la maintenance du cluster. Nous abordons également les meilleures pratiques pour gérer un environnement Kubernetes en production.

## 6.1 Gestion de la Scalabilité et de la Haute Disponibilité

La scalabilité et la haute disponibilité sont deux aspects clés pour assurer la résilience des applications et des clusters Kubernetes. 

### 6.1.1 Haute Disponibilité pour le Plan de Contrôle (Control Plane)

Pour garantir la haute disponibilité du cluster, le plan de contrôle (control plane) doit être redondant. Cette configuration inclut plusieurs nœuds maîtres (API Servers, Scheduler, Controller Manager) et une base de données distribuée **ETCD**.

- **ETCD** doit être déployé sur plusieurs nœuds pour assurer la persistance des données.
- Utiliser un **load balancer** pour répartir les requêtes entre les API Servers.

### 6.1.2 Autoscaling du Cluster

L’autoscaling du cluster permet d'ajuster automatiquement les ressources en ajoutant ou supprimant des nœuds en fonction de la charge. Kubernetes offre deux types d’autoscaling :

- **Horizontal Pod Autoscaler (HPA)** : Ajuste le nombre de pods pour un déploiement spécifique.
- **Cluster Autoscaler** : Ajuste le nombre de nœuds dans le cluster en fonction des besoins en ressources.

Exemple de configuration pour le **Horizontal Pod Autoscaler** :

```bash
kubectl autoscale deployment my-app --cpu-percent=60 --min=2 --max=10
```

Pour le Cluster Autoscaler, utilisez les configurations spécifiques de votre fournisseur de cloud (par exemple, GKE, EKS, AKS) ou installez l’outil Cluster Autoscaler pour les environnements on-premise.

---

## 6.2 Monitoring et Gestion des Logs

La surveillance des métriques et la gestion des logs sont essentielles pour la gestion proactive des applications et pour le diagnostic des problèmes en production.

### 6.2.1 Intégration de Prometheus et Grafana pour le Monitoring

**Prometheus** est une solution de surveillance populaire pour Kubernetes, offrant la collecte de métriques sur les ressources (CPU, mémoire) et les performances des applications. **Grafana** est souvent utilisé pour visualiser ces métriques.

#### Déploiement de Prometheus

Vous pouvez déployer Prometheus avec Helm ou à partir de fichiers de configuration YAML.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
```

#### Visualisation avec Grafana

Une fois Prometheus configuré, vous pouvez connecter **Grafana** pour créer des tableaux de bord et des alertes en temps réel.

- **Alertes** : Configurez des alertes pour être notifié en cas de dépassement de seuils (ex : utilisation CPU).
- **Tableaux de bord** : Créez des visualisations pour suivre la santé du cluster et des applications.

### 6.2.2 Gestion des Logs avec Fluentd ou Elastic Stack

Pour une gestion avancée des logs, Kubernetes peut intégrer des outils comme **Fluentd** ou l'**Elastic Stack** (Elasticsearch, Logstash, Kibana).

- **Fluentd** collecte et centralise les logs des applications et de Kubernetes.
- **Elastic Stack** permet de stocker, d’analyser et de visualiser les logs pour faciliter le débogage et le suivi des erreurs.

Exemple de déploiement Fluentd pour capturer les logs de Kubernetes et les envoyer vers Elasticsearch :

```bash
helm repo add elastic https://helm.elastic.co
helm install elasticsearch elastic/elasticsearch
helm install fluentd fluent/fluentd-elasticsearch
```

---

## 6.3 Bonnes Pratiques de Déploiement et de Gestion de Kubernetes

Pour garantir la stabilité, la sécurité et la maintenabilité du cluster, voici quelques bonnes pratiques à suivre.

### 6.3.1 Organiser et Versionner les Manifests

Utilisez un outil de gestion de configuration comme **Helm** ou **Kustomize** pour organiser les manifests (fichiers YAML) et faciliter le déploiement de différentes versions des applications.

- **Helm** permet de créer des packages d’applications, appelés charts, pour gérer les versions et déployer les applications avec leurs dépendances.
- **Kustomize** intègre les configurations spécifiques à différents environnements (production, staging, développement).

### 6.3.2 Gérer les Ressources avec les Limites et les Quotas

Configurer des **quotas de ressources** pour limiter la consommation de CPU et de mémoire des pods :

- **Requests** : Ressources minimales requises pour démarrer un pod.
- **Limits** : Limites maximales de consommation de ressources d’un pod.

Exemple de configuration de limites de ressources dans un déploiement :

```yaml
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"
```

Les quotas de ressources empêchent les pods de monopoliser les ressources du cluster, améliorant ainsi la stabilité et l'équité entre les applications.

### 6.3.3 Sécuriser les Images des Conteneurs

Les images des conteneurs doivent être sécurisées pour prévenir les vulnérabilités :

- **Scanner les images** : Utilisez des outils comme **Clair** ou **Trivy** pour détecter les vulnérabilités dans les images.
- **Utiliser des images de confiance** : Optez pour des images vérifiées dans des registres sécurisés.
- **Restreindre les permissions** : Évitez d'utiliser des conteneurs qui s'exécutent avec des privilèges élevés.

### 6.3.4 Automatiser les Déploiements avec CI/CD

Automatisez le déploiement des applications avec des pipelines CI/CD pour réduire les erreurs manuelles et garantir la cohérence entre les versions. Les outils populaires incluent **Jenkins**, **GitLab CI**, et **Argo CD**.

- **Jenkins** ou **GitLab CI** permettent de configurer des pipelines pour construire, tester et déployer des conteneurs.
- **Argo CD** fournit un système de déploiement GitOps, où les configurations du cluster sont gérées directement dans un dépôt Git.

---

## 6.4 Optimisation des Performances et Nettoyage des Ressources

Pour maintenir la performance et la propreté du cluster, il est important de régulièrement optimiser les ressources et de nettoyer les objets inutilisés.

### 6.4.1 Optimiser l’Utilisation des Ressources

Utilisez des outils comme **kubectl top** ou des solutions de monitoring pour analyser l'utilisation des ressources et ajuster les limites de CPU et de mémoire pour chaque pod en fonction de ses besoins réels.

### 6.4.2 Supprimer les Objets Inutilisés

Pour éviter l’encombrement du cluster, il est important de régulièrement supprimer les ressources non utilisées (pods, services, volumes, etc.).

- **kubectl delete** : Utilisez cette commande pour supprimer des ressources spécifiques qui ne sont plus nécessaires.
- **Garbage Collection** : Kubernetes gère automatiquement la suppression des objets orphelins, mais il est conseillé de vérifier et d’effectuer des nettoyages réguliers.

---

Ce chapitre vous a introduit aux fonctionnalités avancées et aux meilleures pratiques pour gérer et optimiser un cluster Kubernetes en production. En appliquant ces stratégies, vous pourrez maintenir un environnement Kubernetes stable, performant et sécurisé.
