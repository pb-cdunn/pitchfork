# Global overrides
SHELL      = /bin/bash
CC         = gcc
CXX        = g++
FC         = gfortran
GIT        = git
SED        = sed
CURL       = curl
MD5SUM     = md5sum
SHA1SUM    = sha1sum
PFHOME    := $(realpath ../../..)
WORKSPACE  = $(PFHOME)/workspace
PREFIX    ?= $(PFHOME)/deployment
STAGING   ?= $(PFHOME)/staging

CCACHE_DIR = $(WORKSPACE)/.ccache
CCACHE_BASEDIR = $(CCACHE_DIR)

include $(PFHOME)/mk/osdetect.mk

ifeq ($(OPSYS),Darwin)
    CFLAGS = -fPIC
    DYLIB  = dylib
endif
ifeq ($(OPSYS),Linux)
    CFLAGS = -fPIC -static-libgcc
    DYLIB  = so
endif
LDFLAGS    = -L$(PREFIX)/lib
CFLAGS    += -I$(PREFIX)/include $(LDFLAGS)

export CC
export CXX
export FC
export CCACHE_DIR
export CCACHE_BASEDIR

export PATH            := $(PREFIX)/bin:$(PFHOME)/bin:$(PATH)
export LD_LIBRARY_PATH := $(PREFIX)/lib:$(LD_LIBRARY_PATH)


include $(PFHOME)/mk/sanity.mk

default:
	@echo "[INFO] nothing is done."
wscheck:
	@mkdir -p $(WORKSPACE) || exit 1
_stcheck:
	@mkdir -p "$(STAGING)"              || exit 1
pfcheck: _stcheck
	@mkdir -p "$(PREFIX)/bin"           || exit 1
	@mkdir -p "$(PREFIX)/lib"           || exit 1
	@mkdir -p "$(PREFIX)/lib/pkgconfig" || exit 1
	@mkdir -p "$(PREFIX)/share"         || exit 1
	@mkdir -p "$(PREFIX)/include"       || exit 1
	@mkdir -p "$(PREFIX)/var/pkg"       || exit 1
	@mkdir -p "$(PREFIX)/etc"           || exit 1
#	@mkdir -p "$(PREFIX)/share/man"     || exit 1
