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
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-config: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	cd $(_WRKSRC)/_build && \
        $(CMAKE) \
            -DSEQAN_IncludeDir=$(PREFIX)/include \
            -DCMAKE_CXX_FLAGS="-L$(PREFIX)/lib" \
            -DCMAKE_C_COMPILER_LAUNCHER=ccache \
            -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
            ..
do-build: $(_WRKSRC)/_build/src/ChimeraLabeler
$(_WRKSRC)/_build/src/ChimeraLabeler: | do-config
	cd $(_WRKSRC)/_build && $(MAKE) VERBOSE=1
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	cp -a $(_WRKSRC)/_build/src/ChimeraLabeler $(PREFIX)/bin/
	rsync -ax --exclude '*.h.in' $(_WRKSRC)/include/ $(PREFIX)/include/
	cd $(_WRKSRC) && find include|grep -v -e '^$$' -e '.h.in$$' |sort -r > $@
	cd $(PREFIX) && find bin/ChimeraLabeler|grep -v '^$$'|sort -r >> $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
