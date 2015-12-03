# Global overrides
GIT       = git
SED       = sed
WORKSPACE = $(realpath ../../..)/workspace
PREFIX   ?= $(realpath ../../..)/deployment
CFLAGS    = -fPIC -static-libgcc

default:
	@echo "[INFO] nothing is done."
wscheck:
	@mkdir -p $(WORKSPACE) || exit 1
pfcheck:
	@mkdir -p "$(PREFIX)" || exit 1
