include ../../../mk/config.mk

# Local variables
_NAME   = dazzdb
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/DAZZ_DB
_REV    = HEAD
_WRKSRC = $(WORKSPACE)/$(_NAME)

export CC
export CFLAGS

# Local works
do-fetch:
	@test -d $(_WRKSRC) || $(GIT) clone $($(_NAME)_REPO) $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config:
	@mkdir -p $(_WRKSRC)/build $(STAGING)/$(_NAME)
	@echo PREFIX:=$(STAGING)/$(_NAME) > $(_WRKSRC)/build/Makefile
	@echo CC:=$(CC) >> $(_WRKSRC)/build/Makefile
	@echo AR:=$(AR) >> $(_WRKSRC)/build/Makefile
	@echo include ../GNUmakefile >> $(_WRKSRC)/build/Makefile
do-build:
	@$(MAKE) -C $(_WRKSRC)/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@cd $(_WRKSRC)/build && tar cf - DBrm DBshow DBsplit DBstats fasta2DB|tar xf - -C $(PREFIX)/bin
	@cd $(_WRKSRC)/build && tar cf - *.a|tar xf - -C $(PREFIX)/lib
	@cd $(_WRKSRC) && tar cf - *.h|tar xf - -C $(PREFIX)/include
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
