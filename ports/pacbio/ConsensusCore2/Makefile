include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = ConsensusCore2
$(_NAME)_REPO   ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
DEVOPT =
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
DEVOPT = -e
endif
do-config: $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile: | do-fetch
	mkdir -p $(_WRKSRC)/_build
	mkdir -p $(_WRKSRC)/_pitchforktmp
	cd $(_WRKSRC)/_build \
     && $(CMAKE) \
          -DCMAKE_BUILD_TYPE=Release \
          -DBoost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
        ..
do-build:
	cd $(_WRKSRC)/_build && $(MAKE)
	cd $(_WRKSRC)/_pitchforktmp && $(AR) x ../lib/libpbconsensus.a
	cd $(_WRKSRC)/_pitchforktmp && $(CXX) -shared *.o -o ../lib/libpbconsensus.$(DYLIB)
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	    CMAKE_COMMAND=$(CMAKE) \
        Boost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
                   VERBOSE=1 \
        $(PIP) install --verbose --upgrade --no-deps $(DEVOPT) $(_WRKSRC)/
	rsync -ax $(_WRKSRC)/lib/ $(PREFIX)/lib/
	rsync -ax --exclude Version.h.in $(_WRKSRC)/include/ $(PREFIX)/include/
	@echo pip uninstall $(_NAME) > $@
	cd $(_WRKSRC) && find lib include | grep -v -e '^$$' -e Version.h.in | sort -r >> $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/_build clean
	rm -rf "$(_WRKSRC)/_pitchforktmp"
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
