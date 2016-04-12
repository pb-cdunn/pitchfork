include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME             = pbccs
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
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
	rsync -ax $(_WRKSRC)/bin/ $(PREFIX)/bin/
	rsync -ax $(_WRKSRC)/lib/ $(PREFIX)/lib/
	rsync -ax $(_WRKSRC)/include/ $(PREFIX)/include/
	cd $(_WRKSRC) && find bin lib include ! -type d > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
