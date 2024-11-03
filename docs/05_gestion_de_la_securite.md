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

