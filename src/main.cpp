#include "imgui.h"
#include "imgui_bootstrap.hpp"

int main(int, char**)
{
    auto glsl_version = imgui::glfw_init();
    if (!glsl_version) {
        return 1;
    }

    auto window = imgui::create_window(*glsl_version);
    if (!window) {
        return 1;
    }

    ImGuiStyle& style = ImGui::GetStyle();
    style.ScaleAllSizes(2);

    // Load Fonts
    ImGuiIO& io = ImGui::GetIO();
    io.Fonts->AddFontDefault();
    auto roboto_font = io.Fonts->AddFontFromFileTTF(
      IMGUI_SOURCE_DIR "/misc/fonts/Roboto-Medium.ttf", 24.0f);

    // Our state
    bool show_demo_window = true;
    bool show_another_window = false;
    ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);

    imgui::loop(*window, clear_color, [&]() {
        // in ImGui::ShowDemoWindow()! You can browse its code to
        // learn more about Dear ImGui!).
        if (show_demo_window) {
            ImGui::ShowDemoWindow(&show_demo_window);
        }

        // 2. Show a simple window that we create ourselves. We use
        // a Begin/End pair to created a named window.
        {
            static float f = 0.0f;
            static int counter = 0;

            ImGui::PushFont(roboto_font);
            ImGui::Begin("Hello, world!");

            ImGui::Text("This is some useful text.");
            ImGui::Checkbox("Demo Window", &show_demo_window);
            ImGui::Checkbox("Another Window", &show_another_window);

            ImGui::SliderFloat("float", &f, 0.0f, 1.0f);
            ImGui::ColorEdit3("clear color", (float*)&clear_color);
            if (ImGui::Button("Button")) {
                counter++;
            }
            ImGui::SameLine();
            ImGui::Text("counter = %d", counter);

            ImGui::Text("Application average %.3f ms/frame (%.1f FPS)",
                        1000.0f / io.Framerate, io.Framerate);
            ImGui::End();
            ImGui::PopFont();
        }

        // 3. Show another simple window.
        if (show_another_window) {
            ImGui::Begin("Another Window", &show_another_window);
            ImGui::Text("Hello from another window!");
            if (ImGui::Button("Close Me")) {
                show_another_window = false;
            }
            ImGui::End();
        }
    });

    // Cleanup
    imgui::cleanup(*window);

    return 0;
}
