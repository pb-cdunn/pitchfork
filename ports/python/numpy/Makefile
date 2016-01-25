include ../../../mk/config.mk

# FC check
include ../../../mk/chkfc.mk

# Local variables
_NAME   = numpy-1.10.2
_URL    = https://pypi.python.org/packages/source/n/numpy
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract:
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch:
	@test -e $(_FILE) || curl -L -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
do-config:
	@test -e $(_WRKSRC)/site.cfg || $(SED) -e 's@_PREFIX_@$(PREFIX)@g' site.cfg.template > $(_WRKSRC)/site.cfg
do-build: ;
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
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
