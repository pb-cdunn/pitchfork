include ../../../mk/pitchfork.mk

# Local variables
_NAME             = falcon_kit
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/FALCON
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
        find lib/python2.7/site-packages/falcon_kit* \
             lib/python2.7/site-packages/ext_falcon* \
             bin/fc_run1 \
             bin/fc_run.py \
             bin/fc_run \
             bin/fc_ovlp_to_graph.py \
             bin/fc_ovlp_to_graph \
             bin/fc_ovlp_stats.py \
             bin/fc_ovlp_stats \
             bin/fc_ovlp_filter.py \
             bin/fc_ovlp_filter \
             bin/fc_graph_to_utgs.py \
             bin/fc_graph_to_utgs \
             bin/fc_graph_to_contig.py \
             bin/fc_graph_to_contig \
             bin/fc_dedup_a_tigs.py \
             bin/fc_dedup_a_tigs \
             bin/fc_ctg_link_analysis.py \
             bin/fc_ctg_link_analysis \
             bin/fc_contig_annotate.py \
             bin/fc_contig_annotate \
             bin/fc_consensus.py \
             bin/fc_consensus \
             bin/fc_calc_cutoff \
             bin/fc_actg_coordinate.py \
             bin/fc_actg_coordinate \
             bin/falcon-task \
        | grep -v '^$$'|sort -r > $@
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-clean:
