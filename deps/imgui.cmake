
# Backend deps
# ============

find_package(glfw3 REQUIRED)
find_package(glad REQUIRED)
find_package(glm REQUIRED)
find_package(OpenGL REQUIRED)


# STB lib
# =======

# stb does not have a CMake build, but is header-only
find_path(STB_INCLUDE_DIRS "stb.h")
add_library(stb INTERFACE)
target_include_directories(stb INTERFACE ${STB_INCLUDE_DIRS})


# IMGUI lib
# =========

include(FetchContent)

FetchContent_Declare(
  imgui
  GIT_REPOSITORY https://github.com/ocornut/imgui.git
  GIT_TAG v1.84.1
  CONFIGURE_COMMAND "" BUILD_COMMAND "")

FetchContent_GetProperties(imgui)
if(NOT imgui_POPULATED)
  FetchContent_Populate(imgui)
endif()

add_library(imgui INTERFACE)

target_include_directories(imgui INTERFACE ${imgui_SOURCE_DIR})

message(STATUS "Imgui location: ${imgui_SOURCE_DIR}")

target_sources(
  imgui
  INTERFACE ${imgui_SOURCE_DIR}/imgui_widgets.cpp
            ${imgui_SOURCE_DIR}/imgui_tables.cpp
            ${imgui_SOURCE_DIR}/imgui_draw.cpp
            ${imgui_SOURCE_DIR}/imgui_demo.cpp
            ${imgui_SOURCE_DIR}/imgui.cpp
            ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp
            ${imgui_SOURCE_DIR}/backends/imgui_impl_glfw.cpp)

target_compile_definitions(
  imgui INTERFACE IMGUI_IMPL_OPENGL_LOADER_GLAD
                  IMGUI_SOURCE_DIR="${imgui_SOURCE_DIR}")

target_link_libraries(imgui INTERFACE glfw glad::glad glm::glm OpenGL::GL stb)
