#!/bin/bash
if [ ! -e eigen-android ]; then
hg hg clone https://bitbucket.org/eigen/eigen eigen-android
else
cd eigen-android && hg pull && hg update
fi
