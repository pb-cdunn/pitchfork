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
	@$(CURL) -L -O $(_URL)/$@
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@$(PYTHON) $(_WRKSRC)/virtualenv.py $(PREFIX)
	@$(PIP) install -U pip
	@cd $(PREFIX) && \
        find lib/python* include/python* bin/pip* bin/python* \
             bin/activate* bin/easy_install* bin/wheel | sort -r \
        > $(PREFIX)/var/pkg/$(_NAME)
