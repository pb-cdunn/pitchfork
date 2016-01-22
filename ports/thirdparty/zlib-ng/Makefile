include ../../../mk/config.mk

# Local variables
_NAME    = zlib-1.2.8
_URL     = https://github.com/Dead2/zlib-ng
_REV     = 76a02fa8c312cc9d2bfc4f9d76c31a67e38d9199
_WRKSRC  = $(WORKSPACE)/$(_NAME)
_CFLAGS  = $(CFLAGS)
_CFLAGS += -march=native -O3

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone $(_URL) $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	@cd $(_WRKSRC) && test -e configure.log || CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(STAGING)/$(_NAME)
do-build: do-config
	@test -f $(_WRKSRC)/configure.log || exit 1
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - *|tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
