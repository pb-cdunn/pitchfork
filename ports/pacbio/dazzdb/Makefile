include ../../../mk/pitchfork.mk

# Local variables
_NAME             = dazzdb
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/DAZZ_DB
_WRKSRC           = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION ?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	rsync -avx $($(_NAME)_REPO)/ $(_WRKSRC)/
endif
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
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/build clean
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flash:
	rm -rf $(_WRKSRC)
