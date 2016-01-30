include ../../../mk/config.mk

# Local variables
_NAME            = pbreports
_URL             = https://github.com/PacificBiosciences/pbreports
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch:
	@test -d $(_WRKSRC) || $(GIT) clone $(_URL) $(_WRKSRC)
	@test $($(_NAME)_VERSION) && (cd $(_WRKSRC) && git checkout $($(_NAME)_VERSION)) || true
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@$(PIP) install --no-deps $(_WRKSRC)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
