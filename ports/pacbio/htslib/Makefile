include ../../../mk/pitchfork.mk

# Local variables
_NAME             = htslib
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKDIR)/$(_NAME)
$(_NAME)_VERSION ?= ea846607f3ca7f49b3fb43df76f572d3f47cc6bb

# Local works
do-fetch: $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	$(GIT) -C $(_WRKSRC) checkout $($(_NAME)_VERSION)
else
	ln -sfn $($(_NAME)_REPO) $(_WRKSRC)
endif
do-build:
	$(MAKE) -C $(_WRKSRC) \
                   CC=$(CC) \
            ZLIB_ROOT=$(ZLIB_ROOT) \
               CFLAGS="$(CFLAGS) -Wall -O2 -Wno-unused-function" \
              LDFLAGS="$(LDFLAGS)" \
        >& build.log || $(PFHOME)/bin/diewith build.log
do-install: $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME): | do-build
	mkdir -p $(PREFIX)/src/htslib/lib
	mkdir -p $(PREFIX)/src/htslib/include
	cd $(_WRKSRC) && tar cf - */*.h | tar xf - -C $(PREFIX)/src/htslib/include/
	cd $(_WRKSRC) && tar cf - *.a   | tar xf - -C $(PREFIX)/src/htslib/lib/
	cd $(PREFIX)  && find src/htslib ! -type d > $@
#this thing cannot be installed to prefix/lib or it will kill pysam/samtools
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flash:
	rm -rf $(_WRKSRC)
