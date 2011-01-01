cmake_minimum_required(VERSION 2.8)

project(hello-cmake)

#notice the "recycling" of CMAKE_C_FLAGS
#this is necessary to pick up android flags
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -pedantic" )

find_package(Boost REQUIRED filesystem system)

#test for ANDROID and look for stuff not relevant to android.
if(NOT ANDROID)
find_package(Boost REQUIRED filesystem system)
#jni is available by default on android
find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS})
endif()

#boost on android
#the find_packages are still to be desired TODO fix find_package for boost ;)
#if(ANDROID)
#set(BoostBuildDir ${CMAKE_SOURCE_DIR}/../../common-libs/boost/build
#  CACHE PATH "Path to the boost build dir for android, should have BoostConfig.cmake file in it.")
#include(${BoostBuildDir}/BoostConfig.cmake REQUIRED)
#endif()

include_directories(${Boost_INCLUDE_DIRS})
link_directories(${CMAKE_INSTALL_PREFIX}/lib/)

#this will be overridden by the android toolchain
set( LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib/pc CACHE PATH
        "Single Directory for all Libraries")

#make sure to used shared in in the jni library, as this will be loaded by
#java
add_library(hello-boost SHARED hello-boost.cpp)
target_link_libraries(hello-boost ${Boost_LIBRARIES})
