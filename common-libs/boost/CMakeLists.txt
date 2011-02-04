cmake_minimum_required(VERSION 2.8)

project(android-boost)

#find patched boost directory
set(boost_root ${CMAKE_CURRENT_SOURCE_DIR}/boost_1_45_0 CACHE PATH 
    "Boost 1.45.0 patched for android")

if(NOT EXISTS ${boost_root})
message(FATAL_ERROR
  "${boost_root} does not exist!
    Please run ${CMAKE_CURRENT_SOURCE_DIR}/get_boost.sh to get a patched copy of
    boost 1.45.0
    ")
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  -DNO_BZIP2" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNO_BZIP2")

include_directories(${boost_root} )

file(GLOB lib_srcs ${boost_root}/libs/system/src/*.cpp)

add_library( boost_system ${lib_srcs})

file(GLOB lib_srcs ${boost_root}/libs/filesystem/v2/src/*.cpp)

add_library( boost_filesystem ${lib_srcs})

set(lib_dir ${boost_root}/libs/iostreams/src)
set(lib_srcs ${lib_dir}/file_descriptor.cpp   ${lib_dir}/gzip.cpp   ${lib_dir}/mapped_file.cpp   ${lib_dir}/zlib.cpp)


add_library( boost_iostreams ${lib_srcs})

file(GLOB lib_srcs ${boost_root}/libs/program_options/src/*.cpp)

add_library( boost_program_options ${lib_srcs})

file(GLOB lib_srcs ${boost_root}/libs/regex/src/*.cpp)

add_library( boost_regex ${lib_srcs})

file(GLOB lib_srcs ${boost_root}/libs/signals/src/*.cpp)

add_library( boost_signals ${lib_srcs})

file(GLOB lib_srcs ${boost_root}/libs/thread/src/pthread/*.cpp)

add_library( boost_thread ${lib_srcs})


#target_link_libraries(boost_filesystem boost_system)

set(Boost_INCLUDE_DIRS ${boost_root})
set(Boost_LIBRARIES boost_filesystem boost_system boost_program_options boost_iostreams )
set(Boost_LINK_DIRS ${LIBRARY_OUTPUT_PATH})

configure_file(${CMAKE_SOURCE_DIR}/BoostConfig.cmake.in
               ${CMAKE_BINARY_DIR}/BoostConfig.cmake @ONLY)
               
install(DIRECTORY ${boost_root}/boost DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
install(TARGETS boost_system DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_filesystem DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_program_options DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_iostreams DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_regex DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_signals DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_thread DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

