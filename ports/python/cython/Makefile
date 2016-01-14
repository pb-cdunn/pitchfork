include ../../../mk/config.mk

# Local variables
_NAME   = Cython-0.23.4
_URL    = http://cython.org/release
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: do-fetch wscheck | $(_WRKSRC)
$(_WRKSRC):
	@tar zxf $(_NAME).tar.gz -C $(WORKSPACE)
do-fetch: | $(_NAME).tar.gz
	@$(MD5SUM) -c MD5SUM
$(_NAME).tar.gz:
	@$(CURL) -O -L $(_URL)/$@
do-config: do-extract
do-build: do-config
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@pip install $(_WRKSRC)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
