#!/bin/bash
if [ ! -e eigen-android ]; then
hg clone https://bitbucket.org/eigen/eigen eigen-master
else
cd eigen-master && hg pull && hg update
fi
