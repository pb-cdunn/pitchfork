include ../../../mk/pitchfork.mk

ifeq ($(origin GHTOKEN),undefined)
    $(error "You need to set GHTOKEN")
endif

# Local variables
_NAME             = pbsparse
$(_NAME)_REPO    ?= https://$(GHTOKEN)@github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	rsync -aKx $(_WRKSRC)/include/pacbio/ $(PREFIX)/include/pacbio/
	find $(PREFIX)/include/pacbio/sparse|awk -F '$(PREFIX)/' '{print $$2}'|grep -v '^$$'|sort -r > $@
do-flush:
	rm -rf $(_WRKSRC)
