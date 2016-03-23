include ../../../mk/pitchfork.mk

# Local variables
_NAME   = samtools-0.1.20
_URL    = https://github.com/samtools/samtools/archive
_WRKSRC = $(WORKDIR)/$(_NAME)
_FILE   = 0.1.20.tar.gz

CFLAGS += -I$(PREFIX)/include/ncurses
export CFLAGS

# Local works
do-extract: $(_WRKSRC)
$(_WRKSRC): | do-fetch
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKDIR)
do-fetch: $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-build: $(_WRKSRC)/samtools
$(_WRKSRC)/samtools: | do-config
	$(MAKE) CC=$(CC) CFLAGS='-g -Wall -O2 $(CFLAGS)' -C $(_WRKSRC) samtools >& build.log || $(PFHOME)/bin/diewith build.log
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/share/man/man1 $(STAGING)/$(_NAME)/bin
	cp -a $(_WRKSRC)/samtools $(STAGING)/$(_NAME)/bin/
	cp -a $(_WRKSRC)/samtools.1 $(STAGING)/$(_NAME)/share/man/man1/
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
