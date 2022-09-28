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
         -include ./config.h \
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
         -Wno-incompatible-pointer-types \
         -Wno-deprecated-non-prototype \
         -Wno-deprecated-declarations \
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
      xmalloc \
      version \
      y.tab

OBJS = $(SRC:=.o) \
      builtins/common.o \
      builtins/evalfile.o \
      builtins/evalstring.o \
      builtins/bashgetopt.o \
      builtins/getopt.o \
      builtins/alias.o \
      builtins/bind.o \
      builtins/break.o \
      builtins/builtin.o \
      builtins/builtins.o \
      builtins/caller.o \
      builtins/cd.o \
      builtins/colon.o \
      builtins/command.o \
      builtins/complete.o \
      builtins/declare.o \
      builtins/echo.o \
      builtins/enable.o \
      builtins/eval.o \
      builtins/exec.o \
      builtins/exit.o \
      builtins/fc.o \
      builtins/fg_bg.o \
      builtins/getopts.o \
      builtins/hash.o \
      builtins/help.o \
      builtins/history.o \
      builtins/inlib.o \
      builtins/jobs.o \
      builtins/kill.o \
      builtins/let.o \
      builtins/mapfile.o \
      builtins/printf.o \
      builtins/pushd.o \
      builtins/read.o \
      builtins/return.o \
      builtins/set.o \
      builtins/setattr.o \
      builtins/shift.o \
      builtins/shopt.o \
      builtins/source.o \
      builtins/suspend.o \
      builtins/test.o \
      builtins/times.o \
      builtins/trap.o \
      builtins/type.o \
      builtins/ulimit.o \
      builtins/umask.o \
      builtins/wait.o \
      lib/sh/casemod.o \
      lib/sh/clktck.o \
      lib/sh/clock.o \
      lib/sh/dprintf.o \
      lib/sh/eaccess.o \
      lib/sh/fmtullong.o \
      lib/sh/fmtulong.o \
      lib/sh/fmtumax.o \
      lib/sh/fnxform.o \
      lib/sh/fpurge.o \
      lib/sh/getcwd.o \
      lib/sh/getenv.o \
      lib/sh/gettimeofday.o \
      lib/sh/inet_aton.o \
      lib/sh/input_avail.o \
      lib/sh/itos.o \
      lib/sh/mailstat.o \
      lib/sh/makepath.o \
      lib/sh/mbscasecmp.o \
      lib/sh/mbschr.o \
      lib/sh/mbscmp.o \
      lib/sh/mktime.o \
      lib/sh/netconn.o \
      lib/sh/netopen.o \
      lib/sh/oslib.o \
      lib/sh/pathcanon.o \
      lib/sh/pathphys.o \
      lib/sh/random.o \
      lib/sh/rename.o \
      lib/sh/setlinebuf.o \
      lib/sh/shmatch.o \
      lib/sh/shmbchar.o \
      lib/sh/shquote.o \
      lib/sh/shtty.o \
      lib/sh/snprintf.o \
      lib/sh/spell.o \
      lib/sh/strcasecmp.o \
      lib/sh/strcasestr.o \
      lib/sh/strchrnul.o \
      lib/sh/strdup.o \
      lib/sh/strerror.o \
      lib/sh/strftime.o \
      lib/sh/stringlist.o \
      lib/sh/stringvec.o \
      lib/sh/strnlen.o \
      lib/sh/strpbrk.o \
      lib/sh/strstr.o \
      lib/sh/strtod.o \
      lib/sh/strtol.o \
      lib/sh/strtoll.o \
      lib/sh/strtoul.o \
      lib/sh/strtoull.o \
      lib/sh/strtrans.o \
      lib/sh/times.o \
      lib/sh/timeval.o \
      lib/sh/tmpfile.o \
      lib/sh/uconvert.o \
      lib/sh/ufuncs.o \
      lib/sh/unicode.o \
      lib/sh/utf8.o \
      lib/sh/vprint.o \
      lib/sh/wcsdup.o \
      lib/sh/wcsnwidth.o \
      lib/sh/wcswidth.o \
      lib/sh/winsize.o \
      lib/sh/zcatfd.o \
      lib/sh/zgetline.o \
      lib/sh/zmapfd.o \
      lib/sh/zread.o \
      lib/sh/zwrite.o

all: shell
	cp -f shell.wasm /prog/ate/wasmer-web/public/bin/bash.wasm

shell: sh builtins $(OBJS)
	clang $(CFLAGS) $(CLFLAGS) \
              $@.c $(OBJS) \
              -o $@.rustc.wasm
	wasm-opt -O2 --asyncify $@.rustc.wasm -o $@.wasm

builtins:
	cd builtins && make && cd ../..

sh:
	cd lib/sh && make && cd ../..

mksyntax: $(OBJS)
	clang $(CFLAGS) $(CLFLAGS) \
              $@.c $(OBJS) \
              -o $@.rustc.wasm
	wasm-opt -O2 --asyncify $@.rustc.wasm -o $@.wasm

%: %.c
	clang $(CFLAGS) \
              $@.c \
			  -c \
              -o $@.o

export PATH := $(LLD_PATH):$(PATH)

clean:
	cd builtins && make clean && cd ..
	cd lib/sh && make clean && cd ../..
	rm -f *.o
	rm -f *.s
	rm -f *.ll
	rm -f *.wasm
