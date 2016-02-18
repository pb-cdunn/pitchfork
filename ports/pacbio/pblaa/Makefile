include ../../../mk/pitchfork.mk

ifeq ($(origin GHTOKEN),undefined)
    $(error "You need to set GHTOKEN")
endif

# Local variables
_NAME            = pblaa
$(_NAME)_REPO   ?= https://$(GHTOKEN)@github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
do-config: | $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile:
	mkdir -p $(_WRKSRC)/_build && cd $(_WRKSRC)/_build && \
        cmake \
            -DZLIB_INCLUDE_DIRS=$(ZLIB_ROOT)/include \
            -DZLIB_LIBRARIES=$(ZLIB_ROOT)/lib/libz.$(DYLIB) \
            -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib/include \
            -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/lib/libhts.$(DYLIB) \
            -DPacBioBAM_IncludeDir=$(PREFIX)/include \
            -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include \
            -DPBBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
            -DSEQAN_INCLUDE_DIRS=$(PREFIX)/include \
            -DSEQAN_RootDir=$(PREFIX) \
            -DPacBioConsensus_IncludeDir=$(PREFIX)/include \
            -DPBCONSENSUS_INCLUDE_DIRS=$(PREFIX)/include \
            -DPBCONSENSUS_LIBRARIES=$(PREFIX)/lib/libpbconsensus.a \
            -DPacBioConsensus_ThirdPartyDir=$(PREFIX)/src \
            -DPacBioCCS_IncludeDir=$(PREFIX)/include \
            -DPBCCS_INCLUDE_DIRS=$(PREFIX)/include \
            -DPBCCS_LIBRARIES=$(PREFIX)/lib/libpbccs.a \
            -DPacBioCCS_ThirdPartyDir=$(PREFIX)/src \
            -DPacBioSparse_IncludeDir=$(PREFIX)/include \
            -DPacBioChimera_IncludeDir=$(PREFIX)/include \
            -DBoost_INCLUDE_DIRS=$(BOOST_INC) \
            ..
do-build: | $(_WRKSRC)/bin/laa
$(_WRKSRC)/bin/laa:
	cd $(_WRKSRC)/_build && $(MAKE)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	rsync -ax $(_WRKSRC)/bin/ $(STAGING)/$(_NAME)/bin/
	rsync -ax $(_WRKSRC)/include/ $(STAGING)/$(_NAME)/include/
	rsync -ax $(_WRKSRC)/third-party/ $(STAGING)/$(_NAME)/src/
	rsync -aKx $(STAGING)/$(_NAME)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}'|grep -v '^$$'|sort -r > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
