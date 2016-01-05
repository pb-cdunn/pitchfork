include ../../../mk/config.mk

# Local variables
_NAME            = pbccs
_URL             = https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)

_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), consider doing yum install gcc-c++"))

export CC
export CXX

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -d $(_WRKSRC) || git clone $(_URL) $(_WRKSRC)
	@test -d $(_WRKSRC)/ConsensusCore2 || git clone https://github.com/PacificBiosciences/ConsensusCore2.git $(_WRKSRC)/ConsensusCore2 
	@test -d $(_WRKSRC)/seqan || git clone https://github.com/PacificBiosciences/seqan.git $(_WRKSRC)/seqan
do-config: do-extract $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile:
	mkdir -p $(_WRKSRC)/_build && \
	cd $(_WRKSRC)/_build  && \
        cmake -DCMAKE_BUILD_TYPE=Release \
              -DPBBAM_LIBRARIES=$(PREFIX)/lib \
              -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPacBioConsensus_RootDir=$(_WRKSRC)/ConsensusCore2 \
              -DBoost_INCLUDE_DIRS=$(PREFIX)/include/boost \
              -DSEQAN_INCLUDE_DIRS=$(_WRKSRC)/seqan/include \
              -DHTSLIB_ROOTDIR=$(PREFIX)/src/htslib \
            ..
do-build: do-config
	@$(MAKE) -C $(_WRKSRC)/_build
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cd $(_WRKSRC) && tar cf - blasr | tar xf - -C $(PREFIX)/bin
	@cd $(_WRKSRC)/utils && tar cf - pls2fasta sawriter | tar xf - -C $(PREFIX)/bin
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
