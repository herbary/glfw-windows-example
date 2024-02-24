#ifdef _WIN32
#ifdef _MSC_VER
#pragma comment(linker, "/SUBSYSTEM:WINDOWS")
#pragma comment(linker, "/ENTRY:mainCRTStartup")

#pragma comment(lib, "glfw3.lib")
#endif // _MSC_VER

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#endif // _WIN32

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

// IWYU pragma: begin_keep
#include "gl3w/gl3w.h"
#include "./local/define/gl3w.h"

#include "glfw/glfw3.h"
#include "./local/define/glfw.h"
// IWYU pragma: end_keep

static void util_sleep(const uint32_t ms);
void util_sleep(const uint32_t ms) {
#ifdef _WIN32
    Sleep((DWORD)ms);
#endif
}

static void glfw_framebuffer_resize_callback(glfw_window_t *const window, const int32_t width, const int32_t height);
void glfw_framebuffer_resize_callback(glfw_window_t *const window, const int32_t width, const int32_t height) {
    (void)window;

    gl_viewport(0, 0, width, height);
}

int main(void) {
    if (!glfw_init()) {
        fputs("[ERROR] glfw#init\n", stderr);
        return EXIT_FAILURE;
    }

    glfw_window_hint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfw_window_hint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);

    glfw_window_t *const window = glfw_create_window(640, 480, "Example Window", NULL, NULL);
    if (!window) {
        fputs("[ERROR] glfw#create_window\n", stderr);
        glfw_terminate();
        return EXIT_FAILURE;
    }

    glfw_make_context_current(window);

    if (!gl3w_init()) {
        fputs("[ERROR] gl3w#init\n", stderr);
        glfw_terminate();
        return EXIT_FAILURE;
    }

    glfw_set_framebuffer_size_callback(window, &glfw_framebuffer_resize_callback);

    do {
        glfw_poll_events();
        if (glfw_window_should_close(window)) {
            break;
        }

        gl_clear_color(1, 192.f/255, 203.f/255, 0);
        gl_clear(GL_COLOR_BUFFER_BIT);

        glfw_swap_buffers(window);

        static const uint32_t frame_time = 1000 / 60;
        util_sleep(frame_time);
    } while (true);

    glfw_terminate();
    return EXIT_SUCCESS;
}
