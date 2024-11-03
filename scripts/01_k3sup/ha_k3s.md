# HA Kubernetes

Pour ceux qui veulent une vraie redondance, on utilise toujours au minimum 3 masters.

Voici un example de commandes pour instancier 3 masters et 3 workers :

On a en general en plus une ip de loadbalancer `LB_IP`, qui gère la mort d'un master, c'est une configuration compliquée.
Si vous ne pouvez pas avoir le luxe d'avoir un loadbalancer devant vos masters, mettez l'IP du master 1.

On suppose dans cet exemple
- un réseau en `10.0.0.0/24`.
  - master1 : `10.0.0.21`
  - master2 : `10.0.0.22`
  - master3 : `10.0.0.23`
  - worker1 : `10.0.0.41`
  - worker2 : `10.0.0.42`
  - worker3 : `10.0.0.43`
  - `10.0.0.10` => redirige sur
    - `10.0.0.21`
    - `10.0.0.22`
    - `10.0.0.23`
- que l'utilisateur est `user`

```bash
export K3S_VERSION="v1.30.5+k3s1"
export LB_IP="10.0.0.10"
# Sur master 1 (10.0.0.21)
# Notez la présence du --cluster qui active etcd, le mode HA de k3s
k3sup install \
    --local \
    --user user \
    --k3s-version $K3S_VERSION \
    --cluster \
    --k3s-extra-args "
        --tls-san '${LB_IP}'
        --disable local-storage
    "
# add other masters
k3sup join \
    --ip 10.0.0.22 \
    --user user \
    --server-user user \
    --server-ip ${LB_IP} \
    --server \
    --k3s-version $K3S_VERSION \
    --k3s-extra-args "--disable local-storage"

k3sup join \
    --ip 10.0.0.23 \
    --user user \
    --server-user user \
    --server-ip ${LB_IP} \
    --server \
    --k3s-version $K3S_VERSION \
    --k3s-extra-args "--disable local-storage"

# Ajout des workers
k3sup join \
  --ip 10.0.0.41 \
  --server-ip ${LB_IP} \
  --user user \
  --k3s-version ${K3S_VERSION}

k3sup join \
  --ip 10.0.0.42 \
  --server-ip ${LB_IP} \
  --user user \
  --k3s-version ${K3S_VERSION}

k3sup join \
  --ip 10.0.0.43 \
  --server-ip ${LB_IP} \
  --user user \
  --k3s-version ${K3S_VERSION}
```