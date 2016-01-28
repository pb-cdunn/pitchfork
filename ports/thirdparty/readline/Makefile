include ../../../mk/config.mk

# Local variables
_NAME   = readline-6.3p8
_URL    = http://git.savannah.gnu.org/r/readline.git
_REV    = a73b98f779b388a5d0624e02e8bb187246e3e396
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFLAGS = $(CFLAGS)

# Local works
do-extract:
do-fetch:
	@test -d $(_WRKSRC) || $(GIT) clone $(_URL) $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config: | $(_WRKSRC)/config.log
$(_WRKSRC)/config.log:
	@(cd $(_WRKSRC) && CFLAGS="$(_CFLAGS)" LDFLAGS="$(LDFLAGS)" ./configure --prefix=$(STAGING)/$(_NAME) 2>&1) \
        | tee config.log | $(PFHOME)/bin/activity
do-build:
	@test -e $(PREFIX)/var/pkg/$(_NAME) || $(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	@cd $(STAGING)/$(_NAME) && tar cf - *|tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-clean:
	@rm -rf $(_WRKSRC) || true
