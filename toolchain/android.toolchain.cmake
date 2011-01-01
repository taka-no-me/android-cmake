# ----------------------------------------------------------------------------
#  Android CMake toolchain file, for use with the ndk r5 standalone toolchain
# 
#  you must either place the android standalone toolchain in 
#     /opt/android-toolchain
#  or define something like the following before running cmake for 
#  the first time.
#     export ANDROID_NDK_TOOLCHAIN_ROOT=~/android-toolchain/
#
#  run cmake with 
#       -DCMAKE_TOOLCHAIN_FILE=~/android.toolchain.cmake
#  or use cmake-gui/ccmake
#
#  What?:
#     Make sure to do the following in your scripts:
#       SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${my_cxx_flags}")
#       SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  ${my_cxx_flags}")
#       The flags will be prepopulated with critical flags, so don't loose them.
#    
#     ANDROID and BUILD_ANDROID will be set to true, you may test these 
#     variables to make necessary changes.
#    
#     Also ARMEABI and ARMEABI_V7A will be set true, mutually exclusive. V7A is
#     for floating point. NEON option will turn on neon instructions.
#
#     LIBRARY_OUTPUT_PATH_ROOT should be set in cache to determine where android
#     libraries will be installed.
#        default is ${CMAKE_SOURCE_DIR} , and the android libs will always be
#        under ${LIBRARY_OUTPUT_PATH_ROOT}/libs/armeabi* depending on target.
#        this will be convenient for android linking
#
#     Base system is Linux, but you may need to change things 
#     for android compatibility.
#   
#
#   - initial version December 2010 Ethan Rublee ethan.ruble@gmail.com
# ----------------------------------------------------------------------------

# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

#set path for android toolchain (hard coded for now)
set(ANDROID_NDK_TOOLCHAIN_ROOT $ENV{ANDROID_NDK_TOOLCHAIN_ROOT})

if(NOT EXISTS ${ANDROID_NDK_TOOLCHAIN_ROOT})
set(ANDROID_NDK_TOOLCHAIN_ROOT /opt/android-toolchain)
message("Using default path for toolchain
${ANDROID_NDK_TOOLCHAIN_ROOT}")
endif()

set(ANDROID_NDK_TOOLCHAIN_ROOT ${ANDROID_NDK_TOOLCHAIN_ROOT} CACHE PATH
    "root of the android ndk standalone toolchain" FORCE)
    
if(NOT EXISTS ${ANDROID_NDK_TOOLCHAIN_ROOT})
  message(FATAL_ERROR
  "${ANDROID_NDK_TOOLCHAIN_ROOT} does not exist!
  You should either set an environment variable:
    export ANDROID_NDK_TOOLCHAIN_ROOT=~/my-toolchain
  or put the toolchain in the default path:
    sudo ln -s ~/android-toolchain /opt/android-toolchain
    ")
endif()
# specify the cross compiler
SET(CMAKE_C_COMPILER   
  ${ANDROID_NDK_TOOLCHAIN_ROOT}/bin/arm-linux-androideabi-gcc )
SET(CMAKE_CXX_COMPILER 
  ${ANDROID_NDK_TOOLCHAIN_ROOT}/bin/arm-linux-androideabi-g++ )


#setup build targets, mutually exclusive
set(PossibleArmTargets
  "armeabi;armeabi-v7a;armeabi-v7a with NEON")
set(ARM_TARGETS "armeabi-v7a" CACHE STRING 
    "the arm targets for android, recommend armeabi-v7a 
    for floating point support and NEON.")

set_property(CACHE ARM_TARGETS PROPERTY STRINGS ${PossibleArmTargets} )

set(LIBRARY_OUTPUT_PATH_ROOT ${CMAKE_SOURCE_DIR} CACHE PATH 
    "root for library output, set this to change where
    android libs are installed to")
    
#set these flags for client use
if(ARM_TARGETS STREQUAL "armeabi")
  set(ARMEABI true)
  set(LIBRARY_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH_ROOT}/libs/armeabi
      CACHE PATH "path for android libs" FORCE)
  set(CMAKE_INSTALL_PREFIX ${ANDROID_NDK_TOOLCHAIN_ROOT}/user/armeabi
      CACHE STRING "path for installing" FORCE)
  set(NEON false)
else()
  if(ARM_TARGETS STREQUAL "armeabi-v7a with NEON")
    set(NEON true)
  endif()
  set(ARMEABI_V7A true)
  set( LIBRARY_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH_ROOT}/libs/armeabi-v7a 
       CACHE PATH "path for android libs" FORCE)
  set(  CMAKE_INSTALL_PREFIX ${ANDROID_NDK_TOOLCHAIN_ROOT}/user/armeabi-v7a
      CACHE STRING "path for installing" FORCE)
endif()

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH ${ANDROID_NDK_TOOLCHAIN_ROOT} ${CMAKE_INSTALL_PREFIX})

#for some reason this is needed? TODO figure out why...
include_directories(${ANDROID_NDK_TOOLCHAIN_ROOT}/arm-linux-androideabi/include/c++/4.4.3/arm-linux-androideabi)

# only search for programs in the ndk toolchain
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
# only search for libraries and includes in the ndk toolchain
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


#It is recommended to use the -mthumb compiler flag to force the generation
#of 16-bit Thumb-1 instructions (the default being 32-bit ARM ones).
SET(CMAKE_CXX_FLAGS "-DANDROID -mthumb")
SET(CMAKE_C_FLAGS "-DANDROID -mthumb")

if(ARMEABI_V7A)  
  #these are required flags for android armv7-a
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=armv7-a -mfloat-abi=softfp")
  SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv7-a -mfloat-abi=softfp")
  if(NEON)
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfpu=neon")
      SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=neon")
  endif()

endif()

#Also, this is *required* to use the following linker flags that routes around
#a CPU bug in some Cortex-A8 implementations:
SET(CMAKE_SHARED_LINKER_FLAGS "-Wl,--no-undefined,--fix-cortex-a8,-lsupc++ -lstdc++ -L${CMAKE_INSTALL_PREFIX}/lib")
SET(CMAKE_MODULE_LINKER_FLAGS "-Wl,--no-undefined,--fix-cortex-a8,-lsupc++ -lstdc++ -L${CMAKE_INSTALL_PREFIX}/lib")

#set these global flags for cmake client scripts to change behavior
set(ANDROID True)
set(BUILD_ANDROID True)

#include_directories(${CMAKE_INSTALL_PREFIX}/include)
#link_directories()


