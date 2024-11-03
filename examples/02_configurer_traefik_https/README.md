# Configuration du https support

Un reverse proxy qui résout les requêtes https est fournis par le professeur.

Il se compose de plusieurs parties :
- DNS : `<service>-kube<XX>.isitech.<domain>.fr`
- Le https est activé par défaut dessus
- `<service>` peut être remplacé par ce que vous souhaitez, mais il ne peut pas être vide
- `<XX>` est a remplacer par votre numéro de cluster, par exemple `01`
- `<domain>` est le domaine DNS du professeur, il vous sera fourni durant le cours.

Par défaut, le port `http (80)` est automatiquement redirigé sur le `https (443)`

🚨 Important : le nom de l'ingress doit être entièrement en MINUSCULE !

Cette configuration est générique sur le cluster entièrement.

```bash
kubectl apply -f traefik-config.yaml
```