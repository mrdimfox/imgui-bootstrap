message(STATUS "Starting to build everything on ${CMAKE_HOST_SYSTEM_NAME}")

if (CONFIGURE OR BUILD)
    set(ALL NO)
else()
    set(ALL YES)
endif()

# Define CMake preset
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
    set(CMAKE_PRESET "windows")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    set(CMAKE_PRESET "linux")
else()
    message(FATAL_ERROR "Platform is not suported!")
endif()

# Clone vcpkg
if(NOT EXISTS vcpkg)
    message(STATUS "vcpkg was not found. Cloning...")
    execute_process(COMMAND git clone https://github.com/microsoft/vcpkg.git)
else()
    message(STATUS "Skipping cloning because vcpkg already exists")
endif()

# Configure
if (CONFIGURE OR ALL)
    execute_process(COMMAND cmake --preset=${CMAKE_PRESET} .)
endif()

# Build
if (BUILD OR ALL)
    execute_process(COMMAND cmake --build build)
endif()
