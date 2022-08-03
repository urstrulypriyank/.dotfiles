#!/bin/bash

function install_zsh() {
    sudo nala install zsh -y;
    cd "$LOCAL_HOME" || echo "unable to cd in home dir"; 
    # ohmyzsh installation 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    # ohmyzsh autosuggestion plugin 
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
    # ohmyzsh syntax higlight 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    

    echo "Changing default shell to zsh ";
    chsh -s $(which zsh);
    
    echo ~;
    rm -rf ~/.zshrc || echo "zshrc not remove might be not present "
    rm -rf ~/.bashrc || echo "bashrc not  remove might not exist initially"

}

install_zsh;