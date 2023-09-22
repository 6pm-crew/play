#
# Copyright (c) 2023 6PM CREW <https://github.com/6pm-crew>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

.POSIX:

.PHONY: all clean
.PRAGMA: posix_202x
.SUFFIXES: .c .exe .o .out

_COLOR_BEGIN = \033[1;91m
_COLOR_END = \033[m

PROJECT_NAME = play
PROJECT_FULL_NAME = 6pm-crew/play

PROJECT_PREFIX = ${_COLOR_BEGIN}${PROJECT_FULL_NAME}:${_COLOR_END}

BINARY_PATH = bin
INCLUDE_PATH = include
LIBRARY_PATH = ./lib
SOURCE_PATH = src

OBJECTS = \
	${SOURCE_PATH}/main.o

TARGETS = ${BINARY_PATH}/${PROJECT_NAME}.out

CC ?= gcc
CFLAGS = -D_DEFAULT_SOURCE -g -I${INCLUDE_PATH} -I${RAYLIB_INCLUDE_PATH} \
	-O2 -std=c99
LDFLAGS = -L${RAYLIB_LIBRARY_PATH}
LDLIBS = -lraylib -ldl -lGL -lm -lpthread -lrt -lX11

# CFLAGS += -fsanitize=address -Wall -Werror -Wpedantic

all: pre-build build post-build

pre-build:
	@printf "${PROJECT_PREFIX} Using: '${CC}' to build this project.\n"

build: ${TARGETS}

.c.o:
	@printf "${PROJECT_PREFIX} Compiling: $@ (from $<)\n"
	@${CC} -c $< -o $@ ${CFLAGS}

${TARGETS}: ${OBJECTS}
	@mkdir -p ${BINARY_PATH}
	@printf "${PROJECT_PREFIX} Linking: ${TARGETS}\n"
	@${CC} ${OBJECTS} -o ${TARGETS} ${LDFLAGS} ${LDLIBS} ${WEBFLAGS}

post-build:
	@printf "${PROJECT_PREFIX} Build complete.\n"

raylib:
	@printf "${PROJECT_PREFIX} Cloning raylib to ${LIBRARY_PATH}...\n"
	@git clone https://github.com/raysan5/raylib ${LIBRARY_PATH}/raylib \
		> /dev/null 2>&1 || true
	@printf "${PROJECT_PREFIX} Attempting to build raylib...\n"
	@cd ${LIBRARY_PATH}/raylib/src && ${MAKE} clean > /dev/null 2>&1 \
		&& ${MAKE} -j`nproc` ${RAYLIB_MAKE_FLAGS} > /dev/null 2>&1
	@printf "${PROJECT_PREFIX} Build complete.\n"

clean:
	@printf "${PROJECT_PREFIX} Cleaning up.\n"
	@rm -f ${SOURCE_PATH}/*.data ${SOURCE_PATH}/*.exe ${SOURCE_PATH}/*.js \
		${SOURCE_PATH}/*.html ${SOURCE_PATH}/*.out ${SOURCE_PATH}/*.wasm
