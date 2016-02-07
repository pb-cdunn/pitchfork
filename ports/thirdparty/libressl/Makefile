include ../../../mk/config.mk

# Local variables
_NAME   = libressl-2.2.5
_URL    = http://ftp.openbsd.org/pub/OpenBSD/LibreSSL
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS)
_FILE   = $(_NAME).tar.gz

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	@$(MD5SUM) -c MD5SUM || exit
	@tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	@$(CURL) -L -O $(_URL)/$@
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	@(cd $(_WRKSRC) && CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/ssl/.libs/libssl.$(DYLIB)
$(_WRKSRC)/ssl/.libs/libssl.$(DYLIB):
	@$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
do-clean:
	@rm -rf $(_WRKSRC) || true
