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

include_directories(${boost_root} )

file(GLOB lib_srcs ${boost_root}/libs/system/src/*.cpp)

add_library( boost_system ${lib_srcs})

file(GLOB lib_srcs ${boost_root}/libs/filesystem/v2/src/*.cpp)

add_library( boost_filesystem ${lib_srcs})

#target_link_libraries(boost_filesystem boost_system)

set(Boost_INCLUDE_DIRS ${boost_root})
set(Boost_LIBRARIES boost-filesystem boost-system )
set(Boost_LINK_DIRS ${LIBRARY_OUTPUT_PATH})

configure_file(${CMAKE_SOURCE_DIR}/BoostConfig.cmake.in
               ${CMAKE_BINARY_DIR}/BoostConfig.cmake @ONLY)
               
install(DIRECTORY ${boost_root}/boost DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
install(TARGETS boost_system DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install(TARGETS boost_filesystem DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)


