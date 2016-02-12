include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = ppa
_WRKSRC          = $(WORKSPACE)/$(_NAME)
_WRKSRCP4        = $(shell hostname)
_P4CLIENTNAME    = pitchfork-$(_WRKSRCP4)
_P4CLIENT        = P4CLIENT=$(_P4CLIENTNAME)
_BUILD           = $(_WRKSRC)/Sequel/ppa/build

# Local works
do-fetch: | $(_WRKSRC) 
	cd $(_WRKSRC) && $(_P4CLIENT) p4 sync
$(_WRKSRC):
	mkdir -p $(_WRKSRC) && \
	cd $(_WRKSRC) && \
	if [[ `p4 clients | grep $(_P4CLIENTNAME)` ]]; then p4 client -d $(_P4CLIENTNAME); fi && \
	$(_P4CLIENT) P4EDITOR=cat p4 client -S //PrimaryAnalysis/pparmin
do-config: | $(_BUILD)/Makefile
$(_BUILD)/Makefile:
	mkdir -p $(_BUILD) && \
	cd $(_BUILD) && \
    $(CMAKE) \
    	-DSECONDARY_BUILD=T \
    	-DPPA_build_tests=OFF \
    	..
do-build:
	$(MAKE) -j -C $(_BUILD)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/bin
	rsync -ax $(_BUILD)/ba* $(STAGING)/$(_NAME)/bin/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
