include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME             = trim_isoseq_polyA
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
do-config: $(_WRKSRC)/build/Makefile
$(_WRKSRC)/build/Makefile: | do-fetch
	mkdir -p $(_WRKSRC)/build
	cd $(_WRKSRC)/build  && \
        $(CMAKE) \
              -DBOOST_ROOT=$(BOOST_ROOT) \
              -DCMAKE_BUILD_TYPE=RelWithDebInfo \
              -DCMAKE_SKIP_BUILD_RPATH=FALSE \
            ..
do-build:
	$(MAKE) -C $(_WRKSRC)/build
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	rsync -ax $(_WRKSRC)/bin/ $(PREFIX)/bin/
	rsync -ax $(_WRKSRC)/lib/ $(PREFIX)/lib/
	cd $(_WRKSRC) && find bin lib > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/build clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
