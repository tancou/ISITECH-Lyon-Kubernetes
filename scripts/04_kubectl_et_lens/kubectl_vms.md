# Récupérer le kubeconfig des VMs du cours

## Extraction

Depuis le SSH de la VM master, affichez le contenu du fichier `kuebconfig` dans le terminal avec la commande 
```
ubuntu@ISI06vm1:~$ cat /home/ubuntu/kubeconfig
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: <base-64-string>
    server: https://127.0.0.1:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    client-certificate-data: <base-64-string>
    client-key-data: <base-64-string>
```

Copiez collez le contenu.

## Import dans lens

Ouvrez Lens après avoir connecté votre compte et choisi le forfait gratuit.

Cliquez sur `Fichier` et `Ajouter un cluster`.

Dans le champ de saisi, collez le kubeconfig précédement récupéré.

Attention, **vous devez changer l'url** du cluster.

Remplacez `https://127.0.0.1:6443` par `https://isitech.<domain>.fr:9XX2`. Notez que le port finit par `2`.

Contrairement au port SSH que vous avez pu voir précedemment, ici c'est un second port en HTTPS qui est redirigé sur le
port de l'api du k3s, qui est normalement `6443`. Hors comme il y a plusieurs clusters, vos ports de l'api vous sont
réattribués.

Validez, vous devriez avoir un nouveau cluster `default` dans votre liste de clusters. 🎉