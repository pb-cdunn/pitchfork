include ../../../mk/pitchfork.mk

# Local variables
_NAME             = daligner
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/DALIGNER
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= HEAD
PROGRAMS          = daligner    LAsplit    LAsort  LAmerge HPCmapper \
                    HPCdaligner LAshow     LAcheck LAcat   LA4Falcon \
                    DB2Falcon   daligner_p LA4Ice

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	$(GIT) -C $(_WRKSRC) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-config:
	mkdir -p $(_WRKSRC)/build
	echo PREFIX:=$(PREFIX) > $(_WRKSRC)/build/Makefile
	echo CC:=$(CC) >> $(_WRKSRC)/build/Makefile
	echo LIBDIRS:=$(PREFIX)/lib >> $(_WRKSRC)/build/Makefile
	echo include ../GNUmakefile >> $(_WRKSRC)/build/Makefile
do-build:
	$(MAKE) -C $(_WRKSRC)/build
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	cd $(_WRKSRC)/build && \
        tar cf - $(PROGRAMS) \
        | tar xvf - -C $(PREFIX)/bin/ \
	| awk '{print "bin/"$$1}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC)/build clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flush:
	rm -rf $(_WRKSRC)
