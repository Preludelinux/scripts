#!/bin/bash
set -e
###	Setup the freeEMS directory structure  ###
cd ~
mkdir freems
cd freeems

###	Setup the freeems firmware repo	###
if [ ! -d freeems-vanilla ]
  then
    git clone git://github.com/fredcooke/freeems-vanilla.git
fi
cd freeeme-vanilla
git pull
cd ..

###	Setup the MegaTunix repo	###
if [ ! -d MegaTunix ]
  then
    git clone git://github.com/djandruczyk/MegaTunix.git
fi
cd MegaTunix
git pull
cd ..

###	Setup the Open Log Viewer repo	###
if [ ! -d OpenLogViewer ]
  then
    git clone git://github.com/djandruczyk/MegaTunix.git
fi
cd OpenLogViewer
git pull
cd ..

###	Setup the Open Log Viewer repo	###
if [ ! -d OpenLogViewer ]
  then
    git clone git://github.com/djandruczyk/MegaTunix.git
fi
cd OpenLogViewer
git pull
cd ..

