#!/bin/bash
set -eux

OPENEXR_SOURCE=$(pwd)
OPENEXR_BUILD=$OPENEXR_SOURCE/build
OPENEXR_PREFIX=$OPENEXR_SOURCE/install

###############################################################################
# IlmBase
mkdir -p $OPENEXR_BUILD/IlmBase
pushd $OPENEXR_BUILD/IlmBase
cmake ../../IlmBase \
    -DNAMESPACE_VERSIONING=OFF \
    -DCMAKE_INSTALL_PREFIX=$OPENEXR_PREFIX
make -j2 VERBOSE=1
make test
make install
popd
exit 0

###############################################################################
# OpenEXR
#   Packages: zlib1g-devel
mkdir -p $OPENEXR_BUILD/OpenEXR
pushd $OPENEXR_BUILD/OpenEXR
cmake ../../OpenEXR \
    -DILMBASE_PACKAGE_PREFIX=$OPENEXR_PREFIX \
    -DNAMESPACE_VERSIONING=OFF \
    -DCMAKE_INSTALL_PREFIX=$OPENEXR_PREFIX
make -j2 VERBOSE=1
make install
popd


###############################################################################
# PyIlmBase
#   Packages: zlib1g-devel libboost-dev libboost-python-dev
mkdir -p $OPENEXR_BUILD/PyIlmBase
pushd $OPENEXR_BUILD/PyIlmBase
cmake ../../PyIlmBase \
    -DBoost_LIBRARIES=boost_python \
    -DILMBASE_PACKAGE_PREFIX=$OPENEXR_PREFIX \
    -DNAMESPACE_VERSIONING=OFF \
    -DCMAKE_INSTALL_PREFIX=$OPENEXR_PREFIX
make -j2 VERBOSE=1
make install
popd
