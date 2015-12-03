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
	@cd $(_WRKSRC) && test -e configure.log || CFLAGS="$(_CFLAGS)" ./configure --prefix=$(PREFIX)
do-build: do-config
	@test -f $(_WRKSRC)/configure.log || exit 1
	@make -C $(_WRKSRC)
do-deploy: do-build pfcheck
	@install -m 755 $(_WRKSRC)/libz.so.1.2.8 $(PREFIX)/lib/libz.so.1.2.8
	@install -m 644 $(_WRKSRC)/zlib.3        $(PREFIX)/share/man/man3/zlib.3
	@install -m 644 $(_WRKSRC)/zlib.pc       $(PREFIX)/lib/pkgconfig/zlib.pc
	@install -m 644 $(_WRKSRC)/zlib.h        $(PREFIX)/include/zlib.h
	@install -m 644 $(_WRKSRC)/zconf.h       $(PREFIX)/include/zconf.h
do-uninstall:
	@rm -f $(PREFIX)/lib/libz.so.1.2.8
	@rm -f $(PREFIX)/share/man/man3/zlib.3
	@rm -f $(PREFIX)/lib/pkgconfig/zlib.pc
	@rm -f $(PREFIX)/include/zlib.h
	@rm -f $(PREFIX)/include/zconf.h
