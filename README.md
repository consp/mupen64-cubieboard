# Mupen64Plus repository for Cubieboard.

Source is currently missing dus to some hacks and lack of time. Will upload about a week
 
## Required
To be able to run this, you nee a lot of compiling for SDL-1.2 and SDL-2.0.3. The table contains the flags with which I configured and compiled.

| SDL | Link | ./configure flags |
|:----|:-----|:-----------------:|
| 1.2 | https://www.libsdl.org/download-1.2.php | ``` --enable-alsa --enable-alsa-shared --enable-audio --enable-clock_gettime --enable-cpuinfo --enable-dummyaudio --enable-events --enable-file --enable-input-events --enable-input-tslob --enable-joystick --enable-loadso --enable-oss --enable-pthread-sem --enable-pthreads --enable-pulseaudio-shared --enable-pulseaudio --enable-sdl-dlopen --enable-shared --enable-threads --enable-timers --enable-video --enable-video-fbcon --enable-video-x11 'CFLAGS=-mfpu=neon -mfloat-abi=hard -ffast-math' --prefix=/usr ``` |
| 2.0 | https://www.libsdl.org/download-2.0.php | ``` --enable-alsa --enable-alsa-shared --enable-audio --enable-dbus --enable-atomic --enable-diskaudio --enable-dummyaudio --enable-file --enable-filesystem --enable-events --enable-input-tslib --enable-joystick --enable-loadso --enable-oss --enable-pthread-sem --enable-pthreads --enable-pulseaudio --enable-pulseaudio-shared --enable-render --enable-sdl-dlopen --enable-shared --enable-sndio --enable-sndio-shared --enable-threads --enable-timers --enable-video-dummy --enable-video-opengles --disable-video-x11 --disable-video-opengl CFLAGS='-mfpu=neon -mfloat-abi=hard -ffast-math -ftree-vectorize -mcpu=cortex-a7 -mtune=cortex-a7' --prefix=/usr ``` |

To be able to run, you might need to disable the SDL-1.2 x11 video driver. 

## Original locations of files

| Module | Link |
|:-------|:-----|
| gles2n64 | https://github.com/Nebuleon/mupen64plus-video-gles2n64 |
| mupen64plus | https://github.com/AreaScout/mupen64plus-odroid |
| mupen64plus | https://github.com/mupen64plus/ |

The eglports are from AreaScout, with some modification. The rise driver is changes to use pthread_mutex instead of SDL to avoid SDL2 compatibility and some changes to the Pandora and Odroid egl code has been made to let it run on the CBs.

## Tested

Tested on CB2 with manually compiled SDL libs. You might require some aditional libraries.
