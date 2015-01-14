#!/bin/sh
#/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# *   Mupen64plus - m64p_build.sh                                           *
# *   Mupen64Plus homepage: http://code.google.com/p/mupen64plus/           *
# *   Copyright (C) 2009 Richard Goedeken                                   *
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# *   This program is distributed in the hope that it will be useful,       *
# *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# *   GNU General Public License for more details.                          *
# *                                                                         *
# *   You should have received a copy of the GNU General Public License     *
# *   along with this program; if not, write to the                         *
# *   Free Software Foundation, Inc.,                                       *
# *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.          *
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

# terminate the script if any commands return a non-zero error code
set -e

if [ -z "$MAKE" ]; then
	MAKE=make
fi
if [ -z "$M64P_COMPONENTS" ]; then
	M64P_COMPONENTS="core-2.0 rom ui-console-2.0 audio-sdl input-sdl-2.0 rsp-hle-2.0 video-gles2n64 video-rice"
fi

mkdir -p ./test/
MAKE_INSTALL="PLUGINDIR= SHAREDIR= BINDIR= MANDIR= LIBDIR= INCDIR=api LDCONFIG=true "
# export CFLAGS='-I/usr/local/include/SDL -D_GNU_SOURCE=1 -D_REENTRANT'
# export LIBS='-L/usr/local/lib -Wl,-rpath,/usr/local/lib -lSDL -lpthread'
for component in ${M64P_COMPONENTS}; do
	if [ "${component}" = "core" ]; then
		component_type="library"
	elif  [ "${component}" = "rom" ]; then
		echo "************************************ Building test ROM"
		mkdir -p ./test/
		cp source/mupen64plus-rom/m64p_test_rom.v64 ./test/
		continue
	elif  [ "${component}" = "ui-console" ]; then
		component_type="front-end"
	else
		component_type="plugin"
	fi
    
	echo "************************************ Building ${component} ${component_type}"
	"$MAKE" -C source/mupen64plus-${component}/projects/unix clean $@
	"$MAKE" -j2 -C source/mupen64plus-${component}/projects/unix all $@
	"$MAKE" -j2 -C source/mupen64plus-${component}/projects/unix install $@ ${MAKE_INSTALL} DESTDIR="$(pwd)/test/"

	mkdir -p ./test/doc
	for doc in LICENSES README RELEASE; do
		if [ -e "source/mupen64plus-${component}/${doc}" ]; then
			cp "source/mupen64plus-${component}/${doc}" "./test/doc/${doc}-mupen64plus-${component}"
		fi
	done
	for subdoc in gpl-license font-license lgpl-license module-api-versions.txt; do
		if [ -e "source/mupen64plus-${component}/doc/${subdoc}" ]; then
			cp "source/mupen64plus-${component}/doc/${subdoc}" ./test/doc/
		fi
    done
	if [ ! -f ./test/gles2n64.conf ] ; then
		touch ./test/gles2n64.conf
        touch ./test/eglport.cfg
	fi
done
