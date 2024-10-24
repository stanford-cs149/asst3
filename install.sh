#!/bin/bash
# A helper script to install CUDA for Ubuntu 24.04

set -e

# install cuda
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin
sudo mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.6.2/local_installers/cuda-repo-ubuntu2404-12-6-local_12.6.2-560.35.03-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2404-12-6-local_12.6.2-560.35.03-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2404-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-6

# install nvidia driver
sudo apt-get install -y nvidia-open

# install libraries
sudo apt-get install -y freeglut3-dev

# Update PATH to include bin directory containing nvcc
if ! grep -q "/usr/local/cuda/bin" $HOME/.bashrc ; then
    echo "export PATH=\$PATH:/usr/local/cuda/bin" >> $HOME/.bashrc
fi
