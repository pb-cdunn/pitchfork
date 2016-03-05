include ../../../mk/pitchfork.mk

# Local variables
_NAME            = gmap-2015-12-31
_URL             = http://research-pub.gene.com/gmap/src
_FILE            = gmap-gsnap-2015-12-31.v7.tar.gz
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
	(cd $(_WRKSRC) && \
        ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity || exit
do-build: | $(_WRKSRC)/src/gmap
$(_WRKSRC)/src/gmap:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME)|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}'|sort -r > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -f build.log install.log
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	$(MAKE) -C $(_WRKSRC) distclean
	rm -f $(_WRKSRC)/config.log config.log
do-flush:
	rm -rf $(_WRKSRC) || true
