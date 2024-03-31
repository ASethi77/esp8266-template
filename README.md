# Quickstart CMake template for ESP8266 boards.

The ESP8266 FreeRTOS SDK is a nice baseline project setup, however I hate the fact that to use it I have to first pollute my environment variables manually with GCC and FreeRTOS SDK paths.
All those extra configuration steps are manual and error-prone, so a project isn't quite portable to the point where you can just rebuild on any machine with the push of a button.

This template simplifies your job to three easy manual steps:

## Downlaod the ESP8266 GCC toolchain

This is available from here: https://dl.espressif.com/dl/esp32_win32_msys2_environment_and_toolchain-20181001.zip

## Create a Python3 virtual environment somewhere

Usually your IDE can do this for you, but a simple option would be to run

"python -m venv ./.venv"

to create a `.venv` folder in your cloned repo.

## Update your CMakeUserPresets.json

Namely, update this one variable:

1. `XTENSA_TOOLCHAIN_ROOT`: The path where you downloaded the GCC toolchain from above

![image](https://github.com/ASethi77/esp8266-template/assets/7550606/1c52cda9-3d26-4198-929d-6ae0f85391ef)

From there you can use your cmake preset to configure and build, and the template will handle pulling down and building the FreeRTOS sdk for you. No shitty python scripts, no editing your environment variables manually... just pure bliss.
