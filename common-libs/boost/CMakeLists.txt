cmake_minimum_required(VERSION 2.6.3)
project(android-boost)

#find patched boost directory
set(boost_root ${CMAKE_CURRENT_SOURCE_DIR}/boost-trunk CACHE PATH "Boost repo")

if(NOT EXISTS ${boost_root})
message(FATAL_ERROR
  "${boost_root} does not exist!
    Please run ${CMAKE_CURRENT_SOURCE_DIR}/get_boost.sh to get a copy of boost source")
endif()

set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} -DNO_BZIP2" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNO_BZIP2")

set(Boost_INCLUDE_DIRS ${boost_root})
set(Boost_LIBRARIES)
set(Boost_LINK_DIRS ${LIBRARY_OUTPUT_PATH})

macro(add_boost_lib name)
    file(GLOB_RECURSE lib_srcs "${boost_root}/libs/${name}/src/*.cpp")
    foreach(arg ${ARGN})
        if("${arg}" MATCHES "^-")
            string(REGEX REPLACE "^-" "${boost_root}/libs/${name}/src/" arg "${arg}")
            list(REMOVE_ITEM lib_srcs ${arg})
        endif()
    endforeach()
    add_library( boost_${name} ${lib_srcs} )
    list(APPEND Boost_LIBRARIES boost_${name})
    install(TARGETS boost_${name} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
endmacro()

macro(add_boost_lib_subdir name src_subdir)
    file(GLOB_RECURSE lib_srcs ${boost_root}/libs/${name}/src/${src_subdir}/*.cpp)
    add_library( boost_${name} ${lib_srcs} )
    list(APPEND Boost_LIBRARIES boost_${name})
    install(TARGETS boost_${name} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
endmacro()

include_directories(${boost_root} ${CMAKE_CURRENT_SOURCE_DIR})
install(DIRECTORY ${boost_root}/boost DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

add_boost_lib(system)
add_boost_lib(filesystem)
add_boost_lib(iostreams -bzip2.cpp)
add_boost_lib(program_options)
add_boost_lib(regex)
add_boost_lib(signals)
add_boost_lib_subdir(thread pthread)
add_boost_lib(date_time)

configure_file(${CMAKE_SOURCE_DIR}/BoostConfig.cmake.in
               ${CMAKE_BINARY_DIR}/BoostConfig.cmake @ONLY)
