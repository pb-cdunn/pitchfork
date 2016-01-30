include ../../../mk/config.mk

# Local variables
_NAME   = virtualenv-13.1.2
_URL    = https://pypi.python.org/packages/source/v/virtualenv
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)
PYTHON  = /usr/bin/python
ifneq ($(origin PYVE),undefined)
    PYTHON := $(shell ../../../bin/chkSysPython $(PYVE))
    $(info $(PYTHON))
endif

# Local works
do-extract: | $(_WRKSRC)/virtualenv.py
$(_WRKSRC)/virtualenv.py:
	@tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
	@$(MD5SUM) -c MD5SUM
$(_FILE):
	@curl -L -O $(_URL)/$(_FILE)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@$(PYTHON) $(_WRKSRC)/virtualenv.py $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
