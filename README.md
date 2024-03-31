# Quickstart C++ CMake template for ESP8266 boards.

The ESP8266 FreeRTOS SDK is a nice baseline project setup, however I hate the fact that to use it I have to first pollute my environment variables manually with GCC and FreeRTOS SDK paths.
All those extra configuration steps are manual and error-prone, so a project isn't quite portable to the point where you can just rebuild on any machine with the push of a button.

I also prefer to use C++, even on embedded systems, so using my own template makes it just that little bit easier to wrangle my toolchain.

This template simplifies your job to one easy manual step:

## Create a Python3 virtual environment somewhere

Usually your IDE can do this for you, but a simple option would be to run

"python -m venv ./.venv"

to create a `.venv` folder in your cloned repo.

From there you can use your cmake preset to configure and build the project,
and the template will handle pulling down and building the FreeRTOS SDK, as well as the GCC toolchain, for you.

No shitty python scripts, no MSYS2 junk, no editing your environment variables manually... just pure bliss.

### Example CMake commands (Windows)

To configure:

`cmake.exe --preset xtensa_windows -S E:\aakas\Documents\Code\esp8266_temp_controller -B E:\aakas\Documents\Code\esp8266_temp_controller\build\default`

To build:

`cmake.exe --build --target esp8266_template.elf --preset xtensa_build_windows`