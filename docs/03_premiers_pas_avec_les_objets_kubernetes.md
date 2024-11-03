# Chapitre 3 : Premiers Pas avec les Objets Kubernetes

Dans ce chapitre, nous allons explorer les objets de base de Kubernetes qui permettent de déployer, exposer et gérer des applications dans un cluster. Ces concepts sont essentiels pour comprendre comment Kubernetes orchestre les conteneurs.

Diapo [pdf](03_premiers_pas_avec_les_objets_kubernetes.pdf)

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

Ce chapitre introduit les principaux objets Kubernetes utilisés pour déployer et gérer des applications dans un cluster. Avec ces bases, vous êtes maintenant prêt à passer au chapitre suivant et à apprendre comment déployer des applications complètes dans Kubernetes.