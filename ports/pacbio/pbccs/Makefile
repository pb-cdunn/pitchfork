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
	$(GIT) -C $(_WRKSRC) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-config: $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	mkdir -p $(_WRKSRC)/_pitchforktmp
	cd $(_WRKSRC)/_build  && \
        $(CMAKE) \
              -DPBBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DPBBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPBCONSENSUS_INCLUDE_DIRS=$(PREFIX)/include \
              -DPBCONSENSUS_LIBRARIES=$(PREFIX)/lib/libpbconsensus.$(DYLIB) \
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
ifeq ($(OPSYS),Darwin)
	cd $(_WRKSRC)/_pitchforktmp && $(CXX) $(CXXFLAGS) -shared ../lib/libpbccs.a -o ../lib/libpbccs.$(DYLIB)
else
	cd $(_WRKSRC)/_pitchforktmp && $(AR) x ../lib/libpbccs.a
	cd $(_WRKSRC)/_pitchforktmp && $(CXX) $(CXXFLAGS) -shared *.o -o ../lib/libpbccs.$(DYLIB)
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rsync -ax $(_WRKSRC)/bin/ $(PREFIX)/bin/
	rsync -ax $(_WRKSRC)/lib/ $(PREFIX)/lib/
	rsync -ax --exclude Version.h.in $(_WRKSRC)/include/ $(PREFIX)/include/
	cd $(_WRKSRC) && find bin lib include | grep -v Version.h.in > $@
do-clean:
	rm -fr $(_WRKSRC)/_build
	rm -fr $(_WRKSRC)/_pitchforktmp
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
