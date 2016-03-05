include ../../../mk/pitchfork.mk

# FC check
include ../../../mk/chkfc.mk

# Local variables
_NAME   = OpenBLAS-0.2.15
_URL    = https://github.com/xianyi/OpenBLAS/archive
_WRKSRC = $(WORKSPACE)/$(_NAME)
_FILE   = v0.2.15.tar.gz
export CFLAGS LDFLAGS

# Local works
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-build: | $(_WRKSRC)/libopenblas.$(DYLIB)
$(_WRKSRC)/libopenblas.$(DYLIB):
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) PREFIX=$(STAGING)/$(_NAME) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -f build.log install.log
	rm -rf $(STAGING)/$(_NAME)
do-flush:
	rm -rf $(_WRKSRC) || true

ifneq ($(origin HAVE_OPENBLAS),undefined)
_OPENBLAS = $(shell ../../../bin/checkOPENBLAS $(HAVE_OPENBLAS))
provided:
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/include
	mkdir -p $(STAGING)/$(_NAME)/lib
	cp -a $(_OPENBLAS)/include/cblas.h            $(STAGING)/$(_NAME)/include/
	cp -a $(_OPENBLAS)/include/f77blas.h          $(STAGING)/$(_NAME)/include/
	cp -a $(_OPENBLAS)/include/lapacke.h          $(STAGING)/$(_NAME)/include/
	cp -a $(_OPENBLAS)/include/lapacke_utils.h    $(STAGING)/$(_NAME)/include/
	cp -a $(_OPENBLAS)/include/lapacke_config.h   $(STAGING)/$(_NAME)/include/
	cp -a $(_OPENBLAS)/include/openblas_config.h  $(STAGING)/$(_NAME)/include/
	cp -a $(_OPENBLAS)/include/lapacke_mangling.h $(STAGING)/$(_NAME)/include/
	rsync -avx $(_OPENBLAS)/cmake/openblas*       $(STAGING)/$(_NAME)/lib/cmake/
	rsync -avx $(_OPENBLAS)/libopenblas*          $(STAGING)/$(_NAME)/lib/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
endif
