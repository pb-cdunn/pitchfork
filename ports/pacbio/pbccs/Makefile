include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = pbccs
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch:
	@test -d $(_WRKSRC) || git clone $($(_NAME)_REPO) $(_WRKSRC)
	@test "$($(_NAME)_VERSION)" && (cd $(_WRKSRC) && git checkout $($(_NAME)_VERSION)) || true
	@test -d $(_WRKSRC)/ConsensusCore2 || git clone https://github.com/PacificBiosciences/ConsensusCore2.git $(_WRKSRC)/ConsensusCore2
	@test "$(ConsensusCore2_VERSION)" && (cd $(_WRKSRC)/ConsensusCore2 && git checkout $(ConsensusCore2_VERSION)) || true
	@test -d $(_WRKSRC)/seqan || git clone https://github.com/PacificBiosciences/seqan.git $(_WRKSRC)/seqan
do-config: | $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile:
	mkdir -p $(_WRKSRC)/_build && \
	cd $(_WRKSRC)/_build  && \
        cmake \
              -DPBBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPacBioConsensus_RootDir=$(_WRKSRC)/ConsensusCore2 \
              -DBoost_INCLUDE_DIRS=$(PREFIX)/include \
              -DSEQAN_INCLUDE_DIRS=$(_WRKSRC)/seqan/include \
              -DHTSLIB_ROOTDIR=$(PREFIX)/src/htslib \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DCMAKE_SKIP_BUILD_RPATH=TRUE \
            ..
do-build:
	@$(MAKE) -C $(_WRKSRC)/_build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cd $(_WRKSRC)/bin && tar cf - ccs task_pbccs_ccs | tar xf - -C $(PREFIX)/bin
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
