#!/bin/bash

IS_BEHIND_PROXY=1
PROXY=""

source ./util.sh

FILE_BASHRC=""
FILE_NHXENV=""
FILE_NHXALIAS=""
FILE_CURLRC=""

function setup_env()
{
    _print_event "Begin setup env."
    if [ ! -z ${FILE_NHXENV} ]; then
        echo "${FILE_NHXENV}" >> ~/.nhxenv
    fi

    if [ ! -z ${FILE_NHXALIAS} ]; then
        echo "${FILE_NHXALIAS}" >> ~/.nhxalias
    fi

    if [ ! -z ${FILE_BASHRC} ]; then
        echo "${FILE_BASHRC}" >> ~/.bashrc
    fi

    if [ ! -z ${FILE_CURLRC} ]; then
        echo "${FILE_CURLRC}" >> ~/.curlrc
    fi

    souce ~/.bashrc

    return 0
}

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

function main()
{
    setup_env
    if [ $? -ne 0 ]; then
        _print_error "setup env failed."
        exit 1
    fi
    setup_software
    if [ $? -ne 0 ]; then
        _print_error "setup software failed."
        exit 1
    fi

    exit 0
}

main
