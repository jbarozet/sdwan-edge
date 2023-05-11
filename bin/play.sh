#!/usr/bin/env bash

PROJ_ROOT="/Users/jbarozet/Documents/Code/sdwan-edge"
IMAGE="sdwan-container"
OPTIONS=

while getopts ":r" opt; do
    case $opt in
    r)
        docker run -it -v $PROJ_ROOT/ansible:/ansible -v $HOME/.aws:/root/.aws $IMAGE /bin/bash
        exit
        ;;
    esac
done

docker run -it --rm \
    -v $PROJ_ROOT/ansible:/ansible \
    -v $PROJ_ROOT/provision_edge:/provision_edge \
    -v $PROJ_ROOT/provision_vpc:/provision_vpc \
    -v $HOME/.aws:/root/.aws \
    --env PWD="/ansible" \
    --env USER="$USER" \
    $OPTIONS \
    $IMAGE ansible-playbook "$@"
