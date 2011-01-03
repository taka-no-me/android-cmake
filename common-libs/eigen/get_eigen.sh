#!/bin/bash
if [ ! -e eigen-android ]; then
hg clone https://erublee@bitbucket.org/erublee/eigen-android eigen-android
else
cd eigen-android && hg pull && hg update
fi
