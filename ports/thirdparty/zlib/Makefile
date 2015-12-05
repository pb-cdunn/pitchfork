include ../../../mk/config.mk

# Local variables
_NAME   = zlib-1.2.8
_URL    = https://github.com/cloudflare/zlib
_REV    = a80420c63532c25220a54ea0980667c02303460a
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS) -march=native -O3

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone -o $(_REV) $(_URL) $(_WRKSRC)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@cd $(_WRKSRC) && test -e configure.log || CFLAGS="$(_CFLAGS)" ./configure --prefix=$(STAGING)
do-build: do-config
	@test -f $(_WRKSRC)/configure.log || exit 1
	@$(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck
	@$(MAKE) -C $(_WRKSRC) install
	@install -m 644 $(STAGING)/include/zlib.h        $(PREFIX)/include/zlib.h
	@install -m 644 $(STAGING)/include/zconf.h       $(PREFIX)/include/zconf.h
	@install -m 755 $(STAGING)/lib/libz.so.1.2.8     $(PREFIX)/lib/libz.so.1.2.8
	@install -m 644 $(STAGING)/lib/pkgconfig/zlib.pc $(PREFIX)/lib/pkgconfig/zlib.pc
	@ln -f -s $(PREFIX)/lib/libz.so.1.2.8    $(PREFIX)/lib/libz.so
do-uninstall:
	@rm -f $(PREFIX)/lib/libz.so
	@rm -f $(PREFIX)/include/zlib.h
	@rm -f $(PREFIX)/include/zconf.h
	@rm -f $(PREFIX)/lib/libz.so.1.2.8
	@rm -f $(PREFIX)/lib/pkgconfig/zlib.pc
