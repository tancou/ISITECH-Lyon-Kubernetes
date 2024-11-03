# Kube Isitech

## Getting started

Ce repo reprend toute la configuration nécessaire pour redéployer le cluster de dev kubernetes pour un groupe d'étudiants chez Isitech à Lyon en bac+4.

On suppose la chose suivante :
- Les étudiants sont en groupe de 4
- Il leur a été attribué un numéro de cluster, que l'on nommera `XX`, allant de `01` à `09`
- Ils ont accès aux VMs du professeur.

## Configuration des VMs

### Connexion SSH

Ouvrez votre shell ou powershell préféré et executez la commande :
```bash
ssh -p 9XX1 ubuntu@isitech.<domain>.fr
# Le <domain> est à remplacer par celui communiqué par le professeur.
# Acceptez la clef de connexion
```

### Masters :

- `ISIXXvm1` :
    - os : `Ubuntu 22.04`
    - hostname : `ISIXXvm1`
    - user : `ubuntu`
    - password : fourni par le professeur
    - network : `10.52.XX.1/24`
      - Ports ouverts sur internet :
        - port SSH : `9XX1`
        - port kube-api : `9XX2`
    - disk : `60Gb`
    - ram : `8Gb`
    - cpu : `4`

### Workers :

- `ISIXXvm2` :
    - os : `Ubuntu 22.04`
    - hostname : `ISIXXvm12`
    - user : `ubuntu`
    - password : fourni par le professeur
    - network : `10.52.XX.2/24`
    - disk : `60Gb`
    - ram : `8Gb`
    - cpu : `4`


- `ISIXXvm3` :
    - os : `Ubuntu 22.04`
    - hostname : `ISIXXvm1`
    - user : `ubuntu`
    - password : fourni par le professeur
    - network : `10.52.XX.3/24`
    - disk : `60Gb`
    - ram : `8Gb`
    - cpu : `4`


- `ISIXXvm4` :
    - os : `Ubuntu 22.04`
    - hostname : `ISIXXvm1`
    - user : `ubuntu`
    - password : fourni par le professeur
    - network : `10.52.XX.4/24`
    - disk : `60Gb`
    - ram : `8Gb`
    - cpu : `4`

### Commandes de bases pour l'installation

Voir la documentation [Préparation VM](preparation_vm.md)

### Installation des clefs ssh

Sur `ISIXXvm1` :
```bash
# Generation de la clef ssh
ssh-keygen
# Faire suivant pour toutes les questions sans rajouter de réponse.
# Ne mettez PAS de mot de passe

# Envoyer la clef sur les 3 VM workers :
# Attention dans les IP, ont ne précise pas le 0 dans votre numéro.
# Donc pour le numéro 01, mettez 1 à la place de XX
ssh-copy-id ubuntu@10.52.XX.2
# Répondez `yes`
# Mettez le mot de passe communiqué par le professeur
ssh-copy-id ubuntu@10.52.XX.3
ssh-copy-id ubuntu@10.52.XX.4

# Rajouter la clef sur sa propre VM master :
ssh-copy-id ubuntu@10.52.XX.1

```

### Installation de [k3sup](https://github.com/alexellis/k3sup#download-k3sup-tldr)

Toujours sur la VM master `ISIXXvm1`, on installe `k3sup`.

Dans un monde parfait, on n'installe PAS k3sup sur une des VMs du cluster, mais par soucis de facilité dans ce cours, 
on utiliser la VM master comme notre machine d'installation.

```bash
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/
```

Vérifez que `k3sup` fonctionne avec la commande `k3sup version`
```
ubuntu@ISIXXvm1:~$ k3sup version
 _    _____
| | _|___ / ___ _   _ _ __
| |/ / |_ \/ __| | | |  _ \
|   < ___) \__ \ |_| | |_) |
|_|\_\____/|___/\__,_| .__/
                     |_|

bootstrap K3s over SSH in < 60s 🚀
👏 Say thanks for k3sup and sponsor Alex via GitHub: https://github.com/sponsors/alexellis

Version: 0.13.6
Git Commit: 752c22af38d11b9d57f7a5ae4add3571d0d57b3a
```

### Installation de k3s


Sur `ISIXXvm1` :
```bash
export K3S_VERSION="v1.30.5+k3s1"
# Sur ISIXXvm1
k3sup install \
    --local \
    --user ubuntu \
    --k3s-version $K3S_VERSION \
    --k3s-extra-args "--tls-san isitech.<domain>.fr --disable local-storage"
    
```
Pour ceux qui veulent instancier dans le futur un cluster en haute disponibilité, voir la variante documentée [ha_k3s.md](ha_k3s.md)

```bash
# Ajout des workers
k3sup join \
  --ip 10.52.XX.2 \
  --user ubuntu \
  --server-user ubuntu \
  --server-ip 10.52.XX.1 \
  --k3s-version ${K3S_VERSION}

k3sup join \
  --ip 10.52.XX.3 \
  --user ubuntu \
  --server-user ubuntu \
  --server-ip 10.52.XX.1 \
  --k3s-version ${K3S_VERSION}

k3sup join \
  --ip 10.52.XX.4 \
  --user ubuntu \
  --server-user ubuntu \
  --server-ip 10.52.XX.1 \
  --k3s-version ${K3S_VERSION}

```

### Pour changer la modif après installation

Just append it to the CLI arguments in the systemd unit (`/etc/systemd/system/k3s.service`) after "k3s server ...". `Then systemctl daemon-reload && systemctl restart k3`.

### Accès kubectl

```bash
export KUBECONFIG=/home/ubuntu/kubeconfig
kubectl config use-context default
kubectl get node -o wide
```

### Auto purge images

Avec `sudo crontab -e`

```
0 23 */15 * * /usr/local/bin/crictl rmi --prune >/dev/null 2>&1
```

### Taint master

La teinture pour spécifier qu'un noeud kubernetes est un master permet d'éviter que la charge de travail des pods soient
déployée sur ces noeuds là. Par essence un master ne doit pas servir de ressource pour la charge des logiciels.

```
kubectl taint nodes isiXXvm1 node-role.kubernetes.io/master=:NoSchedule
```