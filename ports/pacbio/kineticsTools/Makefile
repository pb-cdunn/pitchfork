include ../../../mk/pitchfork.mk

# Local variables
_NAME             = kineticsTools
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	$(GIT) -C $(_WRKSRC) checkout $($(_NAME)_VERSION)
DEVOPT =
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
DEVOPT = -e
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	$(PIP) install --no-deps $(DEVOPT) $(_WRKSRC)/
	rm -rf $(PREFIX)/lib/python2.7/site-packages/bin
	install -m 755 $(_WRKSRC)/bin/copyIpdSummaryDataset.py $(PREFIX)/bin/
	install -m 755 $(_WRKSRC)/bin/writeSummaryToCmp.py $(PREFIX)/bin/
	@echo pip uninstall $(_NAME) > $@
do-clean:
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
