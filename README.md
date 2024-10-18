# Configuration détaillée de l'infrastructure CI/CD sur Proxmox VE 8

Ce document détaille la configuration des différents conteneurs et VMs nécéssaire pour un pipeline CI/CD hébergée sur Proxmox VE 8. Elle inclus des estimations sur spécifications matérielles, les systèmes d'exploitation ainsi que  des explications approfondies sur les choix effectués.

## Contexte global

Cette chaine CI/CD est déployée sur Proxmox VE 8, une plateforme de virtualisation open-source basée sur Debian. Ce choix permet une gestion efficace des ressources, une haute disponibilité, et une flexibilité dans la configuration des VMs et conteneurs.

## Conteneur Jenkins (VM)

- **OS**: Debian 12
- **Hostname**: jenkins-pipeline
- **RAM**: 3072 MB
- **CPU**: 2
- **Disque**: 30 GB

**Extensions et configurations**:
- Java (default-jre) sur Docker
- Jenkins sans Docker
- Ansible, sshpass, gpg (avec `pipelining = true` et `allow readable tmp = true`) sans Docker
- Git sans Docker
- Docker (avec `usermod -aG docker jenkins`) (permission sur docker et jenkins)
- Registry configuré en insecure (pour éviter la génération de certificats SSL)

**Justification détaillée**: 
- **Ressources allouées**: 3072 MB de RAM et 2 CPUs sont nécessaires pour gérer efficacement les builds simultanés et les tâches de CI/CD intensives.
- **30 GB de disque**: Cela permet de stocker les builds, les artefacts, et les logs sans risque de saturation rapide.

**Configuration Docker**:
- **Java en Docker**: L'utilisation de Java dans un conteneur Docker permet une gestion plus facile des versions et évite les conflits potentiels avec d'autres dépendances du système.
- **Autres outils hors Docker**: 
  - Jenkins est installé directement sur la VM pour éviter la complexité de "Docker in Docker" et pour une meilleure performance.
  - Ansible, Git, et autres outils sont installés nativement pour une meilleure intégration avec le système et une performance optimale.
  - Cette approche permet également un meilleur contrôle sur les mises à jour et la configuration de ces outils critiques.

**Sécurité**:
- L'utilisation d'un registry insecure est un compromis pour simplifier la configuration, mais devrait être sécurisé dans un environnement de production réel.

## Conteneurs Serveurs (Dev, Recette, Prod)

### Configurations communes
- **OS**: Ubuntu 20.04
- **RAM**: 512 MB
- **CPU**: 1
- **Disque**: 15 GB

### Spécificités
- **Dev**: Hostname: srv-dev
- **Stage**: Hostname: srv-recette
- **Prod**: Hostname: srv-prod

**Justification détaillée**: 
- **Ubuntu 20.04 LTS**: Choisi pour sa stabilité à long terme, ses mises à jour de sécurité régulières, et sa grande compatibilité avec les applications modernes.
- **Ressources limitées**: 512 MB de RAM et 1 CPU permettent d'optimiser l'utilisation des ressources de Proxmox tout en étant suffisants pour la plupart des applications web.
- **15 GB de disque**: Augmenté à 15 GB pour accommoder le système d'exploitation, les applications, et les données temporaires des déploiements.

## Conteneurs Base de Données (PostgreSQL, Dev, Recette, Prod)

### Configurations communes
- **OS**: Ubuntu 20.04
- **RAM**: 512 MB
- **CPU**: 1

### Spécificités
- **Dev**: Hostname: postgresql-dev, Disque: 20 GB
- **Recette**: Hostname: postgresql-recette, Disque: 25 GB
- **Prod**: Hostname: postgresql-prod, Disque: 50 GB

**Justification détaillée**: 
- **Ressources adaptées**: Les ressources sont ajustées pour chaque environnement, avec une augmentation progressive de l'espace disque de Dev à Prod.
- **Disque Prod plus grand**: 50 GB pour la production afin de gérer un volume de données plus important et permettre la croissance.

## Conteneur Registry

- **OS**: Ubuntu 20.04
- **Hostname**: registry
- **RAM**: 512 MB
- **CPU**: 1
- **Disque**: 50 GB

**Justification**: 
- **Disque volumineux**: 50 GB pour stocker de nombreuses versions d'images Docker sans risque de saturation.
- **Ressources modérées**: Le registry n'a pas besoin de beaucoup de RAM ou de CPU pour fonctionner efficacement.

## Conteneur Serveur GitLab

- **OS**: Ubuntu 20.04
- **Hostname**: gitlab
- **RAM**: 2048 MB
- **CPU**: 2
- **Disque**: 50 GB

**Justification**: 
- **RAM et CPU augmentés**: GitLab nécessite plus de ressources pour gérer efficacement les opérations de versioning, les pipelines CI, et les interactions utilisateurs.
- **Disque 50 GB**: Pour stocker les repositories, les artefacts CI/CD, et permettre une croissance des projets.

## Recommandations pour l'optimisation

1. **Monitoring**: Mettre en place un système de monitoring (comme Prometheus avec Grafana) pour surveiller l'utilisation des ressources et ajuster si nécessaire.
2. **Sécurité**: Renforcer la sécurité en implémentant des certificats SSL pour le registry et en suivant les meilleures pratiques de sécurité pour chaque service.
3. **Scalabilité**: Prévoir des plans pour la scalabilité horizontale, particulièrement pour les serveurs d'application et de base de données en production.
---