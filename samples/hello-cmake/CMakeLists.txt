cmake_minimum_required(VERSION 2.8)

project(hello-cmake)

#notice the "recycling" of CMAKE_C_FLAGS
#this is necessary to pick up android flags
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -pedantic" )

if(NOT ANDROID)
#jni should work on a pc
find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS})
set( LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib/pc CACHE PATH
        "Single Directory for all Libraries")
endif()

#make sure to used shared in in the jni library, as this will be loaded by
#java
add_library(hello-cmake SHARED hello-cmake.c)

