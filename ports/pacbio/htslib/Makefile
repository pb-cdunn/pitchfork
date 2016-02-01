include ../../../mk/config.mk

# Local variables
_NAME   = htslib
_URL    = https://github.com/PacificBiosciences/$(_NAME)
_REV    = ea846607f3ca7f49b3fb43df76f572d3f47cc6bb
_WRKSRC = $(WORKSPACE)/$(_NAME)

export CC
export CFLAGS

# Local works
do-fetch: | $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
$(_WRKSRC):
	@$(GIT) clone $(_URL) $@
do-build:
	@$(MAKE) -C $(_WRKSRC) ZLIB_ROOT=$(PREFIX) CFLAGS="$(CFLAGS) -Wall -O2 -Wno-unused-function" LDFLAGS=$(LDFLAGS)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)/src/htslib
	@mkdir -p $(STAGING)/$(_NAME)/lib
	@cd $(_WRKSRC) && \
        tar cf - Makefile *.cmake *.mk */*.[c,h] *.[a,c,h]|tar xf - -C $(STAGING)/$(_NAME)/src/htslib/
	@cd $(_WRKSRC) && tar cf - *.$(DYLIB)   | tar xf - -C $(STAGING)/$(_NAME)/lib/
ifeq ($(OPSYS),Darwin)
	@cd $(_WRKSRC) && tar cf - *.$(DYLIB).* | tar xf - -C $(STAGING)/$(_NAME)/lib/
endif
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)/
	@find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
