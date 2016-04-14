include ../../../mk/pitchfork.mk

# Local variables
_NAME             = pbreports
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
	ln -fs $($(_NAME)_REPO) $(_WRKSRC)
endif
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-fetch
	$(PIP) install --no-deps $(_WRKSRC)/
	cd $(PREFIX) && \
        find lib/python2.7/site-packages/pbreports* \
             bin/summarize_coverage                 \
             bin/summarize_compare_by_movie         \
             bin/preassembly_report                 \
             bin/overview_report                    \
             bin/motifs_report                      \
             bin/mapping_stats_poc                  \
             bin/mapping_stats                      \
             bin/loading_xml                        \
             bin/isoseq_cluster_report              \
             bin/isoseq_classify_report             \
             bin/filter_subread_summary             \
             bin/filter_subread                     \
             bin/filter_stats_xml                   \
             bin/filter_stats                       \
             bin/ccs_report                         \
             bin/barcode_report                     \
             bin/amplicon_analysis_timing_report    \
             bin/amplicon_analysis_input_report     \
             bin/amplicon_analysis_consensus_report \
             bin/adapter_xml                        \
        | grep -v '^$$'|sort -r > $@
do-clean:
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
