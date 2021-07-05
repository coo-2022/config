#!/bin/bash

. ./util.sh

function setup_vim()
{
    if [ !-d ~/.vim/nhx ]; then
        mkdir -p ~/.vim/nhx
    fi
    if [ $? -ne 0 ]; then
        __print_error "mkdir nhx failed"
        exit 1
    fi
    cp vim/keymap.vim ~/.vim/nhx/
}

function setup_env()
{
}

function setup_git()
{
}

function main()
{
}

