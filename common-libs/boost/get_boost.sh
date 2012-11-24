#!/bin/bash
if [ ! -e boost-trunk ]; then
svn checkout http://svn.boost.org/svn/boost/trunk boost-trunk
else
svn update boost-trunk
fi
