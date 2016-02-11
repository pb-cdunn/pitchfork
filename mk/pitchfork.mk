PFHOME := $(realpath ../../..)

include $(PFHOME)/mk/config.mk
include $(PFHOME)/mk/sanity.mk

default:
	@echo "[INFO] nothing is done."
wscheck: sanity
	@mkdir -p $(WORKSPACE) || exit 1
_stcheck:
	@mkdir -p "$(STAGING)"              || exit 1
pfcheck: _stcheck
	@mkdir -p "$(PREFIX)/bin"           || exit 1
	@mkdir -p "$(PREFIX)/etc"           || exit 1
	@mkdir -p "$(PREFIX)/include"       || exit 1
	@mkdir -p "$(PREFIX)/lib"           || exit 1
	@mkdir -p "$(PREFIX)/lib/pkgconfig" || exit 1
	@mkdir -p "$(PREFIX)/share"         || exit 1
	@mkdir -p "$(PREFIX)/var/pkg"       || exit 1
ifeq ($(OPSYS),Darwin)
	@echo "export DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) PATH=$(PATH)" > "$(PREFIX)/setup-env.sh"
else
	@echo "export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH)     PATH=$(PATH)" > "$(PREFIX)/setup-env.sh"
endif

do-extract: do-fetch
do-fetch: wscheck
do-config: do-extract
do-build: do-config
do-install: do-build pfcheck
do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
