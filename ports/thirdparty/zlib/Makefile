include ../../../mk/pitchfork.mk

# Local variables
_NAME   = zlib-1.2.8
_URL    = http://zlib.net
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = $(_NAME).tar.gz

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-config: | $(_WRKSRC)/configure.log
$(_WRKSRC)/configure.log:
	(cd $(_WRKSRC) && ./configure --prefix=$(PREFIX) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/libz.a
$(_WRKSRC)/libz.a:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) prefix=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -f build.log install.log
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	$(MAKE) -C $(_WRKSRC) distclean
	rm -f $(_WRKSRC)/configure.log config.log
do-flush:
	rm -rf $(_WRKSRC) || true
