message(STATUS "Configuring toolchain for ESP8266 (Xtensa L106)...")
include(FetchContent)

if (DEFINED CACHE{TOOLCHAIN_ROOT_DIR})
    message(STATUS "GCC toolchain is already present, nothing to do")
    return()
endif()

if (DEFINED $ENV{XTENSA_TOOLCHAIN_ROOT})
    file(TO_CMAKE_PATH "$ENV{XTENSA_TOOLCHAIN_ROOT}" TOOLCHAIN_ROOT_DIR_CANONICAL)
    if (NOT EXISTS ${TOOLCHAIN_ROOT_DIR_CANONICAL})
        message(FATAL_ERROR "Environment variable `XTENSA_TOOLCHAIN_ROOT` does not point to a valid GCC toolchain.")
    endif()

    set(TOOLCHAIN_ROOT_DIR ${TOOLCHAIN_ROOT_DIR_CANONICAL} CACHE INTERNAL "ESP GCC cross compiler toolchain root folder")
    message(STATUS "Found GCC toolchain root at ${TOOLCHAIN_ROOT_DIR}")
else()
    message(STATUS "Fetching Xtensa L106 GCC toolchain from Espressif...")
    FetchContent_Declare(
            xtensa_lx106_gcc
            URL      https://dl.espressif.com/dl/xtensa-lx106-elf-gcc8_4_0-esp-2020r3-win32.zip
            URL_HASH SHA256=733b4da8723471b430f8692b943a7917ad5920b98e7bc6bdf9fb7617182c2b33
    )
    FetchContent_MakeAvailable(xtensa_lx106_gcc)

    if (NOT EXISTS ${xtensa_lx106_gcc_SOURCE_DIR})
        message(FATAL_ERROR "Failed to download Xtensa LX106 GCC toolchain. Either make sure the download URL is valid or download it yourself and point CMake to it with the `XTENSA_TOOLCHAIN_ROOT` environment variable.")
    endif()

    set(TOOLCHAIN_ROOT_DIR ${xtensa_lx106_gcc_SOURCE_DIR} CACHE INTERNAL "ESP GCC cross compiler toolchain root folder")
endif()

set(TOOLCHAIN_EXE_SUFFIX "" CACHE INTERNAL "whether to use .exe for Windows")
if (CMAKE_HOST_WIN32)
    set(TOOLCHAIN_EXE_SUFFIX ".exe" CACHE INTERNAL "whether to use .exe for Windows")
endif()

#if((NOT EXISTS $ENV{XTENSA_TOOLCHAIN_ROOT}) AND (NOT DEFINED CACHE{TOOLCHAIN_ROOT_DIR}))
#    message(FATAL_ERROR "GCC toolchain path at ENV{XTENSA_TOOLCHAIN_ROOT} ($ENV{XTENSA_TOOLCHAIN_ROOT}) does not exist.")
#else()
#    file(TO_CMAKE_PATH "$ENV{XTENSA_TOOLCHAIN_ROOT}" TOOLCHAIN_ROOT_DIR_CANONICAL)
#    set(TOOLCHAIN_ROOT_DIR ${TOOLCHAIN_ROOT_DIR_CANONICAL} CACHE INTERNAL "ESP GCC cross compiler toolchain root folder")
#    message(STATUS "Found GCC toolchain root at ${TOOLCHAIN_ROOT_DIR}")
#endif()

set(CMAKE_PROGRAM_PATH "${CMAKE_PROGRAM_PATH};${TOOLCHAIN_ROOT_DIR}/bin" CACHE INTERNAL "CMake program search path")

# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER    "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-gcc${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The C compiler to use for this target")
set(CMAKE_CXX_COMPILER  "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-g++${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The C++ compiler to use for this target")
set(CMAKE_ASM_COMPILER  "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-as${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The ASM compiler to use for this target")
set(CMAKE_LINKER        "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-ld${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The linker to use for this target")

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH  ${TOOLCHAIN_ROOT_DIR})

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

message(STATUS "C COMPILER IS ${CMAKE_C_COMPILER}")
message(STATUS "CXX COMPILER IS ${CMAKE_CXX_COMPILER}")
message(STATUS "ASM COMPILER IS ${CMAKE_ASM_COMPILER}")