include ../../../mk/config.mk

# Local variables
_NAME   = libressl-2.2.5
_URL    = http://ftp.openbsd.org/pub/OpenBSD/LibreSSL
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS)

# Local works
do-extract: do-fetch wscheck | $(_WRKSRC)/configure
$(_WRKSRC)/configure:
	@tar zxf $(_NAME).tar.gz -C $(WORKSPACE)
do-fetch: | $(_NAME).tar.gz
	@$(MD5SUM) -c MD5SUM
$(_NAME).tar.gz:
	@$(CURL) -O -L $(_URL)/$(_NAME).tar.gz
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@test -e $(_WRKSRC)/config.log \
     || (cd $(_WRKSRC) && CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: do-config
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -j1 -C $(_WRKSRC) 2>&1 | tee build.log \
        | $(PFHOME)/bin/activity
do-install: do-build pfcheck
	@$(MAKE) $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
