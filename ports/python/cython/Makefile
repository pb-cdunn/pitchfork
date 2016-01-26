include ../../../mk/config.mk

# Local variables
_NAME   = Cython-0.23.4
_URL    = http://cython.org/release
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	@tar zxf $(_NAME).tar.gz -C $(WORKSPACE)
do-fetch: | $(_NAME).tar.gz
	@$(MD5SUM) -c MD5SUM
$(_NAME).tar.gz:
	@$(CURL) -O -L $(_URL)/$@
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@$(PIP) install $(_WRKSRC)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
