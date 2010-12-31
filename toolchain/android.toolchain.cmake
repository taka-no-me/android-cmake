# ----------------------------------------------------------------------------
#  Android CMake toolchain file, for use with the ndk r5 standalone toolchain
#
#  What?:
#    Make sure to do the following in your scripts:
#    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${my_cxx_flags}")
#    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  ${my_cxx_flags}")
#     The flags will be prepopulated with critical flags, so don't loose them.
#    
#    ANDROID and BUILD_ANDROID will be set to true, you may test these variables
#    to make necessary changes.
#    
#    Also ARMEABI and ARMEABI_V7A will be set true, mutually exclusive. V7A is
#    for floating point. NEON option will turn on neon instructions.
#
#    Base system is Linux, but you may need to change things 
#    for android compatibility.
#   
#
#   - initial version December 2010 Ethan Rublee ethan.ruble@gmail.com
# ----------------------------------------------------------------------------

# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

#set cache for android toolchain
set(ANDROID_NDK_TOOLCHAIN_ROOT /android-ndkr5-toolchain/ CACHE PATH 
    "The root path of the ndk toolchain")
    
if(NOT EXISTS ${ANDROID_NDK_TOOLCHAIN_ROOT})
  message(FATAL_ERROR "You must set the tool chain root directory in you cmake cache.")
endif()


# specify the cross compiler
SET(CMAKE_C_COMPILER   ${ANDROID_NDK_TOOLCHAIN_ROOT}/bin/arm-linux-androideabi-gcc)
SET(CMAKE_CXX_COMPILER ${ANDROID_NDK_TOOLCHAIN_ROOT}/bin/arm-linux-androideabi-g++)

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH ${ANDROID_NDK_TOOLCHAIN_ROOT})

# only search for programs in the ndk toolchain
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
# only search for libraries and includes in the ndk toolchain
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#setup build targets, mutually exclusive
set(PossibleArmTargets
  "armeabi;armeabi-v7a")
set(ARM_TARGETS "armeabi-v7a" CACHE STRING 
    "the arm targets for android, recommend armeabi-v7a 
    for floating point support and NEON.")
set_property(CACHE ARM_TARGETS PROPERTY STRINGS ${PossibleArmTargets} )

#set these flags for client use
if(ARM_TARGETS STREQUAL "armeabi")
  set(ARMEABI true)
else()
  set(ARMEABI_V7A true)
endif()

#It is recommended to use the -mthumb compiler flag to force the generation
#of 16-bit Thumb-1 instructions (the default being 32-bit ARM ones).
SET(CMAKE_CXX_FLAGS "-DANDROID -mthumb")
SET(CMAKE_C_FLAGS "-DANDROID -mthumb")

if(ARMEABI_V7A)
  option(NEON true)
  #these are required flags for android armv7-a
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=armv7-a -mfloat-abi=softfp")
  SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv7-a -mfloat-abi=softfp")
  if(NEON)
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfpu=neon")
      SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=neon")
  endif()

endif()

#Also, is is *required* to use the following linker flags that routes around
#a CPU bug in some Cortex-A8 implementations:
SET(CMAKE_SHARED_LINKER_FLAGS "-Wl,--fix-cortex-a8")
SET(CMAKE_MODULE_LINKER_FLAGS "-Wl,--fix-cortex-a8")

#set these global flags for cmake client scripts to change behavior
set(ANDROID True)
set(BUILD_ANDROID True)
