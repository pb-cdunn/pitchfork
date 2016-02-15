include ../../../mk/pitchfork.mk

# Local variables
_NAME            = ConsensusCore
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
do-config: | $(_WRKSRC)/make/Config.mk
$(_WRKSRC)/make/Config.mk:
	cd $(_WRKSRC) && ./configure \
            --swig=$(PREFIX)/bin/swig \
            --swig-lib=$(PREFIX)/share/swig/3.0.8 \
            --boost=$(BOOST_INCLUDE) \
            --python-include=$(PREFIX)/include/python2.7 \
            --numpy-include=$(PREFIX)/lib/python2.7/site-packages/numpy/core/include
do-build: | $(_WRKSRC)/build/C++/libConsensusCore.a $(_WRKSRC)/build/Python/_ConsensusCore.so
$(_WRKSRC)/build/C++/libConsensusCore.a:
	$(MAKE) -C $(_WRKSRC) lib
$(_WRKSRC)/build/Python/_ConsensusCore.so:
	$(MAKE) -C $(_WRKSRC) python
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps --install-option="--swig=$(PREFIX)/bin/swig" --install-option="--swig-lib=$(PREFIX)/share/swig/3.0.8" --install-option="--boost=$(BOOST_INCLUDE)" $(_WRKSRC)/
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F '$(STAGING)/$(_NAME)$(PREFIX)/' '{print $$2}'|grep -v '^$$'|sort -r > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && 20 20 12 61 79 80 81 98 33 100 204 395 398 399GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
