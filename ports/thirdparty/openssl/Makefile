include ../../../mk/config.mk

# Local variables
_NAME   = openssl-1.0.2e
_URL    = ftp://ftp.openssl.org/source
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: wscheck
	@test -d $(_WRKSRC) || curl -O $(_URL)/$(_FILE)
	@which $(SHA1SUM) >& /dev/null && $(SHA1SUM) -c SHA1SUM
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
	@rm -f $(_FILE)
do-config: do-extract
	@cd $(_WRKSRC) && test ! Configure -nt Makefile || CC="cc $(CFLAGS)" ./Configure --prefix=$(PREFIX)
do-build: do-config
	@test ! Configure -nt Makefile || exit 1
	@$(MAKE) -C $(_WRKSRC)
do-deploy: do-build pfcheck
	@install -m 755 $(_WRKSRC)/libcrypto.so.1.0.0 $(PREFIX)/lib/libcrypto.so.1.0.0
	@install -m 755 $(_WRKSRC)/libssl.so.1.0.0    $(PREFIX)/lib/libssl.so.1.0.0
	@install -m 644 $(_WRKSRC)/libcrypto.pc       $(PREFIX)/lib/pkgconfig/libcrypto.pc
	@install -m 644 $(_WRKSRC)/libssl.pc          $(PREFIX)/lib/pkgconfig/libssl.pc
	@install -m 644 $(_WRKSRC)/openssl.pc         $(PREFIX)/lib/pkgconfig/openssl.pc
	@install -d $(PREFIX)/include/openssl
	@cp $(_WRKSRC)/include/openssl/* $(PREFIX)/include/openssl/
	@chmod 644 $(PREFIX)/include/openssl/*.h
	@install -d $(PREFIX)/lib/engines
	@cp $(_WRKSRC)/engines/*.so $(PREFIX)/lib/engines/
	@chmod 755 $(PREFIX)/lib/engines/*.so
	@cd $(PREFIX)/lib && ln -f -s libssl.so.1.0.0 libssl.so
	@cd $(PREFIX)/lib && ln -f -s libcrypto.so.1.0.0 libcrypto.so
# 
#
