# proxmox-CICD

- Choix d'une VM Debian 11
### conteneur Jenkins:  
Debian 12  
Hostname= jenkins-pipeline  
RAM: 3072  
2 CPU  
Ext:    
  - `java default-jre` sur docker  
  - jenkins sans docker (éviter docker in docker)  
  - ansible / sshpass /gpg -> `pipelining = true && allow readable tmp = true` sans docker  
  - git sans docker  
  - docker -> `usermod -aG docker jenkins`  
  - registry -> insecure registries (évite de générer des certificats ssl)  

***

### Conteneur Serveur Dev:  

Ubuntu 20.04  
Hostname= srv-dev  
RAM: 512  
1 CPU  

***

### Conteneur Serveur Stage:  

Ubuntu 20.04  
Hostname= srv-stage  
RAM: 512  
1CPU  

***

### Conteneur Serveur Prod:

Ubuntu 20.04  
Hostname= srv-prod  
RAM: 512  
1 CPU  

***

### Conteneur serveur BDD(postgre) Dev  

Ubuntu 20.04  
hostname: postgresql-dev  
RAM: 512  
1 CPU  

***

### Conteneur serveur BDD(postgre) Recette

Ubuntu 20.04  
hostname: postgresql-recette  
RAM: 512  
1 CPU  

***

### Conteneur serveur BDD(postgre) PROD  

Ubuntu 20.04   
hostname: postgresql-prod  
RAM: 512  
1 CPU  

***

### Conteneur Registry  

Ubuntu 20.04    
hostname: registry  
RAM: 512  
1 CPU  

***

### Conteneur Serveur Gitlab  

Ubuntu 20.04  
hostname: :gitlab  
RAM: 2048  
1 CPU  