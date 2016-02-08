include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = ConsensusCore2
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
do-config: | $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile:
	mkdir -p $(_WRKSRC)/_build
	cd $(_WRKSRC)/_build \
     && $(CMAKE) \
          -DCMAKE_BUILD_TYPE=Release \
          -DBoost_INCLUDE_DIRS=$(PREFIX)/include \
        ..
do-build:
	cd $(_WRKSRC)/_build && $(MAKE)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	    CMAKE_COMMAND=$(CMAKE) \
        Boost_INCLUDE_DIRS=$(PREFIX)/include \
              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
                   VERBOSE=1 \
        $(PIP) install --root $(STAGING)/$(_NAME) --verbose --upgrade --no-deps $(_WRKSRC)/
	rsync -ax $(_WRKSRC)/lib/ $(STAGING)/$(_NAME)$(PREFIX)/lib/
	rsync -ax $(_WRKSRC)/include/ $(STAGING)/$(_NAME)$(PREFIX)/include/
	rsync -ax $(_WRKSRC)/third-party/ $(STAGING)/$(_NAME)$(PREFIX)/src/
	rsync -aKx $(STAGING)/$(_NAME)$(PREFIX)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $@
