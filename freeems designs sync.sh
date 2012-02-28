#!/bin/bash
set -e
cd ~
cd freeems

###	Setup Ravage repo	###
if [ ! -d Ravage ]
  then
    git clone git://github.com/dvisser/Ravage.git
fi
cd Ravage
git pull
cd ..

###	Setup Jaguar repo	###
if [ ! -d Jaguar ]
  then
    git clone git://github.com/DeuceEFI/Jaguar.git
fi
cd Jaguar
git pull
cd ..
