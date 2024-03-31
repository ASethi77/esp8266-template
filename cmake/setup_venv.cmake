function(setup_venv)
    cmake_parse_arguments(
            VENV_ARGS
            ""
            "REQUIREMENTS_PATH"
            ""
            ${ARGN}
    )

    if (NOT DEFINED VENV_ARGS_REQUIREMENTS_PATH)
        message(FATAL_ERROR "Cannot setup Python virtual environment without a requirements.txt path")
    endif()

    execute_process(
            COMMAND ${Python3_EXECUTABLE} "-m" "pip" "install" "-r" "${VENV_ARGS_REQUIREMENTS_PATH}" "--upgrade"
            COMMAND_ECHO STDOUT
            COMMAND_ERROR_IS_FATAL ANY
    )
endfunction()