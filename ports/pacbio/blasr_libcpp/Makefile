include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = blasr_libcpp
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-extract:
	@cat patch-01 | (cd $(_WRKSRC) && patch -p0)
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	@$(GIT) clone $($(_NAME)_REPO) $@
	@cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
do-config: | $(_WRKSRC)/defines.mk
$(_WRKSRC)/defines.mk:
	cd $(_WRKSRC) && \
        ./configure.py \
            PREFIX=$(PREFIX) \
          HDF5_INC=$(PREFIX)/include HDF5_LIB=$(PREFIX)/lib \
          ZLIB_LIB=$(PREFIX) \
         PBBAM_INC=$(PREFIX)/include PBBAM_LIB=$(PREFIX)/lib \
        HTSLIB_INC=$(PREFIX)/src/htslib \
        HTSLIB_LIB=$(PREFIX)/src/htslib
do-build:
	@$(MAKE) -C $(_WRKSRC) libpbdata LDLIBS=-lpbbam
	@$(MAKE) -C $(_WRKSRC) libpbihdf
	@$(MAKE) -C $(_WRKSRC) libblasr
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@cp -a $(_WRKSRC)/alignment/libblasr.$(DYLIB) $(PREFIX)/lib/
	@cp -a $(_WRKSRC)/hdf/libpbihdf.$(DYLIB) $(PREFIX)/lib/
	@cp -a $(_WRKSRC)/pbdata/libpbdata.$(DYLIB) $(PREFIX)/lib/
	@cd $(_WRKSRC) && tar cf - `find alignment hdf pbdata \( -name '*.hpp' -or -name '*.h' \)` | tar xf - -C $(PREFIX)/include
	@echo $(PREFIX)/lib/alignment/libblasr.$(DYLIB) > $@
	@echo $(PREFIX)/lib/hdf/libpbihdf.$(DYLIB) >> $@
	@echo $(PREFIX)/pbdata/libpbdata.$(DYLIB) >> $@
	@cd $(_WRKSRC) && find alignment hdf pbdata \( -name '*.hpp' -or -name '*.h' \) | awk '{print "include/"$$1}' >> $@
