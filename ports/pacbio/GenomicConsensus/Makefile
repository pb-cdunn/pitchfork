include ../../../mk/pitchfork.mk

# Local variables
_NAME            = GenomicConsensus
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps --verbose $(_WRKSRC)/
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F '$(STAGING)/$(_NAME)$(PREFIX)/' '{print $$2}'|grep -v '^$$'|sort -r > $@
do-clean:
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && 20 20 12 61 79 80 81 98 33 100 204 395 398 399GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
