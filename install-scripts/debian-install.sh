#!/bin/bash

# Tested on kali linux 2021.2 live iso
main(){
    echo "Welcome to the Rustcat Debian installer"
    which curl >/dev/null && echo "Curl installed, moving on..." || sudo apt install curl

    echo "Getting latest version..."
    version=$(curl --silent "https://api.github.com/repos/robiot/rustcat/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-)
    name="rustcat_${version}_amd64.deb"

    echo "Found $name"

    cd /tmp
    sudo rm -rf /tmp/${name} && curl -OL https://github.com/robiot/rustcat/releases/latest/download/${name} && sudo apt install ./${name}

    if [ $? -eq 0 ]; then
        echo "Rustcat $version sucessfully installed! | Run with 'rc"
    else
        echo "Failed to install"
    fi
    cd ~/
}
main
