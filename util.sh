#!/bin/bash

function _print_debug()
{
    return 0
}

function _print_event()
{
    if [ -z "${1}" ]
    then
        echo -n -e "\033[32m[EVENT]\033[0m "; echo "param error[$1]"
        return 1
    fi
    echo -n -e "\033[32m[EVENT]\033[0m "; echo "${1}"
}

function _print_warning()
{
    if [ -z "${1}" ]
    then
        echo -n -e "\033[33m[WARN]\033[0m "; echo "param error[$1]"
        return 1
    fi
    echo -n -e "\033[33m[WARN]\033[0m "; echo "${1}"
}

function _print_error()
{
    if [ -z "${1}" ]
    then
        echo -n -e "\033[31m[ERROR]\033[0m "; echo "param error[$1]"
        return 1
    fi
    echo -n -e "\033[31m[ERROR]\033[0m "; echo "${1}"
}

