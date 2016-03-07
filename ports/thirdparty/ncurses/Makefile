include ../../../mk/pitchfork.mk

# Local variables
_NAME   = ncurses-6.0
_URL    = ftp://ftp.gnu.org/gnu/ncurses
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch: $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-extract: $(_WRKSRC)
$(_WRKSRC): do-fetch
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-clean-distfile:
	rm -f $(_FILE)
do-config: $(_WRKSRC)/config.log
$(_WRKSRC)/config.log: do-extract
	(cd $(_WRKSRC) && CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(PREFIX) --with-shared 2>&1) \
        >& config.log || $(PFHOME)/bin/diewith config.log
do-build: $(_WRKSRC)/lib/libncurses.$(DYLIB)
$(_WRKSRC)/lib/libncurses.$(DYLIB): do-config
	$(MAKE) -C $(_WRKSRC) >& build.log || $(PFHOME)/bin/diewith build.log
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): do-build
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) prefix=$(STAGING)/$(_NAME) install >& install.log || $(PFHOME)/bin/diewith install.log
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
