#!/bin/bash

# Fonction pour obtenir le prochain ID disponible
get_next_id() {
    local highest_id=100
    local vm_id=$(qm list 2>/dev/null | tail -n +2 | awk '{print $1}' | sort -n | tail -n 1 || echo "100")
    local ct_id=$(pct list 2>/dev/null | tail -n +2 | awk '{print $1}' | sort -n | tail -n 1 || echo "100")
    
    highest_id=$(( vm_id > ct_id ? vm_id : ct_id ))
    echo $((highest_id + 1))
}

# Vérification des prérequis
check_prerequisites() {
    echo "Vérification des prérequis..."
    
    if [[ ! -f "$SSH_KEY_PATH" ]]; then
        echo "Erreur: Clé SSH non trouvée à $SSH_KEY_PATH"
        exit 1
    }
    
    if ! command -v pct &> /dev/null; then
        echo "Erreur: Proxmox VE n'est pas installé"
        exit 1
    }

    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Erreur: Fichier de configuration non trouvé à $CONFIG_FILE"
        exit 1
    }
}

# Création d'un conteneur
create_container() {
    if [[ $# -ne 6 ]]; then
        echo "Usage: create_container <name> <ram> <cpu> <storage> <ip> <gw>"
        return 1
    }

    local name="$1"
    local ram="$2"
    local cpu="$3"
    local storage="$4"
    local ip="$5"
    local gw="$6"
    local id=$(get_next_id)

    echo "Création du conteneur $name avec ID $id"

    # Vérification du template
    check_and_download_template

    # Création du conteneur
    if ! pct create "$id" "$DEFAULT_TEMPLATE" \
        --hostname "$name" \
        --memory "$ram" \
        --cores "$cpu" \
        --net0 "name=eth0,bridge=$NETWORK_BRIDGE,ip=$ip/24,gw=$gw" \
        --storage "$STORAGE_TYPE" \
        --rootfs "$STORAGE_TYPE:$storage" \
        --unprivileged 1 \
        --features nesting=1 \
        --onboot 1 \
        --ssh-public-keys "$SSH_KEY_PATH"; then
        echo "Erreur lors de la création du conteneur $name"
        return 1
    fi

    # Configuration post-création
    post_container_setup "$id" "$name"

    echo "Conteneur $name créé avec succès"
}

# Vérification et téléchargement du template
check_and_download_template() {
    if ! pveam list local | grep -q "debian-12-standard"; then
        echo "Template Debian 12 non trouvé. Installation..."
        pveam update
        pveam download local debian-12-standard_12.7-1_amd64.tar.zst
    fi
}

# Configuration post-création
post_container_setup() {
    local id="$1"
    local name="$2"

    # Ajoutez ici des configurations supplémentaires si nécessaire
    echo "Configuration post-installation pour $name (ID: $id)"
}

# Création de tous les conteneurs
create_all_containers() {
    for name in "${!containers[@]}"; do
        read -r ram cpu storage ip gw <<< "${containers[$name]}"
        create_container "$name" "$ram" "$cpu" "$storage" "$ip" "$gw"
    done
}