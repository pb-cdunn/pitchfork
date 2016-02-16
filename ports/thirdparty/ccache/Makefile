include ../../../mk/pitchfork.mk

# Local variables
_NAME   = ccache-3.2.4
_URL    = https://www.samba.org/ftp/ccache
_FILE	= $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -O $(_URL)/$@
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	(cd $(_WRKSRC) && ./configure --prefix=$(PREFIX) 2>&1) | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/ccache
$(_WRKSRC)/ccache:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) prefix=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME)/bin && ln -s ccache `basename $(CC)`
	cd $(STAGING)/$(_NAME)/bin && ln -s ccache `basename $(CXX)`
	cd $(STAGING)/$(_NAME)/bin && ln -s ccache `basename $(FC)`
	cd $(STAGING)/$(_NAME)/bin && ln -s ccache cpp
	cd $(STAGING)/$(_NAME)/bin && ln -s ccache CC
ifeq ($(OPSYS),Darwin)
	cd $(STAGING)/$(_NAME)/bin && ln -sf ccache clang
endif
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -f build.log install.log
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	$(MAKE) -C $(_WRKSRC) distclean
	rm -f $(_WRKSRC)/config.log config.log
do-flush:
	rm -rf $(_WRKSRC) || true
