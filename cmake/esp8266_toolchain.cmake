message(STATUS "Configuring toolchain for ESP8266 (Xtensa L106)...")

if((NOT EXISTS $ENV{XTENSA_TOOLCHAIN_ROOT}) AND (NOT DEFINED CACHE{TOOLCHAIN_ROOT_DIR}))
    message(FATAL_ERROR "GCC toolchain path at ENV{XTENSA_TOOLCHAIN_ROOT} ($ENV{XTENSA_TOOLCHAIN_ROOT}) does not exist.")
else()
    file(TO_CMAKE_PATH "$ENV{XTENSA_TOOLCHAIN_ROOT}" TOOLCHAIN_ROOT_DIR_CANONICAL)
    set(TOOLCHAIN_ROOT_DIR ${TOOLCHAIN_ROOT_DIR_CANONICAL} CACHE INTERNAL "ESP GCC cross compiler toolchain root folder")
    message(STATUS "Found GCC toolchain root at ${TOOLCHAIN_ROOT_DIR}")
endif()

LIST(APPEND CMAKE_PROGRAM_PATH  "$ENV{XTENSA_TOOLCHAIN_ROOT}/bin")

# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)

set(TOOLCHAIN_EXE_SUFFIX "")
if (WIN32)
    set(TOOLCHAIN_EXE_SUFFIX ".exe")
endif()

# which compilers to use for C and C++
set(CMAKE_C_COMPILER    "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-gcc${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The C compiler to use for this target")
set(CMAKE_CXX_COMPILER  "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-g++${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The C++ compiler to use for this target")
set(CMAKE_ASM_COMPILER  "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-as${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The ASM compiler to use for this target")
set(CMAKE_LINKER        "${TOOLCHAIN_ROOT_DIR}/bin/xtensa-lx106-elf-ld${TOOLCHAIN_EXE_SUFFIX}" CACHE INTERNAL "The linker to use for this target")

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH  $ENV{XTENSA_TOOLCHAIN_ROOT})

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
