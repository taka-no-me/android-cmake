#!/bin/sh
cd `dirname $0`
mkdir -p _build
LIBS_ROOT=`pwd`

cd $LIBS_ROOT
mkdir -p _build/glues
cd _build/glues
cmake -DCMAKE_TOOLCHAIN_FILE=../../../android.toolchain.cmake -DCMAKE_INSTALL_PREFIX="$LIBS_ROOT"/_install -DCMAKE_BUILD_TYPE=Release $@ ../../glues
cmake --build . --target install\\\\strip

cd $LIBS_ROOT
mkdir -p _build/eigen
cd _build/eigen
cmake -DCMAKE_TOOLCHAIN_FILE=../../../android.toolchain.cmake -DCMAKE_INSTALL_PREFIX="$LIBS_ROOT"/_install -DCMAKE_BUILD_TYPE=Release -DNDK_CCACHE="" -Drun_res=0 -Drun_res__TRYRUN_OUTPUT="" $@ ../../eigen/eigen-master
cmake --build . --target install

cd $LIBS_ROOT
mkdir -p _build/boost
cd _build/boost
cmake -DCMAKE_TOOLCHAIN_FILE=../../../android.toolchain.cmake -DCMAKE_INSTALL_PREFIX="$LIBS_ROOT"/_install -DCMAKE_BUILD_TYPE=Release $@ ../../boost
cmake --build . --target install\\\\strip

