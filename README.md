# Mupen64Plus repository for Cubieboard.

Source code added from AreaScout epository and mupen64plus git repository. 
The code has been modified to specificly work with the Cubieboard and sunxi processors (specifically sun7i).

The code runs with Framebuffer only. X11 is not tested nor intended to work.
 
## Required
To be able to run this, you nee a lot of compiling for SDL-1.2 and SDL-2.0.3. The table contains the flags with which I configured and compiled.

| SDL | Link | ./configure flags |
|:----|:-----|:-----------------:|
| 1.2 | https://www.libsdl.org/download-1.2.php | ``` --enable-alsa --enable-alsa-shared --enable-audio --enable-clock_gettime --enable-cpuinfo --enable-dummyaudio --enable-events --enable-file --enable-input-events --enable-input-tslob --enable-joystick --enable-loadso --enable-oss --enable-pthread-sem --enable-pthreads --enable-pulseaudio-shared --enable-pulseaudio --enable-sdl-dlopen --enable-shared --enable-threads --enable-timers --enable-video --enable-video-fbcon --enable-video-x11 'CFLAGS=-mfpu=neon -mfloat-abi=hard -ffast-math' --prefix=/usr ``` |
| 2.0 | https://www.libsdl.org/download-2.0.php | ``` --enable-alsa --enable-alsa-shared --enable-audio --enable-dbus --enable-atomic --enable-diskaudio --enable-dummyaudio --enable-file --enable-filesystem --enable-events --enable-input-tslib --enable-joystick --enable-loadso --enable-oss --enable-pthread-sem --enable-pthreads --enable-pulseaudio --enable-pulseaudio-shared --enable-render --enable-sdl-dlopen --enable-shared --enable-sndio --enable-sndio-shared --enable-threads --enable-timers --enable-video-dummy --enable-video-opengles --disable-video-x11 --disable-video-opengl CFLAGS='-mfpu=neon -mfloat-abi=hard -ffast-math -ftree-vectorize -mcpu=cortex-a7 -mtune=cortex-a7' --prefix=/usr ``` |

To be able to run, you might need to enable the SDL-1.2 x11 video driver since some of the input parts also use x11 libs. You can experiment with and without this option. NOTE: You need to add disable specifically as it will otherwise likely find remaining x11 libs and still compile it into the .so.

## Original locations of files

| Module | Link |
|:-------|:-----|
| gles2n64 | https://github.com/Nebuleon/mupen64plus-video-gles2n64 |
| mupen64plus | https://github.com/AreaScout/mupen64plus-odroid |
| mupen64plus | https://github.com/mupen64plus/ |

The eglports are from AreaScout, with some modification. The rise driver is changes to use pthread_mutex instead of SDL to avoid SDL2 compatibility and some changes to the Pandora and Odroid egl code has been made to let it run on the CBs.

## Tested

Tested on CB2 with manually compiled SDL libs. You might require some aditional libraries.
Using mali r4p0 on a 3.4 kernel from https://github.com/mireq/linux-sunxi

Kernel config is included in cfg directory under config-3.4.105
