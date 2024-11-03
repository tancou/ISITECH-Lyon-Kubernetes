# Préparer les VM ubuntu

Cette documentation est dans un fichier à part, car ces commandes ont déjà été faites sur les VMs fournis par le 
professeur. Cette partie de la documentation est là uniquement si vous souhaitez reproduire l'expérience chez vous.

### Commandes de bases pour l'installation

Installation de sudo si la commande n'existe pas. [Source](https://www.osradar.com/how-to-enable-sudo-on-debian-10/)
```bash
su
apt update
apt install sudo -y
```

Autorisation du sudo sans mot de passe.
```bash
sudo echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```

Installation des packages par défault
```bash
sudo apt install qemu-guest-agent curl wget htop screen git jq open-iscsi nfs-common lvm2 \
    lsscsi sg3-utils multipath-tools scsitools \
    -y
```

### Multipath avec Longhorn

https://longhorn.io/kb/troubleshooting-volume-with-multipath/

Enable and fix multipathing

```bash
sudo tee /etc/multipath.conf <<-'EOF'
defaults {
  user_friendly_names yes
}
blacklist {
  devnode "^sd[a-z0-9]+"
  device {
    vendor "IET"
    product "VIRTUAL-DISK"
  }
}
EOF

# S'il est possible de reboot la machine,
# autant le faire plutôt que les commandes suivantes

sudo systemctl restart multipathd.service
sudo service multipath-tools restart

sudo systemctl enable multipath-tools.service
sudo service multipath-tools restart

# Ensure that open-iscsi and multipath-tools are enabled and running
sudo systemctl status multipath-tools
sudo systemctl enable open-iscsi.service
sudo service open-iscsi start
sudo systemctl status open-iscsi
```