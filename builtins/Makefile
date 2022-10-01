CC=clang
LLD_PATH=/prog/rust/build/x86_64-unknown-linux-gnu/lld/bin

PACKAGE = bash
prefix = /usr/local
datarootdir = ${prefix}/share
datadir = ${datarootdir}
infodir = ${datarootdir}/info
localedir = ${datarootdir}/locale

Machine = wasm32
OS = wasi
VENDOR = wasmer
MACHTYPE = wasm32-wasmer-wasi

CFLAGS = --target=wasm32-wasmer-wasi \
         -O2 \
         -include ../config.h \
         --sysroot ../../wasix-libc/sysroot32 \
         -I. \
         -I.. \
         -I../include \
         -I../lib \
         -matomics \
         -mbulk-memory \
         -mmutable-globals \
         -pthread \
         -mthread-model posix \
         -ftls-model=local-exec \
         -fno-trapping-math \
         -DLOCALEDIR='"$(localedir)"' \
         -DPACKAGE='"$(PACKAGE)"' \
         -DCONF_HOSTTYPE='"$(Machine)"' \
         -DCONF_OSTYPE='"$(OS)"' \
         -DCONF_MACHTYPE='"$(MACHTYPE)"' \
         -DCONF_VENDOR='"$(VENDOR)"' \
         -D_WASI_EMULATED_MMAN \
         -D_WASI_EMULATED_SIGNAL \
         -D_WASI_EMULATED_PROCESS_CLOCKS \
         -Wall \
         -Wextra \
         -Werror \
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
         -Wno-parentheses \
         -Wno-shift-op-parentheses \
         -Wno-bitwise-op-parentheses \
         -Wno-logical-op-parentheses \
         -Wno-string-plus-int \
         -Wno-dangling-else \
         -Wno-unknown-pragmas \
         -Wno-format-security \
         -Wno-unused-label \
         -Wno-incompatible-pointer-types \
         -Wno-deprecated-non-prototype \
         -Wno-deprecated-declarations \
         -MD \
         -MP

#SRC=$(wildcard *.c)
      
SRC = bashgetopt \
      common \
      evalfile \
      evalstring \
      getopt \
      mkbuiltins \
      alias \
      bind \
      break \
      builtin \
      builtins \
      caller \
      cd \
      colon \
      command \
      complete \
      declare \
      echo \
      enable \
      eval \
      exec \
      exit \
      fc \
      fg_bg \
      getopts \
      hash \
      help \
      history \
      inlib \
      jobs \
      kill \
      let \
      mapfile \
      printf \
      pushd \
      read \
      return \
      set \
      setattr \
      shift \
      shopt \
      source \
      suspend \
      test \
      times \
      trap \
      type \
      ulimit \
      umask \
      wait

OBJS = $(SRC:=.o)

all: $(OBJS)

%: %.c
	clang $(CFLAGS) \
              $@.c \
			  -c \
              -o $@.o

export PATH := $(LLD_PATH):$(PATH)

clean:
	rm -f *.o
	rm -f *.s
	rm -f *.ll
	rm -f *.wasm
