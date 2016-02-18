include ../../../mk/pitchfork.mk

# Local variables
_NAME   = samtools-1.3
_URL    = https://github.com/samtools/samtools/releases/download/1.3
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = $(_NAME).tar.bz2

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar jxf $(_FILE) -C $(WORKSPACE)
ifeq ($(OPSYS),Darwin)
	cat patch-01 | (cd $(_WRKSRC) && patch -p0)
	$(SED) -i -e 's/-rdynamic//g' $(_WRKSRC)/Makefile $(_WRKSRC)/htslib-*/configure*
endif
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	(cd $(_WRKSRC) && \
         CFLAGS="-I$(_WRKSRC)/htslib-1.3 $(CFLAGS)" LDFLAGS=$(LDFLAGS) ./configure --prefix=$(PREFIX) \
                     --with-htslib=$(_WRKSRC)/htslib-1.3 \
                     --without-curses 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/samtools
$(_WRKSRC)/samtools:
	$(MAKE) CC=$(CC) CFLAGS="-g -Wall -O2 $(CFLAGS)" -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
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
