include ../../../mk/pitchfork.mk

# Local variables
_NAME   = swig-3.0.8
_URL    = https://prdownloads.sourceforge.net/swig
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = $(_NAME).tar.gz

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE) pcre-8.38.tar.gz
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
pcre-8.38.tar.gz:
	$(CURL) -L -O https://prdownloads.sourceforge.net/pcre/pcre-8.38.tar.gz
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	cp pcre-8.38.tar.gz $(_WRKSRC)/
	set -o pipefail && (cd $(_WRKSRC) && \
        Tools/pcre-build.sh && \
        CFLAGS="$(CFLAGS)" \
        CC="$(CC) -L$(PREFIX)/lib" \
        CXX="$(CXX) -L$(PREFIX)/lib" \
        LDFLAGS="$(LDFLAGS)" \
          ./configure \
            --prefix=$(PREFIX) \
            --without-java \
            --without-lua \
            --without-perl5 \
            --without-php \
            --without-ruby \
            --without-tcl \
            --without-r \
        2>&1) \
        | tee -a config.log | $(PFHOME)/bin/activity
do-build:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
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
