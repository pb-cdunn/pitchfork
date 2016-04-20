override SELF_DIR:=$(dir $(lastword $(MAKEFILE_LIST)))
override PFHOME:=$(realpath $(SELF_DIR)/..)

include $(SELF_DIR)/config.mk

default:
	@echo "[INFO] nothing is done."

do-fetch:
do-extract: do-fetch
do-config: do-extract
do-build: do-config
do-install: do-build
do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
#do-distclean: do-clean
provided:
