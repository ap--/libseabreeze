CC  = gcc
CPP = g++

LFLAGS_LIB  =
LFLAGS_APP  = -L${SEABREEZE}/lib
CFLAGS_BASE = -I${SEABREEZE}/include \
              -c \
              -Wall \
              -Wunused \
              -Wmissing-include-dirs \
              -Werror \
              -O0 \
              -fpic \
              -fno-stack-protector \
              -shared	

# Select debug builds and architecture
SB_DEBUG ?= 0
SB_ARCH ?= 64

export UNAME = $(shell uname)

# MacOS X configuration
ifeq ($(UNAME), Darwin)
    LIBBASENAME = libseabreeze
    SUFFIX      = dylib
    LFLAGS_APP += -L/usr/lib \
                  -lstdc++
    LFLAGS_LIB += -dynamic \
                  -dynamiclib \
                  -framework Carbon \
                  -framework CoreFoundation \
                  -framework IOKit 
                                    
    CFLAGS_BASE = -I${SEABREEZE}/include \
                  -c \
                  -Wall \
                  -Wunused \
                  -Wmissing-include-dirs \
                  -Werror \
                  -O0 \
                  -fpic \
                  -fno-stack-protector 

    EXTRA_FLAGS = 
    ifeq ($(SB_DEBUG), 1)
	EXTRA_FLAGS += -g -DOOI_DEBUG
    endif
    ifneq (,$(filter $(SB_ARCH),32 fat))  # if 32 or fat
	EXTRA_FLAGS += -arch i386
	LFLAGS_LIB += -arch i386
    endif
    ifneq (,$(filter $(SB_ARCH),64 fat))  # if 64 or fat
	EXTRA_FLAGS += -arch x86_64
	LFLAGS_LIB += -arch x86_64
    endif

    # osx install name
    ifdef install_name
	LFLAGS_LIB += -install_name $(install_name)
    endif


# Cygwin-32 configuration 
else ifeq ($(findstring CYGWIN, $(UNAME)), CYGWIN)
    # caller can override this, but this is the current Ocean Optics default
    VISUALSTUDIO_PROJ ?= VisualStudio2015bbbbbbb
    LIBBASENAME = SeaBreeze
    SUFFIX      = dll
    CFLAGS_BASE = -I${SEABREEZE}/include \
                  -c \
                  -Wall \
                  -Wunused \
                  -Werror \
                  -shared

    EXTRA_FLAGS = 
    ifeq ($(SB_DEBUG), 1)
	EXTRA_FLAGS += /property:Configuration=Debug
    else
	EXTRA_FLAGS += /property:Configuration=Release
    endif
    ifeq ($(SB_ARCH), 32)
	EXTRA_FLAGS += /property:Platform=Win32
    else
	EXTRA_FLAGS += /property:Platform=x64
    endif

    export MSBUILD_OPTS = $(EXTRA_FLAGS)
# Linux configuration
else
    SUFFIX      = so
    LIBBASENAME = libseabreeze
    LFLAGS_APP += -L/usr/lib \
                  -lstdc++ \
                  -lusb \
                  -lm
    LFLAGS_LIB += -L/usr/lib \
                  -shared \
                  -lusb
    
    EXTRA_FLAGS = 
    ifeq ($(SB_DEBUG), 1)
	EXTRA_FLAGS += -g -DOOI_DEBUG
    endif
    ifeq ($(SB_ARCH), 32)
	EXTRA_FLAGS += -m32
	LFLAGS_LIB = -L/usr/lib32 \
		     -L/lib32 \
		     -L/lib/i386-linux-gnu \
		     -m32 \
		     -shared \
		     -lusb
    endif

endif


# these are for the .o files making up libseabreeze
CPPFLAGS     = $(CFLAGS_BASE) $(EXTRA_FLAGS)
CFLAGS       = $(CFLAGS_BASE) -std=gnu99 $(EXTRA_FLAGS)

export LIBNAME=$(LIBBASENAME).$(SUFFIX)

SUFFIXES = .c .cpp .o .d

SRCS_CPP := $(wildcard *.cpp)
DEPS_CPP := $(patsubst %.cpp,%.d,$(SRCS_CPP))
OBJS_CPP := $(patsubst %.cpp,%.o,$(SRCS_CPP))

SRCS_C   := $(wildcard *.c)
DEPS_C   := $(patsubst %.c,%.d,$(SRCS_C))
OBJS_C   := $(patsubst %.c,%.o,$(SRCS_C))

VISUALSTUDIO_PROJECTS = VisualStudio2005 \
			VisualStudio2008 \
                        VisualStudio2010 \
                        VisualStudio2012 \
                        VisualStudio2013 \
                        VisualStudio2015

ifneq ($(MAKECMDGOALS),clean)
    -include $(DEPFILES)
endif

deps: ${DEPS_CPP} ${DEPS_C}

%.d: %.cpp
	@echo caching $@
	@${CPP} ${CFLAGS_BASE} -MM $< | sed "s/$*.o/& $@/g" > $@

%.d: %.c
	@echo caching $@
	@${CC} ${CFLAGS_BASE} -MM $< | sed "s/$*.o/& $@/g" > $@

%.o: %.cpp
	@echo building $@
	@${CPP} ${CPPFLAGS} $< -o $@

%.o: %.c
	@echo building $@
	@${CC} ${CFLAGS} $< -o $@

objs: subdirs ${OBJS_CPP} ${OBJS_C}
	@/bin/cp *.o ${SEABREEZE}/lib 1>/dev/null 2>&1 || true

subdirs:
	@if [ "$(SUBDIRS)" ] ; then for d in $(SUBDIRS) ; do $(MAKE) -C $$d || exit ; done ; else true ; fi

clean:
	@echo cleaning $$PWD
	@for d in $(SUBDIRS); do $(MAKE) -C $$d $@ || exit; done
	@$(RM) -f *.d *.o *.obj *.exe *.stackdump lib/* $(APPS)
	@for VS in $(VISUALSTUDIO_PROJECTS) ; \
     do \
        if [ -d os-support/windows/$$VS ] ; \
        then \
            echo cleaning os-support/windows/$$VS ; \
            ( cd os-support/windows/$$VS && $(MAKE) clean ) || exit ; \
        fi ; \
     done
	@if [ -d doc ] ; then ( cd doc && $(RM) -rf man rtf html *.err ) ; fi

new: clean all
