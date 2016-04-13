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
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	ln -s $($(_NAME)_REPO) $(_WRKSRC)
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	$(PIP) install --no-deps $(_WRKSRC)/
	rm -rf lib/python2.7/site-packages/bin
	install -m 755 $(_WRKSRC)/bin/copyIpdSummaryDataset.py $(PREFIX)/bin/
	install -m 755 $(_WRKSRC)/bin/writeSummaryToCmp.py $(PREFIX)/bin/
	cd $(PREFIX) && \
        find lib/python2.7/site-packages/kineticsTools* \
             bin/summarizeModifications \
             bin/ipdSummary \
             bin/copyIpdSummaryDataset.py \
             bin/writeSummaryToCmp.py \
        | grep -v '^$$'|sort -r > $@
do-clean:
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
