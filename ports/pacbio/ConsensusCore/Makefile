include ../../../mk/config.mk

# Local variables
_NAME            = ConsensusCore
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
$(_WRKSRC):
	@$(GIT) clone $($(_NAME)_REPO) $@
do-config:
	@cd $(_WRKSRC) && ./configure \
            --swig=$(PREFIX)/bin/swig \
            --swig-lib=$(PREFIX)/share/swig/3.0.8 \
            --boost=$(PREFIX)/include \
            --python-include=$(PREFIX)/include/python2.7 \
            --numpy-include=$(PREFIX)/lib/python2.7/site-packages/numpy/core/include
do-build:
	@$(MAKE) -C $(_WRKSRC) lib python
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)
	@$(PIP) install --root $(STAGING)/$(_NAME) --no-deps --install-option="--swig=$(PREFIX)/bin/swig" --install-option="--swig-lib=$(PREFIX)/share/swig/3.0.8" --install-option="--boost=$(PREFIX)/include" $(_WRKSRC)/
	@rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	@find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $(PREFIX)/var/pkg/$(_NAME)
