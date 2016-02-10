include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = pbccs
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC) $(_WRKSRC)/ConsensusCore2
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
	cd $(_WRKSRC)/ConsensusCore2 && $(GIT) checkout $(ConsensusCore2_VERSION)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
$(_WRKSRC)/ConsensusCore2: | $(_WRKSRC)
	$(GIT) clone https://github.com/PacificBiosciences/ConsensusCore2.git $@
do-config: | $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile:
	mkdir -p $(_WRKSRC)/_build && \
	cd $(_WRKSRC)/_build  && \
        $(CMAKE) \
              -DPBBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPacBioConsensus_RootDir=$(_WRKSRC)/ConsensusCore2 \
              -DBoost_INCLUDE_DIRS=$(PREFIX)/include \
              -DSEQAN_INCLUDE_DIRS=$(PREFIX)/include \
              -DHTSLIB_ROOTDIR=$(PREFIX)/src/htslib \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DCMAKE_SKIP_BUILD_RPATH=TRUE \
            ..
do-build:
	$(MAKE) -C $(_WRKSRC)/_build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/bin
	rsync -ax $(_WRKSRC)/bin/ $(STAGING)/$(_NAME)/bin/
	rsync -ax $(_WRKSRC)/lib/ $(STAGING)/$(_NAME)/lib/
	rsync -ax $(_WRKSRC)/include/ $(STAGING)/$(_NAME)/include/
	rsync -ax $(_WRKSRC)/third-party/ $(STAGING)/$(_NAME)/src/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
