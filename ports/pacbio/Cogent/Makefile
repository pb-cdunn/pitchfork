include ../../../mk/pitchfork.mk

# Local variables
_NAME             = Cogent
$(_NAME)_REPO    ?= git://github.com/Magdoll/$(_NAME)
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	rsync -avx $($(_NAME)_REPO)/ $(_WRKSRC)/
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	$(PIP) install --no-deps $(_WRKSRC)/
	cd $(PREFIX) && \
        find lib/python2.7/site-packages/Cogent* \
             bin/run_mash.py \
             bin/reconstruct_contig.py \
             bin/process_kmer_to_graph.py \
             bin/gff3_to_collapsed.py \
             bin/generate_cmds_for_cogent.py \
        | grep -v '^$$'|sort -r > $@
do-clean:
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
