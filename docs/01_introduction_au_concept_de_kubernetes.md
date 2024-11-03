# Chapitre 1 : Introduction au Concept de Kubernetes

Ce premier chapitre introduit Kubernetes, les défis auxquels il répond et son architecture générale. L’objectif est de vous fournir une compréhension claire de son rôle et de son fonctionnement dans la gestion d’applications conteneurisées.

Diapo [pdf](01_introduction_au_concept_de_kubernetes.pdf)

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

