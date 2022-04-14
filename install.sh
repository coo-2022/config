#!/bin/bash

IS_BEHIND_PROXY=1
PROXY=""

source ./util.sh

PROXY=

function setup_gcc()
{
    apt install gcc -y
    if [ $? -ne 0 ]; then
        _print_error "Install gcc failed"
        return 1
    fi

    apt install g++ -y
    if [ $? -ne 0 ]; then
        _print_error "Install g++ failed"
        return 1
    fi
    return 0
}

function setup_cmake()
{
    apt install cmake
    if [ $? -ne 0 ]; then
        _print_error "Install cmake failed"
        return 1
    fi
    return 0
}

function setup_vim()
{
    mkdir -p ~/.config/nvim/
    if [ $? -ne 0 ]; then
        _print_error "mkdir nvim dir failed."
        return 1
    fi

    cp -f nvim/init.vim ~/.config/nvim/ || return 1
    if [ $? -ne 0 ]; then
        _print_error "Create nvim init.vim failed."
        return 1
    fi

    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
               https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if [ $? -ne 0 ]; then
        _print_error "Download vim-plug failed."
        return 1
    fi

    return 0
}

function setup_software()
{
    _print_event "Begin setup software."
    apt-get update
    if [ $? -ne 0 ]; then
        _print_error "Failed to update apt"
        return 1
    fi

    setup_gcc || return 1
    setup_cmake || return 1
    setup_vim || return 1
    setup_rg_ag
    setup_clangd
    setup_rust
}

function check_result()
{
    _print_event "Check env setup ok"
}

function download_nvim()
{
    return 0
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    if [ $? -ne 0 ]; then
        _print_error "Download nvim failed."
        return 1
    fi

    _print_event "Install binary."
    mkdir -p /opt/nvim/
    chmod +x nvim.appimage
    cp nvim.appimage /opt/nvim/
    ln -s /opt/nvim/nvim.appimage /usr/bin/nvim

    return 0
}

function install_nvim()
{
    _print_event "Set up nvim."
    which nvim
    if [ $? -eq 0 ]; then
        _print_event "Nvim is already installed."
        return 0
    fi

    _print_event "Download nvim..."
    download_nvim

    _print_event "Install init.vim"
    mkdir -p ~/.config/nvim/ 
    cp nvim/init.vim  ~/.config/nvim/

    return 0
}

function setup_proxy()
{
    apt-get update
    apt install curl -y

    echo "--insecure" >> ~/.curlrc
    echo "proxy = ${PROXY}" >> ~/.curlrc
    return 0
}

function install_git()
{
    which git
    if [ $? -eq 0 ]; then
        _print_event "Git is already installed."
        return 0
    fi

    echo "[http \"https://github.com\"]" >> ~/.gitconfig
    echo "proxy = \"${PROXY}\"" >> ~/.gitconfig
    echo "sslVerify = false" >> ~/.gitconfig

    apt install git -y
}

function install_nvim_plug()
{
    _print_event "Download vim-plug"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    export http_proxy="${PROXY}"
    export https_proxy="${PROXY}"
    nvim -c "PlugInstall" -c "q" -c "q"

    return 0
}

function install_coc_depedency()
{
    which node
    if [ $? -eq 0 ]; then
        _print_event "Node is already installed."
        return 0
    fi

    VERSION=v16.14.2
    DISTRO=linux-x64

    curl -LO https://nodejs.org/dist/${VERSION}/node-${VERSION}-${DISTRO}.tar.xz
    mkdir -p /opt/nodejs/
    tar -xJvf node-${VERSION}-${DISTRO}.tar.xz -C /opt/nodejs/
    # 支持重入
    echo "export PATH=\"/opt/nodejs/node-$VERSION-$DISTRO/bin:\$PATH\"" >> ~/.profile
    . ~/.profile

    return 0
}

function install_clangd()
{
}

function main()
{
    _print_event "Setup proxy"
    setup_proxy

    _print_event "Install git"
    install_git

    _print_event "Install nvim"
    install_nvim

    _print_event "Install coc depedency"
    install_coc_depedency

    _print_event "Install nvim plug"
    install_nvim_plug

    exit 0
}

main
