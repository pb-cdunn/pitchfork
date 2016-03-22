include ../../../mk/pitchfork.mk

# Local variables
_NAME   = virtualenv-13.1.2
_URL    = https://pypi.python.org/packages/source/v/virtualenv
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)
PYTHON  = /usr/bin/python
ifneq ($(origin HAVE_PYTHON),undefined)
    PYTHON := $(shell ../../../bin/chkSysPython $(HAVE_PYTHON))
    $(info $(PYTHON))
endif

# Local works
do-extract: | $(_WRKSRC)/virtualenv.py
$(_WRKSRC)/virtualenv.py:
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	$(PYTHON) $(_WRKSRC)/virtualenv.py $(PREFIX)
	$(PIP) install -U pip
	cd $(PREFIX) && \
        find lib/python* include/python* bin/pip* bin/python* \
             bin/activate* bin/easy_install* bin/wheel | sort -r \
        > $@
ifeq ($(OPSYS),Darwin)
	cp -a $(PYTHON) $(PREFIX)/bin/
endif
