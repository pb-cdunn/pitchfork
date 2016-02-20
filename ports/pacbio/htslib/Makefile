include ../../../mk/pitchfork.mk

# Local variables
_NAME             = htslib
$(_NAME)_REPO    ?= git://github.com/PacificBiosciences/$(_NAME)
_WRKSRC           = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION ?= ea846607f3ca7f49b3fb43df76f572d3f47cc6bb

export CC
export CFLAGS

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
ifeq ($(wildcard $($(_NAME)_REPO)),)
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
else
	rsync -avx $($(_NAME)_REPO)/ $(_WRKSRC)/
endif
do-build:
	$(MAKE) -C $(_WRKSRC) \
                   CC=$(CC) \
            ZLIB_ROOT=$(ZLIB_ROOT) \
               CFLAGS="$(CFLAGS) -Wall -O2 -Wno-unused-function" \
              LDFLAGS=$(LDFLAGS) \
        2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/src/htslib/include
	mkdir -p $(STAGING)/$(_NAME)/src/htslib/lib
	cd $(_WRKSRC) && \
        tar cf - */*.h|tar xf - -C $(STAGING)/$(_NAME)/src/htslib/include/
	cd $(_WRKSRC) && tar cf - *.a | tar xf - -C $(STAGING)/$(_NAME)/src/htslib/lib/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)/
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
#this thing cannot be installed to prefix/lib or it will kill pysam/samtools
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	cd $(_WRKSRC) && $(GIT) clean -xdf
do-flash:
	rm -rf $(_WRKSRC)
