destination=$HOME
ball=android-ndk-r5b-linux-x86.tar.bz2
hash=4c0045ddc2bfd657be9d5177d0e0b7e7
mkdir -p tmp
cd tmp
if [ -e $BALL ]; then
  CSUM1=`md5sum $ball | grep --only-matching -m 1 '^[0-9a-f]*'`
  if [ "$CSUM1" = "$hash" ]; then
    echo "already downloaded"
  else
    wget http://dl.google.com/android/ndk/$ball
  fi
else
  wget http://dl.google.com/android/ndk/$ball
fi
echo Untarring
tar -C $destination -xf $ball
cd $destination/android-ndk-r5b
NDK=`pwd`
$NDK/build/tools/make-standalone-toolchain.sh --platform=android-5 --install-dir=$destination/android-toolchain
echo "making soft links to the standalone toolchain with:
 ln -fs $destination/android-toolchain /opt/android-toolchain"
sudo ln -fs $destination/android-toolchain /opt/android-toolchain
echo "##########################################################
add something like the following to your environment:
  export ANDTOOLCHAIN=~/android-cmake/toolchain/android.toolchain.cmake
then run cmake like:
  cmake -DCMAKE_TOOLCHAIN_FILE=\$ANDTOOLCHAIN .."
