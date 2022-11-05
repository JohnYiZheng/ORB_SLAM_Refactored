#!/bin/bash
set -e
INITIAL_DIR=$(pwd)

OPEN_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
WS_DIR="$( cd "$( dirname "$OPEN_SOURCE_DIR" )" && pwd)"

echo "workspace dir: $WS_DIR"
echo "open source dir: $OPEN_SOURCE_DIR"

echo "download then install g2o..."
cd $OPEN_SOURCE_DIR
echo "create temp dir 'src' to save downloads"
mkdir -p src
git clone --branch 20201223_git https://github.com/RainerKuemmerle/g2o.git src/g2o
# sudo apt-get install libsuitesparse-dev
cd src/g2o
mkdir build && cd build
cmake .. \
-DCMAKE_INSTALL_PREFIX=$OPEN_SOURCE_DIR
make -j$(nproc)
make install

cd $OPEN_SOURCE_DIR
rm -rf src

echo "install DBoW2..."
cd $WS_DIR/src/orb_slam/Thirdparty/DBoW2
mkdir -p build
cd build
cmake ..
make -j$(nproc)

cd $INITIAL_DIRs