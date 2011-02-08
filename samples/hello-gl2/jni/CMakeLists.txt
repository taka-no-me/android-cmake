#notice the "recycling" of CMAKE_C_FLAGS
#this is necessary to pick up android flags
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -pedantic -fPIC" )

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

set( LIBRARY_DEPS GLESv2 log)

set(MY_SRCS
    gl_code.cpp #cpp files can be compiled to
    )

add_library(gl2jni SHARED ${MY_SRCS} )

#link the module like any other
target_link_libraries(gl2jni ${LIBRARY_DEPS} )
