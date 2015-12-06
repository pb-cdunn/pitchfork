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
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC)
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install
	@install -m 644 $(STAGING)/include/zlib.h        $(PREFIX)/include/zlib.h
	@install -m 644 $(STAGING)/include/zconf.h       $(PREFIX)/include/zconf.h
	@install -m 755 $(STAGING)/lib/libz.so.1.2.8     $(PREFIX)/lib/libz.so.1.2.8
	@install -m 644 $(STAGING)/lib/pkgconfig/zlib.pc $(PREFIX)/lib/pkgconfig/zlib.pc
	@cd $(PREFIX)/lib && ln -f -s libz.so.1.2.8 libz.so.1
	@cd $(PREFIX)/lib && ln -f -s libz.so.1     libz.so
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX) '/^+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cat $(PREFIX)/var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
