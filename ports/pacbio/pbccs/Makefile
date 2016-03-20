include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME             = pbccs
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKSPACE)/$(_NAME)
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
do-config: $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	cd $(_WRKSRC)/_build  && \
        $(CMAKE) \
              -DPBBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPBCONSENSUS_INCLUDE_DIRS=$(PREFIX)/include \
              -DPBCONSENSUS_LIBRARIES=$(PREFIX)/lib/libpbconsensus.a \
              -DBoost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
              -DSEQAN_INCLUDE_DIRS=$(PREFIX)/include \
              -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib/include \
              -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/lib/libhts.a \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DCMAKE_SKIP_BUILD_RPATH=FALSE \
              -DZLIB_INCLUDE_DIRS=$(ZLIB_ROOT)/include \
              -DZLIB_LIBRARIES=$(ZLIB_ROOT)/lib/libz.$(DYLIB) \
              -DGMOCK_RootDir=$(PREFIX)/src/gmock \
            ..
do-build:
	$(MAKE) -C $(_WRKSRC)/_build
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/bin
	rsync -ax $(_WRKSRC)/bin/ $(STAGING)/$(_NAME)/bin/
	rsync -ax $(_WRKSRC)/lib/ $(STAGING)/$(_NAME)/lib/
	rsync -ax $(_WRKSRC)/include/ $(STAGING)/$(_NAME)/include/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
