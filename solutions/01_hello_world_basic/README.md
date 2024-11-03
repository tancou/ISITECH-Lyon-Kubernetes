# Exercice 1 : Déployer un Serveur Nginx avec un Message "Hello World" et un Volume Persistant

## Objectif

Dans cet exercice, vous allez créer un déploiement simple d’un serveur **Nginx** qui affiche le message **Hello World**. Ce déploiement sera configuré dans un **namespace spécifique** et inclura un **volume persistant** basé sur Longhorn pour stocker le contenu de la page web.

## Instructions

1. **Créer un Namespace** : Créez un namespace spécifique pour cet exercice nommé selon le modèle suivant : `nom-etudiant-exo1`. Par exemple, si votre nom est "Martin", le namespace sera `martin-exo1`. Un namespace est toujours en minuscule.

2. **Configurer le Volume Persistant** :
   - Créez un **PersistentVolumeClaim (PVC)** pour votre déploiement. Ce PVC doit utiliser **Longhorn** comme solution de stockage et demander **1 Gi** d’espace.
   - Assurez-vous que le PVC est attaché au namespace que vous avez créé.

3. **Déployer le Serveur Nginx** :
   - Créez un déploiement Nginx avec un seul pod.
   - Configurez le déploiement pour monter le volume persistant depuis le PVC que vous venez de créer. Le contenu du volume doit être monté dans le dossier `/usr/share/nginx/html` du conteneur Nginx.
   
4. **Configurer le Message "Hello World"** :
   - Dans le volume monté, créez un fichier `index.html` contenant le texte **Hello World**. Ce fichier doit être persistant et ne pas disparaître si le pod est redémarré.
   
5. **Exposer le Déploiement** :
   - Créez un **service** de type `ClusterIP` pour permettre l’accès au pod Nginx depuis d'autres pods au sein du cluster.

6. **Vérification** :
   - Accédez au service Nginx pour vérifier que le message "Hello World" s’affiche correctement en accédant au chemin `/usr/share/nginx/html/index.html`.
   - Assurez-vous que le contenu persiste même en cas de redémarrage du pod.

## Correction:

On va créer d'abord le namespace s'il n'existe pas déjà :
```bash
kubectl apply -f namespace.yaml
```

Maintenant que le namescape existes, on peut déclarer le restant des fichiers :
```bash
kubectl apply -n prenom-exo1 -f .
```

On peut maintenant regarder notre déploiement autant via Lens, qu'avec kubectl :
```bash
kubectl get pods -n prenom-exo1
```

On va copier notre fichier index.html dans notre volume qui est monté dans le pod `nginx-xxxxxx`
```bash
kubectl cp -n prenom-exo1 index.html nginx-deployment-xxxxxx:/usr/share/nginx/html/index.html
```

On vérifie dans mon navigateur avec l'url de l'ingress que la bonne page `index.html` s'affiche. Si besoin, je force le
rafraichissement de ma page avec `Ctrl`+`Shift`+`R`.