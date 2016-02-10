include ../../../mk/pitchfork.mk

# Local variables
_NAME            = Python-2.7.10
_URL             = https://www.python.org/ftp/python/2.7.10
_FILE            = Python-2.7.10.tgz
_WRKSRC          = $(WORKSPACE)/$(_NAME)
_CONFIGURE_ARGS  = --prefix=$(PREFIX)
_CONFIGURE_ARGS += --enable-unicode=ucs4
_CFLAGS          = $(CFLAGS)
_CFLAGS         += -I$(PREFIX)/include/ncurses

# Local works
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
	$(SED) -i -e "s|@@PREFIX@@|$(PREFIX)|g" $(_WRKSRC)/Lib/cgi.py $(_WRKSRC)/Lib/ctypes/macholib/dyld.py
	$(SED)    -e "s|@@PREFIX@@|$(PREFIX)|g" patch-01 | (cd $(_WRKSRC) && patch -p0)
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	(cd $(_WRKSRC) && \
          CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure $(_CONFIGURE_ARGS) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/python.exe
$(_WRKSRC)/python.exe:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) prefix=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
do-clean:
	rm -rf $(_WRKSRC) || true
