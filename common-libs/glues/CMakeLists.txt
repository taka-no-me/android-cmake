cmake_minimum_required(VERSION 2.8)

project(glues)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DANDROID_NDK -DDISABLE_IMPORTGL" )

include_directories( ${CMAKE_SOURCE_DIR}/include ${CMAKE_SOURCE_DIR}/include/glues)

file(GLOB lib_srcs ${CMAKE_SOURCE_DIR}/src/*.c)

add_library( glues ${lib_srcs})

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/glues DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
install(TARGETS glues DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

