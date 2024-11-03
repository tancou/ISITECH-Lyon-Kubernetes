# RBAC

`kubectl` doit déjà être configuré avec un accès admin à votre cluster.

### Créer un nouvel admin

```bash
./create_admin.sh username url-of-the-cluster
```

### Supprimer un utilisateur avec un token relié

```bash
./delete_admin.sh username
```