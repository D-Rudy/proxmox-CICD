# proxmox-CICD

### conteneur Jenkins:
Debian 11
Hostname= jenkins-pipeline
ip:
RAM: 3072
2 CPU
Ext:    - java default-jre sur docker
		- jenkins sans docker (éviter docker in docker)
		- ansible / sshpass /gpg -> pipelining = true && allow readable tmp = true sans docker
		- git sans docker
		    - docker -> usermod -aG docker jenkins
            - registry -> insecure registries (évite de générer des certificats ssl)

***

### conteneur Serveur Dev:
Debian 11
Hostname= srv-dev
RAM: 512
1 CPU

***

### conteneur Serveur Stage:
Debian 11
Hostname= srv-stage
RAM: 512
1CPU

***

### conteneur Serveur Prod:
Debian 11
Hostname= srv-prod
RAM: 512
1 CPU

***

### conteneur serveur BDD(postgre) Dev\n
Debian 11\n
hostname: postgresql-dev\n
RAM: 512\n
1 CPU\n

***

### conteneur serveur BDD(postgre)STAGE
Debian 11
hostname: postgresql-stage
RAM: 512
1 CPU

***

### conteneur serveur BDD(postgre) PROD
Debian 11
hostname: postgresql-prod
RAM: 512
1 CPU

***

### Registry

Debian 11
hostname: registry
RAM: 512
1 CPU

***

### Serveur Gitlab

Ubuntu 20.04
hostname: :gitlab
ram: 2048
1 CPU