include ../../../mk/config.mk
include ../../../mk/checkautoconf.mk
include ../../../mk/checkautomake.mk

# Local variables
_NAME   = libressl-2.3.1
_URL    = https://github.com/libressl-portable/portable
_REV    = 7180bed3bb78144e19c1dfe3180b0dd2f426bf60
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS)

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone -o $(_REV) $(_URL) $(_WRKSRC)
	@test -e $(_WRKSRC)/configure || (cd $(_WRKSRC) && ./autogen.sh)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@cd $(_WRKSRC) && test -e config.log || CFLAGS="$(_CFLAGS)" ./configure --prefix=$(STAGING)
do-build: do-config
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install
	@install -m 755 $(STAGING)/lib/libtls.so.9.0.1        $(PREFIX)/lib/libtls.so.9.0.1
	@install -m 755 $(STAGING)/lib/libssl.so.37.0.1       $(PREFIX)/lib/libssl.so.37.0.1
	@install -m 755 $(STAGING)/lib/libcrypto.so.36.0.1    $(PREFIX)/lib/libcrypto.so.36.0.1
	@install -m 644 $(STAGING)/lib/pkgconfig/libtls.pc    $(PREFIX)/lib/pkgconfig/libtls.pc
	@install -m 644 $(STAGING)/lib/pkgconfig/libssl.pc    $(PREFIX)/lib/pkgconfig/libssl.pc
	@install -m 644 $(STAGING)/lib/pkgconfig/libcrypto.pc $(PREFIX)/lib/pkgconfig/libcrypto.pc
	@install -d $(PREFIX)/include/openssl
	@cp $(STAGING)/include/openssl/* $(PREFIX)/include/openssl/
	@chmod 644 $(PREFIX)/include/openssl/*.h
	@cd $(PREFIX)/lib && ln -f -s libtls.so.9.0.1     libtls.so
	@cd $(PREFIX)/lib && ln -f -s libtls.so.9.0.1     libtls.so.9
	@cd $(PREFIX)/lib && ln -f -s libssl.so.37.0.1    libssl.so
	@cd $(PREFIX)/lib && ln -f -s libssl.so.37.0.1    libssl.so.37
	@cd $(PREFIX)/lib && ln -f -s libcrypto.so.36.0.1 libcrypto.so
	@cd $(PREFIX)/lib && ln -f -s libcrypto.so.36.0.1 libcrypto.so.36
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX)/ '/^+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -rf $(PREFIX)/include/openssl
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
