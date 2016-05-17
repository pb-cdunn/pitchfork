include ../../../mk/pitchfork.mk

ifeq ($(origin GHTOKEN),undefined)
    $(error "You need to set GHTOKEN")
endif

# Local variables
_NAME             = pblaa
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
do-config: $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	cd $(_WRKSRC)/_build && \
        $(CMAKE) \
            -DZLIB_INCLUDE_DIRS=$(ZLIB_ROOT)/include \
            -DZLIB_LIBRARIES=$(ZLIB_ROOT)/lib/libz.$(DYLIB) \
            -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib/include \
            -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/lib/libhts.a \
            -DPacBioBAM_IncludeDir=$(PREFIX)/include \
            -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include \
            -DPBBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
            -DSEQAN_INCLUDE_DIRS=$(PREFIX)/include \
            -DSEQAN_RootDir=$(PREFIX) \
            -DPacBioConsensus_IncludeDir=$(PREFIX)/include \
            -DPBCONSENSUS_INCLUDE_DIRS=$(PREFIX)/include \
            -DPBCONSENSUS_LIBRARIES=$(PREFIX)/lib/libpbconsensus.$(DYLIB) \
            -DPacBioCCS_IncludeDir=$(PREFIX)/include \
            -DPBCCS_INCLUDE_DIRS=$(PREFIX)/include \
            -DPBCCS_LIBRARIES=$(PREFIX)/lib/libpbccs.a \
            -DPacBioSparse_IncludeDir=$(PREFIX)/include \
            -DPacBioChimera_IncludeDir=$(PREFIX)/include \
            -DBoost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
            -DPacBioConsensus_ThirdPartyDir=$(PREFIX)/src \
            -DPacBioCCS_ThirdPartyDir=$(PREFIX)/src \
            ..
do-build: $(_WRKSRC)/bin/laa
$(_WRKSRC)/bin/laa: | do-config
	cd $(_WRKSRC)/_build && $(MAKE)
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rsync -ax $(_WRKSRC)/bin/ $(PREFIX)/bin/
	rsync -ax $(_WRKSRC)/include/ $(PREFIX)/include/
	cd $(_WRKSRC) && find bin include|grep -v '^$$'|sort -r > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
