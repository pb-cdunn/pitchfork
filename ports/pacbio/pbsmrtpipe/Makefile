include ../../../mk/pitchfork.mk

# Local variables
_NAME             = pbsmrtpipe
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
	rm -f $(_WRKSRC)
	ln -s $($(_NAME)_REPO) $(_WRKSRC)
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	$(PIP) install --no-deps $(_WRKSRC)/
	cd $(PREFIX) && \
        find lib/python2.7/site-packages/pbsmrtpipe* \
             bin/pbtools-runner \
             bin/pbtools-report \
             bin/pbtools-gather \
             bin/pbtools-chunker \
             bin/pbtestkit-service-runner \
             bin/pbtestkit-service-multirunner \
             bin/pbtestkit-runner \
             bin/pbtestkit-multirunner \
             bin/pbsmrtpipe \
        | grep -v '^$$'|sort -r > $@
do-clean:
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
