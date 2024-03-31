function(apply_git_patch)
    find_package(Git)
    if (NOT Git_FOUND)
        message(FATAL_ERROR "Git must be installed and accessible on the system to use apply_git_patch().")
    endif()

    cmake_parse_arguments(
            PATCH_ARGS
            ""
            "SRC_FOLDER;PATCH_FILE"
            ""
            ${ARGN}
    )

    if ((NOT DEFINED PATCH_ARGS_SRC_FOLDER) OR (NOT EXISTS ${PATCH_ARGS_SRC_FOLDER}))
        message(FATAL_ERROR "Must provide valid src folder path where patch should be applied. (${PATCH_ARGS_SRC_FOLDER})")
    endif()
    if ((NOT DEFINED PATCH_ARGS_PATCH_FILE) OR (NOT EXISTS ${PATCH_ARGS_PATCH_FILE}))
        message(FATAL_ERROR "Must provide valid path to patch file. (${PATCH_ARGS_PATCH_FILE})")
    endif()

    message(STATUS "Attempting to apply git patch ${PATCH_ARGS_PATCH_FILE} to ${PATCH_ARGS_SRC_FOLDER}...")

    execute_process(
            COMMAND ${GIT_EXECUTABLE} "apply" "--reverse" "--check" ${PATCH_ARGS_PATCH_FILE}
            WORKING_DIRECTORY ${PATCH_ARGS_SRC_FOLDER}
            COMMAND_ECHO STDOUT
            RESULT_VARIABLE REVERSE_APPLY_RESULT
            ERROR_QUIET
    )
    if (REVERSE_APPLY_RESULT EQUAL 0)
        message(STATUS "Patch file ${PATCH_ARGS_PATCH_FILE} was already applied, nothing to do")
        return()
    endif()

    execute_process(
            COMMAND ${GIT_EXECUTABLE} "apply" ${PATCH_ARGS_PATCH_FILE}
            WORKING_DIRECTORY ${PATCH_ARGS_SRC_FOLDER}
            COMMAND_ECHO STDOUT
            COMMAND_ERROR_IS_FATAL ANY
    )
endfunction()