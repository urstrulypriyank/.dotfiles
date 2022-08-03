#!/bin/bash

LOCAL_USER=$USER;
LOCAL_HOME=$HOME;
echo "Hi , $LOCAL_USER";

# functions 

function greet () {

    echo "Welcome to the initial setup script for developer"
    echo "Initially Updating package information "
    cd "$LOCAL_HOME" && sudo apt-get update;
    setup_nala;
        
};


# setting nala for first time

function setup_nala () {
    echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
    wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg



    # nala is frontend for apt
    echo "Installing Nala";
    sudo apt install nala -y

    echo "Setting Up mirrors source list to IITK"

    #  IITk mirror for nala 
    echo "deb http://mirror.cse.iitk.ac.in/ubuntu/ jammy main restricted universe multiverse
    " | sudo tee /etc/apt/sources.list.d/nala-sources.list 
    


    
}


function installation (){

echo "Installing Some essentail tools"
sudo nala install curl neofetch vlc gimp ubuntu-restricted-extras gnome-shell-extensions gnome-tweak-tool apt-transport-https firefox stow -y

echo 'Installing latest git and python-3' 
sudo add-apt-repository ppa:git-core/ppa -y

echo 'Installing NVM' 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

echo 'Installing VSCode'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo nala install code git python3-pip -y




# Docker 
echo 'Installing Docker'
sudo apt-get purge docker docker-engine docker.io
sudo nala install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

sudo groupadd docker
sudo usermod -aG docker $USER
 

}

function clean() {

    sudo nala autoremove;
    sudo nala clean;
}


function install_zsh() {
    sudo nala install zsh -y;
    cd "$LOCAL_HOME" || echo "unable to cd in home dir"; 
    # ohmyzsh installation 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    # ohmyzsh autosuggestion plugin 
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
    # ohmyzsh syntax higlight 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # ohmyzsh powerlevel10k 
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

    echo "Changing default shell to zsh ";
    
    echo ~;
    #rm -rf ~/.zshrc || echo "zshrc not remove might be not present "
    #rm -rf ~/.bashrc || echo "bashrc not  remove might not exist initially"

}

function git-setup () {
     echo "insisde git-setup function "; 
    install_zsh;
    cd "$LOCAL_HOME" 
    cd .dotfiles 
    stow --override bash 
    stow  --override git 
    stow --overridezsh 
    stow --override fonts


    sudo chsh -s $(which zsh) $USER;
}






function main() {

    greet;
    installation;
    git-setup;

    clean;
    

}

main;
