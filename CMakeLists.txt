cmake_minimum_required(VERSION 3.27)

set(CMAKE_CXX_STANDARD 17)

include(cmake/esp8266_toolchain.cmake)
include(cmake/CPM.cmake)
include(cmake/setup_venv.cmake)
include(cmake/configure_esp_freertos_sdk.cmake)

message(STATUS "C COMPILER IS ${CMAKE_C_COMPILER}")
message(STATUS "CXX COMPILER IS ${CMAKE_CXX_COMPILER}")
message(STATUS "ASM COMPILER IS ${CMAKE_ASM_COMPILER}")
setup_esp_freertos_sdk()

project(esp8266_temp_controller)
