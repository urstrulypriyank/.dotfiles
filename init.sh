 #!/bin/bash
 LOCAL_HOME=$HOME

    sudo nala install zsh -y;
    cd "$LOCAL_HOME" || echo "unable to cd in home dir"; 
    # ohmyzsh installation 
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    # ohmyzsh autosuggestion plugin 
    git clone https://github.com/zsh-users/zsh-autosuggestions;
    # ohmyzsh syntax higlight 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
    # ohmyzsh powerlevel10k 
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git;

    echo "Changing default shell to zsh ";
    
    echo ~;
    rm -rf ~/.zshrc || echo "zshrc not remove might be not present "
    rm -rf ~/.bashrc || echo "bashrc not  remove might not exist initially"



echo "insisde git-setup function "; 
cd "$LOCAL_HOME" 
cd .dotfiles 
stow bash 
stow git 
stow zsh 
stow fonts
sudo chsh -s $(which zsh) $USER;
