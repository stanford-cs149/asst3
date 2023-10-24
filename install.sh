#!/bin/bash

# A helper script to install CUDA for Ubuntu 22.04

set -e

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget -nc https://developer.download.nvidia.com/compute/cuda/12.3.0/local_installers/cuda-repo-ubuntu2204-12-3-local_12.3.0-545.23.06-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-3-local_12.3.0-545.23.06-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/

sudo apt-get update
sudo apt-get install -y g++ make cuda freeglut3-dev

# Update PATH to include bin directory containing nvcc
if ! grep -q "/usr/local/cuda/bin" $HOME/.bashrc ; then
    echo "export PATH=\$PATH:/usr/local/cuda/bin" >> $HOME/.bashrc
fi