#!/bin/bash

install_docker_ubuntu() {
    echo "Installing docker for Ubuntu/Debian..."
    sudo apt-get update -y
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
}


install_docker_redhat() {
    echo "Installing Docker for CentOS/RHEL/Fedora..."
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io -y
}


install_docker_amazon() {
    echo "Installing Docker for Amazon Linux..."
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo yum install -y docker
}


install_docker_other() {
    echo "Cannot get Linux distributive. Try manual installation or update installation file with instructions to your distributive"
}


install_docker() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            ubuntu|debian)
                install_docker_ubuntu
                ;;
            centos|rhel|fedora)
                install_docker_redhat
                ;;
            amzn)
                install_docker_amazon
                ;;
            *)
                install_docker_other
                ;;
        esac
    else
        install_docker_other
    fi
}

# Проверка, установлен ли Docker
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing Docker..."
    install_docker
    
    if command -v docker &> /dev/null
    then
        echo "Docker has been successfully installed."
    else
        echo "Cannot install Docker."
        exit 1
    fi
else
    echo "Docker is already installed."
fi

echo "Script is finished. Logout and login again to get changes."
