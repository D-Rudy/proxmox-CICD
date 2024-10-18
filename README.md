# proxmox-CICD

### conteneur Jenkins:  
Debian 11  
Hostname= jenkins-pipeline  
RAM: 3072  
2 CPU  
Ext:    
  - java default-jre sur docker  
  - jenkins sans docker (éviter docker in docker)  
  - ansible / sshpass /gpg -> pipelining = true && allow   readable tmp = true sans docker  
  - git sans docker  
  - docker -> usermod -aG docker jenkins  
  - registry -> insecure registries (évite de générer des certificats ssl)  

***

### Conteneur Serveur Dev:  
Debian 11  
Hostname= srv-dev  
RAM: 512  
1 CPU  

***

### Conteneur Serveur Stage:  
Debian 11  
Hostname= srv-stage  
RAM: 512  
1CPU  

***

### Conteneur Serveur Prod:
Debian 11
Hostname= srv-prod
RAM: 512
1 CPU

***

### Conteneur serveur BDD(postgre) Dev  
Debian 11  
hostname: postgresql-dev  
RAM: 512  
1 CPU  

***

### Conteneur serveur BDD(postgre) Recette
Debian 11  
hostname: postgresql-recette
RAM: 512  
1 CPU  

***

### Conteneur serveur BDD(postgre) PROD  
Debian 11  
hostname: postgresql-prod  
RAM: 512  
1 CPU  

***

### Conteneur Registry  

Debian 11  
hostname: registry  
RAM: 512  
1 CPU  

***

### Conteneur Serveur Gitlab  

Ubuntu 20.04  
hostname: :gitlab  
ram: 2048  
1 CPU  