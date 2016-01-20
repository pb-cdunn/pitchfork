include ../../../mk/config.mk

# Local variables
_NAME   = seqan
_URL    = https://github.com/PacificBiosciences/seqan
_REV    = HEAD
_WRKSRC = $(WORKSPACE)/$(_NAME)

#export CC
#export CFLAGS

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone $(_URL) $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config: do-extract
do-build: do-config
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@cd $(_WRKSRC) && \
        tar cf - include|tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
