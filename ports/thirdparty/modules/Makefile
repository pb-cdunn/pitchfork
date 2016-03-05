include ../../../mk/pitchfork.mk

# Local variables
_NAME            = modules-3.2.10
_URL             = https://prdownloads.sourceforge.net/modules
_FILE            = modules-3.2.10.tar.gz
_WRKSRC          = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	(cd $(_WRKSRC) && export CPPFLAGS="-DUSE_INTERP_ERRORLINE" && \
        ./configure --prefix=$(PREFIX) --with-tcl=$(PREFIX)/lib 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity || exit
do-build: | $(_WRKSRC)/modulecmd
$(_WRKSRC)/modulecmd:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity || exit
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	find $(PREFIX)/Modules|awk -F '$(PREFIX)/' '{print $$2}'|sort -r > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -f build.log install.log
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	$(MAKE) -C $(_WRKSRC) distclean
	rm -f $(_WRKSRC)/config.log config.log
do-flush:
	rm -rf $(_WRKSRC) || true
