cmake_minimum_required(VERSION 2.8)

project(hello-eigen)

#find eigen
include(cmake/find_eigen3.cmake)
include_directories(${eigen3_INCLUDE_DIRS})

#notice the "recycling" of CMAKE_C_FLAGS
#this is necessary to pick up android flags
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -pedantic" )

#test for ANDROID and look for stuff not relevant to android.
if(NOT ANDROID)
#jni is available by default on android
find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS})
endif()

#this will be overridden by the android toolchain
set( LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib/pc CACHE PATH
        "Single Directory for all Libraries")

#make sure to used shared in in the jni library, as this will be loaded by
#java
add_library(hello-eigen SHARED hello-eigen.cpp)
#target_link_libraries(hello-eigen)
