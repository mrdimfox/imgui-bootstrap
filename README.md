# ImGUI CMake+vcpkg project

Preconfigured CMake + [vcpkg](https://github.com/microsoft/vcpkg) project for
FFU as a base of other projects.

<image src="./doc/example.png" width="500"></image><br>
*How it's look like*

## Source

The app source is a copy of
[example_glfw_opengl3](https://github.com/ocornut/imgui/blob/master/examples/example_glfw_opengl3/main.cpp)
with some modifications with a goal to hide a backend initialization spaghetti
code. The hidden code located in `imgui_bootstrap.hpp` header file.

## Build

The next set of backend libs is used for ImGUI:

- opengl;
- glfw3;
- glad;
- glm.

All of them are fetched by `vcpkg`. Only `ImGUI` is fetched from [GitHub
repo](https://github.com/ocornut/imgui) with `FetchContent` tool. See
`deps/imgui.cmake`.

For Windows "Visual Studio 15 2017" is used. For Linux GCC with C++17 support
is used. The compiler must be installed on your system before the configuring.
Ninja is required for the Linux build too.

If you want to build a release version change `CMAKE_BUILD_TYPE` in
`CMakePresets.json` file.

### Fast way

You have just to run a preconfigured CMake script to init vcpkg, configure and
build all.

```bash
cmake -P build_all.cmake
```

### By hand

Go to the root folder and clone `vcpkg`.

```bash
git clone https://github.com/microsoft/vcpkg.git
```

Then configure CMake with a preset accoring to your OS.

```bash
cmake --preset=windows .
# or
cmake --preset=linux .
```

Build the executable:

```bash
cmake --build build
```

## Run

After the building, the executable should appear somewhere in `build` folder.
On Windows it should be in `Debug` subfolder.

## Debug

The project's been preconfigured for [VS Code
IDE](https://code.visualstudio.com/). See `.vscode` folder files. Just 

- open the project in VS Code,
- install
  [C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
  and
  [CMake](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
  extentions,
- rename `settings.template.json` to `settings.json`, 
- select one of CMake, presets, 
- press the build button.

After that, you can select launch configuration according to your platform and
start debugging. Pay attention to `linux.env` file if you are on the Linux
platform: `DISPLAY` variable must be selected correctly or deleted from there.
