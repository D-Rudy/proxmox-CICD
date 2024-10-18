# Proxmox Container Deployment Script

Script automatisé pour déployer des conteneurs LXC sur Proxmox VE avec une configuration prédéfinie.

## 🚀 Prérequis

- Proxmox VE 7.0 ou supérieur
- Accès root au serveur Proxmox
- Template Debian 12 disponible
- Clé SSH configurée

## 📋 Installation

1. Clonez le dépôt :
```bash
git clone https://github.com/D-Rudy/proxmox-CICD.git
cd proxmox-CICD
cp config/containers.sh.exemple config/containers.sh
cp .env.exemple .env
```
## Mettre vos valeurs et vos paramètre perso dans ces fichier

🔒 Sécurité

Ne commitez JAMAIS de fichiers .env ou config contenant des données sensibles
Utilisez des clés SSH plutôt que des mots de passe
Les conteneurs sont créés non privilégiés par défaut
Vérifiez et adaptez les permissions réseau selon vos besoins