#!/bin/bash
set -eux

OPENEXR_SOURCE=$(pwd)
OPENEXR_BUILD=$OPENEXR_SOURCE/build
OPENEXR_PREFIX=$OPENEXR_SOURCE/install

###############################################################################
# IlmBase
mkdir -p $OPENEXR_BUILD/IlmBase
pushd $OPENEXR_BUILD/IlmBase
cmake $OPENEXR_SOURCE/IlmBase \
    -DNAMESPACE_VERSIONING=OFF \
    -DCMAKE_INSTALL_PREFIX=$OPENEXR_PREFIX
make -j2 VERBOSE=1
make test ARGS=--verbose
make install
popd

###############################################################################
# PyIlmBase
mkdir -p $OPENEXR_BUILD/PyIlmBase
pushd $OPENEXR_BUILD/PyIlmBase
cmake $OPENEXR_SOURCE/PyIlmBase \
    -DILMBASE_PACKAGE_PREFIX=$OPENEXR_PREFIX \
    -DNAMESPACE_VERSIONING=OFF \
    -DCMAKE_INSTALL_PREFIX=$OPENEXR_PREFIX
make -j2 VERBOSE=1
make install
# TODO Why does CMake not find boost_python?
#PYTHONPATH=$OPENEXR_PREFIX/lib/python2.7/site-packages \
#    LD_LIBRARY_PATH=$OPENEXR_PREFIX/lib \
#    make test ARGS=--verbose
popd

###############################################################################
# OpenEXR
mkdir -p $OPENEXR_BUILD/OpenEXR
pushd $OPENEXR_BUILD/OpenEXR
cmake $OPENEXR_SOURCE/OpenEXR \
    -DILMBASE_PACKAGE_PREFIX=$OPENEXR_PREFIX \
    -DNAMESPACE_VERSIONING=OFF \
    -DCMAKE_INSTALL_PREFIX=$OPENEXR_PREFIX
make -j2 VERBOSE=1
make test ARGS=--verbose
make install
popd
