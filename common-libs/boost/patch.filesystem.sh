#!/bin/sh
if [ $# -ne 1 ]
then
    echo "Error in $0 - Invalid Argument Count"
    echo "Syntax: $0 boost_1_45_0"
    exit
fi
patch $1/libs/filesystem/v2/src/v2_operations.cpp < android.patch
