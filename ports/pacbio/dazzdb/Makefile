include ../../../mk/config.mk

# Local variables
_NAME   = dazzdb
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/DAZZ_DB
_REV    = HEAD
_WRKSRC = $(WORKSPACE)/$(_NAME)

export CC
export CFLAGS

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config:
	mkdir -p $(_WRKSRC)/build $(STAGING)/$(_NAME)
	echo PREFIX:=$(STAGING)/$(_NAME) > $(_WRKSRC)/build/Makefile
	echo CC:=$(CC) >> $(_WRKSRC)/build/Makefile
	echo AR:=$(AR) >> $(_WRKSRC)/build/Makefile
	echo include ../GNUmakefile >> $(_WRKSRC)/build/Makefile
do-build:
	$(MAKE) -C $(_WRKSRC)/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/bin 
	mkdir -p $(STAGING)/$(_NAME)/lib
	mkdir -p $(STAGING)/$(_NAME)/include 
	cd $(_WRKSRC)/build && tar cf - DBrm DBshow DBsplit DBstats fasta2DB|tar xf - -C $(STAGING)/$(_NAME)/bin/
	cd $(_WRKSRC)/build && tar cf - *.a|tar xf - -C $(STAGING)/$(_NAME)/lib/
	cd $(_WRKSRC) && tar cf - *.h|tar xf - -C $(STAGING)/$(_NAME)/include/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)/
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
