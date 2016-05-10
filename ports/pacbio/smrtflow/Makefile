include ../../../mk/pitchfork.mk

# Local variables
_NAME             = smrtflow
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
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-build: $(_WRKSRC)/smrt-analysis/target/pack/Makefile
$(_WRKSRC)/smrt-analysis/target/pack/Makefile: | do-fetch
	cd $(_WRKSRC) && sbt smrt-analysis/pack
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	$(MAKE) PREFIX=$(PREFIX) -C $(_WRKSRC)/smrt-analysis/target/pack install
	cd $(PREFIX) && find smrt-analysis ! -type d > $@
	cd $(PREFIX) && \
        find bin/ds-tools \
             bin/fasta-to-reference \
             bin/merge-datasets \
             bin/movie-metadata-to-dataset \
             bin/movie-metadata-to-dataset-rtc \
             bin/reference-to-dataset \
             bin/validate-dataset >> $@
do-clean:
	rm -rf $(_WRKSRC)/smrt-analysis/target
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
