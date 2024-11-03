# Chapitre 4 : Déploiement et Maintien d’Applications

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
