include ../../../mk/pitchfork.mk

# Local variables
_NAME             = seqan
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	$(GIT) -C $(_WRKSRC) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	cd $(_WRKSRC) && tar cf - include|tar xf - -C $(PREFIX)/
	cd $(_WRKSRC) && find include ! -type d > $@
do-clean:
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
