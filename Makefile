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
         --sysroot ../wasix-libc/sysroot32 \
         -I. \
         -I./include \
         -I./lib \
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
         -MD \
         -MP

#-Wno-deprecated-non-prototype \
         
CLFLAGS = -Wl,--shared-memory \
          -Wl,--max-memory=4294967296 \
          -Wl,--import-memory \
          -Wl,--export-dynamic \
		  -Wl,--export=__heap_base \
          -Wl,--export=__stack_pointer \
          -Wl,--export=__data_end \
          -Wl,--export=__wasm_init_tls \
          -Wl,--export=__wasm_signal \
          -Wl,--export=__tls_size \
          -Wl,--export=__tls_align \
          -Wl,--export=__tls_base

#SRC=$(wildcard *.c)

# Swap jobs for nojobs to get support for jobs
      
SRC = alias \
      array \
      arrayfunc \
      assoc \
      bashhist \
      bashline \
      bracecomp \
      braces \
      copy_cmd \
      dispose_cmd \
      error \
      eval \
      execute_cmd \
      expr \
      findcmd \
      flags \
      general \
      hashcmd \
      hashlib \
      input \
      list \
      locale \
      mailcheck \
      make_cmd \
      mksyntax \
      nojobs \
      pathexp \
      pcomplete \
      pcomplib \
      print_cmd \
      redir \
      sig \
      siglist \
      stringlib \
      subst \
      test \
      trap \
      unwind_prot \
      variables \
      xmalloc

OBJS = $(SRC:=.o)

all: shell

shell: $(OBJS)
	clang $(CFLAGS) $(CLFLAGS) \
              $(OBJS) \
              -o $@.rustc.wasm
	wasm-opt -O2 --asyncify $@.rustc.wasm -o $@.wasm
	cp -f $@.wasm /prog/ate/wasmer-web/public/bin

%.o: %.c
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
