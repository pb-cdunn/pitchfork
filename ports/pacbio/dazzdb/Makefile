include ../../../mk/pitchfork.mk

# Local variables
_NAME             = dazzdb
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/DAZZ_DB
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-config:
	mkdir -p $(_WRKSRC)/build
	echo PREFIX:=$(PREFIX) > $(_WRKSRC)/build/Makefile
	echo CC:=$(CC) >> $(_WRKSRC)/build/Makefile
	echo AR:=$(AR) >> $(_WRKSRC)/build/Makefile
	echo include ../GNUmakefile >> $(_WRKSRC)/build/Makefile
do-build:
	$(MAKE) -C $(_WRKSRC)/build
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	cd $(_WRKSRC)/build && tar cf - DBrm DBshow DBsplit DBstats fasta2DB | tar xf - -C $(PREFIX)/bin/
	cd $(_WRKSRC)/build && tar cf - *.a                                  | tar xf - -C $(PREFIX)/lib/
	cd $(_WRKSRC)       && tar cf - *.h                                  | tar xf - -C $(PREFIX)/include/
	cd $(_WRKSRC)/build && find DBrm DBshow DBsplit DBstats fasta2DB | awk '{print "$(PREFIX)/bin/"$$1}'     >  $@
	cd $(_WRKSRC)/build && find *.a                                  | awk '{print "$(PREFIX)/lib/"$$1}'     >> $@
	cd $(_WRKSRC)       && find *.h                                  | awk '{print "$(PREFIX)/include/"$$1}' >> $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/build clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flash:
	rm -rf $(_WRKSRC)
