 #!/bin/bash

 DOT_FILES=( .zshrc .zshrc.alias .zshrc.osx .gitconfig .gitignore .vimrc .tmux.conf .flake8)

 for file in ${DOT_FILES[@]}
 do
     ln -s $HOME/dotfiles/$file $HOME/$file
 done

# make locla setting file
 touch ~/.zshrc.local

 # setup posetry
 curl -sSL https://install.python-poetry.org | python3 -
# set alias like poetry='/Users/munetakamizutani/Library/Python/3.9/bin/poetry'

 # install oh-my-zsh
 # [! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

brew install \
    arp-scan\
    boostnote\
    coreutils\
    dropbox\
    eza\
    gh\
    gibo\
    git\
    gnu-sed\
    google-chrome\
    htop\
    httpie\
    iproute2mac\
    iterm2\
    jq\
    jesseduffield/lazygit/lazygit\
    lv\
    obsidian\
    neovim\
    nmap\
    pipx\
    pyenv\
    sequel-ace\
    shellcheck\
    skitch\
    tig\
    tmux\
    tree\
    vim\
    wget\
