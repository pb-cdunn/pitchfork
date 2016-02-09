include ../../../mk/config.mk

# FC check
include ../../../mk/chkfc.mk

# Local variables
_NAME   = OpenBLAS-0.2.15
_URL    = https://github.com/xianyi/OpenBLAS/archive
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = v0.2.15.tar.gz

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-build: | $(_WRKSRC)/libopenblas.$(DYLIB)
$(_WRKSRC)/libopenblas.$(DYLIB):
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) PREFIX=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
do-clean:
	rm -rf $(_WRKSRC) || true
