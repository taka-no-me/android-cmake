# mkdir pcbuild
# cd pcbuild
# cmake ..
# make
#
cmake_minimum_required(VERSION 2.8)

project(hello-cmake)

set( EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin CACHE PATH
  "Single Directory for all Executables")
  
set( LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib CACHE PATH
        "Single Directory for all Libraries")

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -pedantic" )
if(NOT ANDROID)
find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS})
endif()

add_library(hello-cmake SHARED hello-cmake.c)

