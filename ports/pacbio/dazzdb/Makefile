include ../../../mk/config.mk

# Local variables
_NAME   = dazzdb
_URL    = https://github.com/PacificBiosciences/DAZZ_DB
_REV    = HEAD
_WRKSRC = $(WORKSPACE)/$(_NAME)

export CC
export CFLAGS

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone $(_URL) $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config: do-extract
	@mkdir -p $(_WRKSRC)/build $(STAGING)/$(_NAME)
	@echo PREFIX:=$(STAGING)/$(_NAME) > $(_WRKSRC)/build/Makefile
	@echo CC:=$(CC) >> $(_WRKSRC)/build/Makefile
	@echo AR:=$(AR) >> $(_WRKSRC)/build/Makefile
	@echo include ../GNUmakefile >> $(_WRKSRC)/build/Makefile

do-build: do-config
	@$(MAKE) -C $(_WRKSRC)/build
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@cd $(_WRKSRC)/build && tar cf - DBrm DBshow DBsplit DBstats fasta2DB|tar xf - -C $(PREFIX)/bin
	@cd $(_WRKSRC)/build && tar cf - *.a|tar xf - -C $(PREFIX)/lib
	@cd $(_WRKSRC) && tar cf - *.h|tar xf - -C $(PREFIX)/include
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
