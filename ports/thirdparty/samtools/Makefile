include ../../../mk/config.mk

# Local variables
_NAME   = samtools-1.3
_URL    = https://github.com/samtools/samtools/releases/download/1.3
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: do-fetch
	@test -d $(_WRKSRC) || tar jxf $(_NAME).tar.bz2 -C $(WORKSPACE)
do-fetch: wscheck
	@test -e $(_NAME).tar.bz2 || $(CURL) -L -O $(_URL)/$(_NAME).tar.bz2
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
do-config: do-extract
	@cd $(_WRKSRC) && test -e config.log || CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(STAGING)/$(_NAME)
do-build: do-config
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC) >& build.log
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install >& install.log
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
