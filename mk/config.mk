# Global overrides
SHELL      = /bin/bash -e
CC         = gcc
CXX        = g++
FC         = gfortran
AR         = ar
GIT        = git
SED        = sed
CURL       = curl
CMAKE      = cmake
UNAME      = uname
MD5SUM     = md5sum
SHA1SUM    = sha1sum

PFHOME    := $(realpath ../../..)

ifneq ("$(wildcard $(PFHOME)/settings.mk)","")
   include $(PFHOME)/settings.mk
endif

WORKSPACE ?= $(PFHOME)/workspace
PREFIX    ?= $(PFHOME)/deployment
STAGING   ?= $(PFHOME)/staging
CCACHE_DIR?= $(WORKSPACE)/.ccache
PIP        = $(PREFIX)/bin/pip --no-cache-dir


ARCH      := $(shell $(UNAME) -m)
OPSYS     := $(shell $(UNAME) -s)

ifeq ($(OPSYS),Darwin)
    DYLIB  = dylib
endif
ifeq ($(OPSYS),Linux)
    DYLIB  = so
endif

LDFLAGS    = -L$(PREFIX)/lib
CFLAGS     = -fPIC
CFLAGS    += -I$(PREFIX)/include
CXXFLAGS   = $(CFLAGS)

BOOST_INCLUDE ?= $(PREFIX)/include

export CC
export CXX
export FC
export CCACHE_DIR
export PATH              := $(PREFIX)/bin:$(PFHOME)/bin:${PATH}
ifeq ($(OPSYS),Darwin)
export DYLD_LIBRARY_PATH := $(PREFIX)/lib:${DYLD_LIBRARY_PATH}
else
export LD_LIBRARY_PATH   := $(PREFIX)/lib:${LD_LIBRARY_PATH}
endif
export PKG_CONFIG_PATH   := $(PREFIX)/lib/pkgconfig

