# Global overrides
GIT       = git
SED       = sed
MD5SUM    = md5sum
SHA1SUM   = sha1sum
WORKSPACE = $(realpath ../../..)/workspace
PREFIX   ?= $(realpath ../../..)/deployment
CFLAGS    = -fPIC -static-libgcc
CFLAGS   += -I$(PREFIX)/include -L$(PREFIX)/lib

default:
	@echo "[INFO] nothing is done."
wscheck:
	@mkdir -p $(WORKSPACE) || exit 1
pfcheck:
	@mkdir -p "$(PREFIX)/bin"            || exit 1
	@mkdir -p "$(PREFIX)/lib"            || exit 1
	@mkdir -p "$(PREFIX)/lib/pkgconfig"  || exit 1
	@mkdir -p "$(PREFIX)/share"          || exit 1
	@mkdir -p "$(PREFIX)/share/man"      || exit 1
	@mkdir -p "$(PREFIX)/include"        || exit 1
#	@mkdir -p "$(PREFIX)/share/man/man3" || exit 1
