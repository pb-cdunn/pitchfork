include ../../../mk/pitchfork.mk

ifeq ($(origin GHTOKEN),undefined)
    $(error "You need to set GHTOKEN")
endif

# Local variables
_NAME             = pbchimera
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
	rsync -avx $($(_NAME)_REPO)/ $(_WRKSRC)/
endif
do-config: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	cd $(_WRKSRC)/_build && \
        $(CMAKE) \
            -DSEQAN_IncludeDir=$(PREFIX)/include \
            -DCMAKE_CXX_FLAGS="-L$(PREFIX)/lib" \
            ..
do-build: $(_WRKSRC)/_build/src/ChimeraLabeler
$(_WRKSRC)/_build/src/ChimeraLabeler: | do-config
	cd $(_WRKSRC)/_build && $(MAKE) VERBOSE=1
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/bin
	cp -a $(_WRKSRC)/_build/src/ChimeraLabeler $(STAGING)/$(_NAME)/bin/
	rsync -ax $(_WRKSRC)/include/ $(STAGING)/$(_NAME)/include/
	rsync -aKx $(STAGING)/$(_NAME)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}'|grep -v '^$$'|sort -r > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
