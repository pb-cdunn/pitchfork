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
	@cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
$(_WRKSRC):
	@$(GIT) clone $($(_NAME)_REPO) $@
do-config: | $(_WRKSRC)/_build/Makefile
$(_WRKSRC)/_build/Makefile:
	@mkdir -p $(_WRKSRC)/_build
	@cd $(_WRKSRC)/_build \
     && $(CMAKE) \
          -DCMAKE_BUILD_TYPE=Release \
          -DBoost_INCLUDE_DIRS=$(PREFIX)/include \
        ..
do-build:
	@cd $(_WRKSRC)/_build && $(MAKE)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@    CMAKE_COMMAND=$(CMAKE) \
        Boost_INCLUDE_DIRS=$(PREFIX)/include \
              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
                   VERBOSE=1 \
        $(PIP) install --verbose --upgrade --no-deps $(_WRKSRC)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
