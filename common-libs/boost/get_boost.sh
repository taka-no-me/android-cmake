#!/bin/sh
current_dir=`pwd`
mkdir -p download
cd download
if [ ! -e boost_1_45_0.tar.gz ]
then
    echo "wget'ing boost'"
    #this url is for convenience, consider it a mirror and you may replace it
    #with any existing boost_1_45_0.tar.gz url 
    boost_download=http://vault.willowgarage.com/wgdata1/vol1/android_boost/boost_1_45_0.tar.gz
    echo wget $boost_download
    wget $boost_download
fi

echo tar -xf boost_1_45_0.tar.gz
tar -xf boost_1_45_0.tar.gz
mv boost_1_45_0 $current_dir

cd $current_dir
echo ./patch_boost.sh boost_1_45_0
./patch_boost.sh boost_1_45_0
