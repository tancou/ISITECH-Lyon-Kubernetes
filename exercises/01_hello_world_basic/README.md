# Exercice 1 : Déployer un Serveur Nginx avec un Message "Hello World" et un Volume Persistant

## Objectif

Dans cet exercice, vous allez créer un déploiement simple d’un serveur **Nginx** qui affiche le message **Hello World**. Ce déploiement sera configuré dans un **namespace spécifique** et inclura un **volume persistant** basé sur Longhorn pour stocker le contenu de la page web.

## Instructions

1. **Créer un Namespace** : Créez un namespace spécifique pour cet exercice nommé selon le modèle suivant : `nom-etudiant-exo1`. Par exemple, si votre nom est "Martin", le namespace sera `martin-exo1`. Un namescape est toujours en minuscule.

2. **Configurer le Volume Persistant** :
   - Créez un **PersistentVolumeClaim (PVC)** pour votre déploiement. Ce PVC doit utiliser **Longhorn** comme solution de stockage et demander **1 Gi** d’espace.
   - Assurez-vous que le PVC est attaché au namespace que vous avez créé.

3. **Déployer le Serveur Nginx** :
   - Créez un déploiement Nginx avec un seul pod.
   - Configurez le déploiement pour monter le volume persistant depuis le PVC que vous venez de créer. Le contenu du volume doit être monté dans le dossier `/usr/share/nginx/html` du conteneur Nginx.
   
4. **Configurer le Message "Hello World"** :
   - Dans le volume monté, créez un fichier `index.html` contenant le texte **Hello World**. Ce fichier doit être persistant et ne pas disparaître si le pod est redémarré.
   - NB: renseignez vous sur la commande `kubectl cp`
5. **Exposer le Déploiement** :
   - Créez un **service** de type `ClusterIP` pour permettre l’accès au pod Nginx depuis d'autres pods au sein du cluster.

6. **Créer une Ressource Ingress** :

   - Ajoutez une ressource Ingress dans le namespace pour exposer le service Nginx à l'extérieur du cluster.
   Configurez l’Ingress pour rediriger le trafic du domaine `exo1-<nom-etudiant>-kube<XX>.isitech.<domain>.fr` vers le service Nginx sur le port 80.
   - Note : Assurez-vous que l’Ingress Controller est configuré dans votre cluster pour que l’Ingress fonctionne.
   - De plus, _un ingress est unique pour tout le cluster_, veillez à ce que chaque URL contienne bien votre nom.
   - Un ingress doit toujours être en _minuscule_.

6. **Vérification** :
   - Accédez au service Nginx pour vérifier que le message "Hello World" s’affiche correctement en accédant au chemin `/usr/share/nginx/html/index.html`.
   - Assurez-vous que le contenu persiste même en cas de redémarrage du pod.

## Évaluation

- **Namespace** : Le déploiement doit être isolé dans le namespace dédié (`nom-etudiant-exo1`).
- **Volume Persistant** : Le PVC doit utiliser la classe de stockage Longhorn et être monté correctement.
- **Affichage** : Le fichier `index.html` dans le volume monté doit afficher **Hello World**.
- **Persistance des Données** : Le contenu du volume persiste même après le redémarrage du pod.

## Kubectl

➡️ [Cheatsheet kubectl](https://kubernetes.io/fr/docs/reference/kubectl/cheatsheet/)

Appliquer un fichier :
```bash
kubectl apply -n mon-namespace -f fichier.yaml
```

Appliquer tous les .yaml d'un dossier :
```bash
kubectl apply -n mon-namespace  -f ./dossier
```

## Faire du ménage
Pour supprimer un namespace dans Kubernetes avec `kubectl`, utilisez la commande suivante :

```bash
kubectl delete namespace <nom-du-namespace>
```


> **Remarque** : La suppression d'un namespace entraîne également la suppression de toutes les ressources qu'il contient (pods, services, déploiements, etc.). Assurez-vous de ne pas supprimer des données importantes avant d'exécuter cette commande.

> Vous ne pouvez pas supprimer le namespace `default`. Attention à ne pas déployer dedans, sinon il faudra tout nettoyer à la main !

---

**Note** : Cet exercice permet de se familiariser avec les concepts de namespace, de déploiement, de volumes persistants et d’exposition de services dans Kubernetes.