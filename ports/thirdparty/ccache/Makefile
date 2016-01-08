include ../../../mk/config.mk

# Local variables
_NAME   = ccache-3.2.4
_URL    = https://www.samba.org/ftp/ccache
_FILE	= $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -e $(_FILE) || curl -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@test -e $(_WRKSRC)/config.log \
     || (cd $(_WRKSRC) && ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) | tee config.log | $(PFHOME)/bin/activity
do-build: do-config
	@test -f $(_WRKSRC)/config.log
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install >& install.log
	@cd $(STAGING)/$(_NAME) && tar cf - *|tar xf - -C $(PREFIX)
	@cd $(PREFIX)/bin && ln -s ccache `basename $(CC)`
	@cd $(PREFIX)/bin && ln -s ccache `basename $(CXX)`
	@cd $(PREFIX)/bin && ln -s ccache `basename $(FC)`
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
