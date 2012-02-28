#!/bin/bash
set -e
cd ~
cd freeems
cd MegaTunix 
git pull 
./autogen.sh
make
sudo make install
sudo ldconfig
