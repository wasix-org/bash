#!/bin/bash -e

cat >Makefile <<'EOF'
# These variables are specifically meant to be overridable via the make
# command-line.
# ?= doesn't work for CC and AR because make has a default value for them.
ifeq ($(origin CC), default)
CC := clang
endif
NM ?= $(patsubst %clang,%llvm-nm,$(filter-out ccache sccache,$(CC)))
ifeq ($(origin AR), default)
AR = $(patsubst %clang,%llvm-ar,$(filter-out ccache sccache,$(CC)))
endif
EXTRA_CFLAGS ?= -O2 -DNDEBUG -ftls-model=local-exec

# A directory to install to for "make install".
INSTALL_DIR ?= /usr/bin
# single or posix
THREAD_MODEL ?= posix
# sysroot
SYSROOT ?= /prog/wasix-libc/sysroot32

# Set the target variables. Multiarch triples notably omit the vendor field,
# which happens to be what we do for the main target triple too.
TARGET_ARCH = wasm32
TARGET_TRIPLE = $(TARGET_ARCH)-wasi
MULTIARCH_TRIPLE = $(TARGET_ARCH)-wasi

# Add any extra flags
CFLAGS = $(EXTRA_CFLAGS)
# Set the target.
CFLAGS += --target=$(TARGET_TRIPLE)
# WebAssembly floating-point match doesn't trap.
# TODO: Add -fno-signaling-nans when the compiler supports it.
CFLAGS += -fno-trapping-math
# Add all warnings, but disable a few which occur in third-party code.
CFLAGS += -Wall -Wextra -Werror \
  -Wno-null-pointer-arithmetic \
  -Wno-unused-parameter \
  -Wno-sign-compare \
  -Wno-unused-variable \
  -Wno-unused-function \
  -Wno-ignored-attributes \
  -Wno-missing-braces \
  -Wno-ignored-pragmas \
  -Wno-unused-but-set-variable \
  -Wno-unknown-warning-option \
  -Wno-bitwise-op-parentheses \
  -Wno-deprecated-non-prototype \
  -Wno-shift-op-parentheses

# Configure support for threads.
ifeq ($(THREAD_MODEL), single)
CFLAGS += -mthread-model single
endif
ifeq ($(THREAD_MODEL), posix)
CFLAGS += -mthread-model posix -pthread
endif
CFLAGS += -I$(SYSROOT)/include
CFLAGS += -I$(CURDIR)/include

# Build the list of sources and objects
BASH_SOURCES = \
    $(shell find . -name \*.c)
objs = $(patsubst $(CURDIR)/%.c,$(OBJDIR)/%.o,$(1))
BASH_OBJS = $(call objs,$(BASH_SOURCES))

# Build the static object file
bash.a:
	$(CC) $(CFLAGS) alias.c

default: bash.a

EOF
make

