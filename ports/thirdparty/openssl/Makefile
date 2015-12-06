include ../../../mk/config.mk

# Local variables
_NAME   = openssl-1.0.2e
_URL    = ftp://ftp.openssl.org/source
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: wscheck
	@test -e $(_FILE) || curl -O $(_URL)/$(_FILE)
	@which $(SHA1SUM) >& /dev/null && $(SHA1SUM) -c SHA1SUM
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-clean-distfile:
	@rm -f $(_FILE)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
	@rm -f $(_FILE)
do-config: do-extract
	@cd $(_WRKSRC) && test -d include/openssl \
     || CC="gcc $(CFLAGS)" ./Configure \
            --prefix=$(STAGING) \
            linux-x86_64 \
            shared \
            -Wa,--noexecstack
do-build: do-config
	@test ! Configure -nt Makefile || exit 1
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install
	@install -m 755 $(STAGING)/lib/libssl.so.1.0.0        $(PREFIX)/lib/libssl.so.1.0.0
	@install -m 755 $(STAGING)/lib/libcrypto.so.1.0.0     $(PREFIX)/lib/libcrypto.so.1.0.0
	@install -m 644 $(STAGING)/lib/pkgconfig/libssl.pc    $(PREFIX)/lib/pkgconfig/libssl.pc
	@install -m 644 $(STAGING)/lib/pkgconfig/openssl.pc   $(PREFIX)/lib/pkgconfig/openssl.pc
	@install -m 644 $(STAGING)/lib/pkgconfig/libcrypto.pc $(PREFIX)/lib/pkgconfig/libcrypto.pc
	@install -d $(PREFIX)/include/openssl
	@cp $(STAGING)/include/openssl/* $(PREFIX)/include/openssl/
	@chmod 644 $(PREFIX)/include/openssl/*.h
	@cd $(PREFIX)/lib && ln -f -s libssl.so.1.0.0 libssl.so
	@cd $(PREFIX)/lib && ln -f -s libcrypto.so.1.0.0 libcrypto.so
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX) '/^+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cat $(PREFIX)/var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
	@rm -rf $(PREFIX)/include/openssl
