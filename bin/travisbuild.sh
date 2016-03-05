#!/bin/bash
mkdir -p $HOME/distfiles
test -e $HOME/distfiles/hdf5-1.8.13-linux-x86_64-shared.tar.gz \
|| curl -s -L https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.13/bin/linux-x86_64/hdf5-1.8.13-linux-x86_64-shared.tar.gz \
        -o $HOME/distfiles/hdf5-1.8.13-linux-x86_64-shared.tar.gz
tar zxf $HOME/distfiles/hdf5-1.8.13-linux-x86_64-shared.tar.gz -C $HOME
mkdir -p $HOME/boost_1_56_0/include
test -e $HOME/distfiles/boost_1_56_0.tar.gz \
|| curl -s -L https://prdownloads.sourceforge.net/boost/boost_1_56_0.tar.gz \
        -o $HOME/distfiles/boost_1_56_0.tar.gz
tar zxf $HOME/distfiles/boost_1_56_0.tar.gz --strip=1 -C $HOME/boost_1_56_0/include/ boost_1_56_0/boost
cp mk/travis.mk settings.mk
make -j reseq-core
