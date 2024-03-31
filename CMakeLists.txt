cmake_minimum_required(VERSION 3.27)

set(CMAKE_CXX_STANDARD 17)

include(cmake/configure_esp8266_toolchain.cmake)
include(cmake/CPM.cmake)
include(cmake/setup_venv.cmake)
include(cmake/apply_patch.cmake)
include(cmake/configure_esp_freertos_sdk.cmake)

setup_esp_freertos_sdk()

project(esp8266_template)
