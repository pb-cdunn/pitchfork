include ../../../mk/pitchfork.mk

# Local variables
_NAME   = samtools-0.1.20
_URL    = https://github.com/samtools/samtools/archive
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = 0.1.20.tar.gz

# Local works
do-extract: $(_WRKSRC)
$(_WRKSRC): | do-fetch
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
ifeq ($(OPSYS),Darwin)
	cat patch-01 | (cd $(_WRKSRC) && patch -p0)
	$(SED) -i -e 's/-rdynamic//g' $(_WRKSRC)/Makefile $(_WRKSRC)/htslib-*/configure*
endif
do-fetch: $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
old-do-config: $(_WRKSRC)/config.log
$(_WRKSRC)/config.log: | do-extract
	(cd $(_WRKSRC) && \
         CFLAGS="-I$(_WRKSRC)/htslib-1.3 $(CFLAGS)" ./configure --prefix=$(PREFIX) \
                     --with-htslib=$(_WRKSRC)/htslib-1.3 \
                     --without-curses) >& config.log || $(PFHOME)/bin/diewith config.log
do-build: $(_WRKSRC)/samtools
$(_WRKSRC)/samtools: | do-config
	$(MAKE) CC=$(CC) CFLAGS="-g -Wall -O2 $(CFLAGS)" -C $(_WRKSRC) >& build.log || $(PFHOME)/bin/diewith build.log
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
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
