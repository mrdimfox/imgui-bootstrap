cmake_minimum_required(VERSION 3.20)

# Enable compile commands for IntelliSense support
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


project(dear_imgui)

include(deps/imgui.cmake)

# Target setup
# ============

add_executable(${PROJECT_NAME} src/main.cpp)

target_include_directories(${PROJECT_NAME}
                           PRIVATE "${CMAKE_CURRENT_LIST_DIR}/src")

target_link_libraries(${PROJECT_NAME} PRIVATE imgui)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)

# Enable all warnings as errors
set(AVALIABLE_COMPILERS "Clang" "GNU")

if(CMAKE_CXX_COMPILER_ID IN_LIST AVALIABLE_COMPILERS)
  set(WARN_FLAGS -Wall -Wextra -Werror)
  target_compile_options(${PROJECT_NAME} PRIVATE ${WARN_FLAGS})

  message(
    STATUS
      "Warnings \"${WARN_FLAGS}\" was enabled for compiler ${CMAKE_CXX_COMPILER_ID}"
  )
else()
  message(
    STATUS "Warnings was not enabled for compiler ${CMAKE_CXX_COMPILER_ID}")
endif()
