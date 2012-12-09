#!/bin/bash
if [ ! -e eigen-master ]; then
hg clone https://bitbucket.org/eigen/eigen eigen-master
else
cd eigen-master && hg pull && hg update
fi
