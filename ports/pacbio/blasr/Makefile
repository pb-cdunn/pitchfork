include ../../../mk/pitchfork.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = blasr
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-extract: patch.log
patch.log:
	cat patch-01 | (cd $(_WRKSRC) && patch -p0) | tee patch.log || exit 1
ifneq ($(origin TRAVIS),undefined)
	cat travis.patch | (cd $(_WRKSRC) && patch -p0) | tee -a patch.log || exit 1
endif
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
do-config: | $(_WRKSRC)/defines.mk $(_WRKSRC)/utils/bax2bam/build/Makefile $(_WRKSRC)/utils/bam2bax/build/Makefile
$(_WRKSRC)/defines.mk:
	cd $(_WRKSRC) && \
        ./configure.py --shared \
               PREFIX=$(PREFIX) \
             HDF5_INC=$(HDF5_ROOT)/include \
             HDF5_LIB=$(HDF5_ROOT)/lib \
             ZLIB_LIB=$(ZLIB_ROOT) \
            BOOST_INC=$(BOOST_INCLUDE) \
        LIBPBDATA_INC=$(PREFIX)/include/pbdata \
        LIBPBIHDF_INC=$(PREFIX)/include/hdf \
         LIBBLASR_INC=$(PREFIX)/include/alignment \
        LIBPBDATA_LIB=$(PREFIX)/lib \
        LIBPBIHDF_LIB=$(PREFIX)/lib \
         LIBBLASR_LIB=$(PREFIX)/lib \
            PBBAM_INC=$(PREFIX)/include \
            PBBAM_LIB=$(PREFIX)/lib \
           HTSLIB_INC=$(PREFIX)/src/htslib/include \
           HTSLIB_LIB=$(PREFIX)/src/htslib/lib
$(_WRKSRC)/utils/bax2bam/build/Makefile:
	mkdir -p $(_WRKSRC)/utils/bax2bam/build && \
        cd $(_WRKSRC)/utils/bax2bam/build && \
        $(CMAKE) \
              -DBoost_INCLUDE_DIRS=$(BOOST_INCLUDE) \
              -DHDF5_RootDir=$(HDF5_ROOT) \
              -DPacBioBAM_INCLUDE_DIRS=$(PREFIX)/include \
              -DPacBioBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib/include \
              -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/lib/libhts.a \
              -DGTEST_SRC_DIR=$(PREFIX)/src/gtest \
        ..
$(_WRKSRC)/utils/bam2bax/build/Makefile:
	mkdir -p $(_WRKSRC)/utils/bam2bax/build && \
        cd $(_WRKSRC)/utils/bam2bax/build && \
        $(CMAKE) \
              -DBoost_INCLUDE_DIRS=$(BOOST_INCLUDE) \
              -DHDF5_RootDir=$(HDF5_ROOT) \
              -DPacBioBAM_INCLUDE_DIRS=$(PREFIX)/include \
              -DPacBioBAM_LIBRARIES=$(PREFIX)/lib/libpbbam.$(DYLIB) \
              -DHTSLIB_INCLUDE_DIRS=$(PREFIX)/src/htslib/include \
              -DHTSLIB_LIBRARIES=$(PREFIX)/src/htslib/lib/libhts.a \
              -DGTEST_SRC_DIR=$(PREFIX)/src/gtest \
        ..
do-build:
	$(MAKE) -C $(_WRKSRC) all
	$(MAKE) -C $(_WRKSRC)/utils/bax2bam/build
	$(MAKE) -C $(_WRKSRC)/utils/bam2bax/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME) && mkdir -p $(STAGING)/$(_NAME)/bin
	cd $(_WRKSRC) && tar cf - blasr | tar xf - -C $(STAGING)/$(_NAME)/bin/
	cd $(_WRKSRC)/utils && tar cf - loadPulses pls2fasta sawriter | tar xf - -C $(STAGING)/$(_NAME)/bin/
	cd $(_WRKSRC)/utils/bax2bam && tar cf - bin | tar xf - -C $(STAGING)/$(_NAME)/
	cd $(_WRKSRC)/utils/bam2bax && tar cf - bin | tar xf - -C $(STAGING)/$(_NAME)/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
do-clean:
	$(MAKE) -C $(_WRKSRC) clean
	rm -rf $(_WRKSRC)/utils/bax2bam/build
	rm -rf $(_WRKSRC)/utils/bam2bax/build
	rm -rf $(STAGING)/$(_NAME)
do-distclean:
	rm -f $(_WRKSRC)/defines.mk
do-flush:
	rm -rf $(_WRKSRC)
