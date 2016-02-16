include ../../../mk/pitchfork.mk

# Local variables
_NAME   = seqan
_URL    = git://github.com/PacificBiosciences/seqan
_REV    = HEAD
_WRKSRC = $(WORKSPACE)/$(_NAME)

#export CC
#export CFLAGS

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $(_URL) $@
	cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	cd $(_WRKSRC) && tar cf - include|tar xf - -C $(STAGING)/$(_NAME)/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
