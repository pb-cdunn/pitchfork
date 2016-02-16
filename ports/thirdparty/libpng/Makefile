include ../../../mk/pitchfork.mk

# Local variables
_NAME   = libpng-1.6.21
_URL    = https://prdownloads.sourceforge.net/libpng
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS)
_FILE   = $(_NAME).tar.gz

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	(cd $(_WRKSRC) && CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(PREFIX) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
	cp $(ZLIB_ROOT)/include/zlib.h $(ZLIB_ROOT)/include/zconf.h $(_WRKSRC)/
do-build: | $(_WRKSRC)/.libs/libpng16.$(DYLIB)
$(_WRKSRC)/.libs/libpng16.$(DYLIB):
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
	rm -f $(_WRKSRC)/config.log config.log
do-flush:
	rm -rf $(_WRKSRC) || true
