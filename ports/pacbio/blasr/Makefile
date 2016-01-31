include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = blasr
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
ifneq ($(origin TRAVIS),undefined)
do-extract:
	@test -e $(_WRKSRC)/defines.mk || (cat travis.patch | (cd $(_WRKSRC) && patch -p0))
endif
do-fetch: | $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
$(_WRKSRC):
	@$(GIT) clone $($(_NAME)_REPO) $@
do-config: | $(_WRKSRC)/defines.mk $(_WRKSRC)/utils/bax2bam/build/Makefile $(_WRKSRC)/utils/bam2bax/build/Makefile
$(_WRKSRC)/defines.mk:
	cd $(_WRKSRC) && \
        ./configure.py --shared \
               PREFIX=$(PREFIX) \
             HDF5_INC=$(PREFIX)/include \
             HDF5_LIB=$(PREFIX)/lib \
             ZLIB_LIB=$(PREFIX) \
        LIBPBDATA_INC=$(PREFIX)/include/pbdata \
        LIBPBIHDF_INC=$(PREFIX)/include/hdf \
         LIBBLASR_INC=$(PREFIX)/include/alignment \
        LIBPBDATA_LIB=$(PREFIX)/lib \
        LIBPBIHDF_LIB=$(PREFIX)/lib \
         LIBBLASR_LIB=$(PREFIX)/lib \
            PBBAM_INC=$(PREFIX)/include \
            PBBAM_LIB=$(PREFIX)/lib \
           HTSLIB_INC=$(PREFIX)/src/htslib \
           HTSLIB_LIB=$(PREFIX)/src/htslib
$(_WRKSRC)/utils/bax2bam/build/Makefile:
	@mkdir -p $(_WRKSRC)/utils/bax2bam/build && \
        cd $(_WRKSRC)/utils/bax2bam/build && \
        $(CMAKE) \
              -DHDF5_RootDir=$(PREFIX) \
              -DPacBioBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPacBioBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib \
              -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/libhts.$(DYLIB) \
              -DGTEST_SRC_DIR=$(PREFIX)/src/gtest \
        ..
$(_WRKSRC)/utils/bam2bax/build/Makefile:
	@mkdir -p $(_WRKSRC)/utils/bam2bax/build && \
        cd $(_WRKSRC)/utils/bam2bax/build && \
        $(CMAKE) \
              -DHDF5_RootDir=$(PREFIX) \
              -DPacBioBAM_INCLUDE_DIRS=$(PREFIX)/include/pbbam \
              -DPacBioBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib \
              -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/libhts.$(DYLIB) \
              -DGTEST_SRC_DIR=$(PREFIX)/src/gtest \
        ..
do-build:
	@$(MAKE) -C $(_WRKSRC) all
	@$(MAKE) -C $(_WRKSRC)/utils/bax2bam/build
	@$(MAKE) -C $(_WRKSRC)/utils/bam2bax/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cd $(_WRKSRC) && tar cf - blasr | tar xf - -C $(PREFIX)/bin
	@cd $(_WRKSRC)/utils && tar cf - loadPulses pls2fasta sawriter | tar xf - -C $(PREFIX)/bin
	@cd $(_WRKSRC)/utils/bax2bam && tar cf - bin | tar xf - -C $(PREFIX)/
	@cd $(_WRKSRC)/utils/bam2bax && tar cf - bin | tar xf - -C $(PREFIX)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
