include ../../../mk/pitchfork.mk

# Local variables
_NAME          = pbdagcon
$(_NAME)_REPO ?= https://github.com/PacificBiosciences/$(_NAME)
_REV           = HEAD
_WRKSRC        = $(WORKSPACE)/$(_NAME)

export CC
export CXX

# Local works
do-fetch: | $(_WRKSRC)
$(_WRKSRC):
	$(GIT) clone $($(_NAME)_REPO) $@
	cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config: | $(_WRKSRC)/build/defines.mk
$(_WRKSRC)/build/defines.mk:
	mkdir -p $(_WRKSRC)/build
	cd $(_WRKSRC) \
     &&     BOOST_INCLUDE=$(BOOST_INCLUDE) \
        LIBPBDATA_INCLUDE=$(PREFIX)/include/pbdata \
         LIBBLASR_INCLUDE=$(PREFIX)/include/alignment \
        LIBPBIHDF_INCLUDE=$(PREFIX)/include \
            PBBAM_INCLUDE=$(PREFIX)/include \
           HTSLIB_INCLUDE=$(PREFIX)/include \
             HDF5_INCLUDE=$(HDF5_ROOT)/include \
            LIBPBDATA_LIB=$(PREFIX)/lib \
             LIBBLASR_LIB=$(PREFIX)/lib \
            LIBPBIHDF_LIB=$(PREFIX)/lib \
                PBBAM_LIB=$(PREFIX)/lib \
               HTSLIB_LIB=$(PREFIX)/lib \
                 HDF5_LIB=$(HDF5_ROOT)/lib \
             DALIGNER_SRC=$(_WRKSRC)/../daligner \
              DAZZ_DB_SRC=$(_WRKSRC)/../dazzdb \
        ./configure.py --build-dir=$(_WRKSRC)/build
do-build:
	$(MAKE) -C $(_WRKSRC)/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)/bin
	cd $(_WRKSRC)/build/src/cpp \
      && tar cf - pbdagcon dazcon \
                  | tar xf - -C $(STAGING)/$(_NAME)/bin/
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F '$(STAGING)/$(_NAME)/' '{print $$2}' > $@
