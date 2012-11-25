cmake_minimum_required(VERSION 2.8)
project(glues)

include_directories( ${glues_SOURCE_DIR}/include ${glues_SOURCE_DIR}/include/glues)
file(GLOB lib_srcs ${glues_SOURCE_DIR}/src/*.c)

add_library(glues ${lib_srcs})

install(DIRECTORY ${glues_SOURCE_DIR}/include/glues DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
install(TARGETS glues DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

