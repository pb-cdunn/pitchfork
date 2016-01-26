include ../../../mk/config.mk

# Local variables
_NAME   = daligner
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/DALIGNER
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
	@echo LIBDIRS:=$(PREFIX)/lib >> $(_WRKSRC)/build/Makefile
	@echo include ../GNUmakefile >> $(_WRKSRC)/build/Makefile
do-build:
	@$(MAKE) -C $(_WRKSRC)/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@cd $(_WRKSRC)/build \
      && tar cf - daligner    LAsplit    LAsort  LAmerge HPCmapper \
                  HPCdaligner LAshow     LAcheck LAcat   LA4Falcon \
                  DB2Falcon   daligner_p | tar xf - -C $(PREFIX)/bin
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
