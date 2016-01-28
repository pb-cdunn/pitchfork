include ../../../mk/config.mk

# Local variables
_NAME            = ConsensusCore
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch:
	@test -d $(_WRKSRC) || $(GIT) clone $($(_NAME)_REPO) $(_WRKSRC)
	@test $($(_NAME)_VERSION) && (cd $(_WRKSRC) && git checkout $($(_NAME)_VERSION)) || true
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
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@$(PREFIX)/bin/pip install --no-index --install-option="--swig=$(PREFIX)/bin/swig" --install-option="--swig-lib=$(PREFIX)/share/swig/3.0.8" --install-option="--boost=$(PREFIX)/include" $(_WRKSRC)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
