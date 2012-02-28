#!/bin/bash
set -e

INSTALLDIR=/usr/local
###	Build and install Binutils portion of tools	###
if [ ! -d FreeScale-s12x-binutils ]
  then
    git clone git://github.com/seank/FreeScale-s12x-binutils.git
fi
cd FreeScale-s12x-binutils
git pull
if [ ! -d xgate-build ]
  then
    mkdir xgate-build
fi
cd xgate-build
#make distclean
#make clean
../src/configure --target=xgate \
			--enable-targets=xgate \
			--program-prefix=xgate- \
			--prefix=$INSTALLDIR \
			--disable-werror
make
sudo make install
cd ..
if [ ! -d 9hcs12x-build ]
  then
    mkdir 9hcs12x-build
fi
cd 9hcs12x-build
#make distclean
#make clean
../src/configure --target=m68hc11 \
			--enable-targets=m68hc11,m68hc12,xgate \
			--program-prefix=m68hc11- \
			--prefix=$INSTALLDIR \
			--disable-werror
make
sudo make install 
cd ..
cd ..

# Keep old gcc port happy by adding binutils links 
  # Change hardlinks to symlinks
sudo bash -c 'for i in ar as ld nm objcopy objdump ranlib strip
do 
        rm  -f /usr/local/xgate/bin/$i 
        ln -s /usr/local/bin/xgate-$i /usr/local/xgate/bin/$i ; 
        rm -f /usr/local/m68hc11/bin/$i 
        ln -s /usr/local/bin/m68hc11-$i /usr/local/m68hc11/bin/$i ; 
done'


####	build and install gcc	###
if [ ! -d FreeScale-s12x-gcc ]
  then
    git clone git://github.com/seank/FreeScale-s12x-gcc.git
fi

cd FreeScale-s12x-gcc
git pull
if [ ! -d build ]
  then
    mkdir build
fi
cd build
#make distclean
#make clean
../src/configure  \
	     --program-prefix=m68hc11- \
	     --enable-languages=c \
	     --target=m68hc11 \
	     --with-gnu-as \
	     --with-gnu-ld \
	     --enable-nls \
	     --without-included-gettext \
	     --disable-checking \
	     --without-headers  \
	     --prefix=$INSTALLDIR
		     #--disable-werror
make 
sudo make install-gcc
cd ..
cd ..

####	build and install newlib	###
if [ ! -d FreeScale-s12x-newlib ]
  then
    git clone git://github.com/seank/FreeScale-s12x-newlib.git
fi
cd FreeScale-s12x-newlib
git pull
if [ ! -d build ]
  then
    mkdir build
fi
cd build
../src/configure \
	    --host\
	    --target=m68hc11 \
	    --program-prefix=m68hc11- \
	    --disable-shared \
	    --disable-multilib \
	    --disable-threads \
	    --disable-nls \
	    CC=m68hc11-gcc \
	    CFLAGS='-g -O2 -U_FORTIFY_SOURCE'
make
make install
