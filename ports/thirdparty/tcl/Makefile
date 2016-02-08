include ../../../mk/config.mk

# Local variables
_NAME            = tcl8.6.4
_URL             = https://prdownloads.sourceforge.net/tcl
_FILE            = tcl-core8.6.4-src.tar.gz
_WRKSRC          = $(WORKSPACE)/$(_NAME)

export CFLAGS
export LDFLAGS

# Local works
do-fetch: | $(_FILE)
$(_FILE):
	@$(CURL) -L -O $(_URL)/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	@$(MD5SUM) -c MD5SUM || exit
	@tar zxf $(_FILE) -C $(WORKSPACE)
do-config: | $(_WRKSRC)/unix/config.log
$(_WRKSRC)/unix/config.log:
	@(cd $(_WRKSRC)/unix && \
        ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/unix/libtcl8.6.$(DYLIB)
$(_WRKSRC)/unix/libtcl8.6.$(DYLIB):
	@$(MAKE) -C $(_WRKSRC)/unix 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@$(MAKE) -C $(_WRKSRC)/unix install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)/ '{print $$2}'|sort -r > $@
do-clean:
	@rm -rf $(_WRKSRC) || true
