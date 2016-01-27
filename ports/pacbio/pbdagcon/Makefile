include ../../../mk/config.mk

# Local variables
_NAME          = pbdagcon
$(_NAME)_REPO ?= https://github.com/PacificBiosciences/$(_NAME)
_REV           = HEAD
_WRKSRC        = $(WORKSPACE)/$(_NAME)

export CC
export CXX

# Local works
do-fetch:
	@test -d $(_WRKSRC) || $(GIT) clone $($(_NAME)_REPO) $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $(_REV)
do-config:
	@mkdir -p $(_WRKSRC)/build
	@cd $(_WRKSRC) \
     &&     BOOST_INCLUDE=$(PREFIX)/include \
        LIBPBDATA_INCLUDE=$(PREFIX)/include/pbdata \
         LIBBLASR_INCLUDE=$(PREFIX)/include/alignment \
        LIBPBIHDF_INCLUDE=$(PREFIX)/include \
            PBBAM_INCLUDE=$(PREFIX)/include \
           HTSLIB_INCLUDE=$(PREFIX)/src/htslib \
             HDF5_INCLUDE=$(PREFIX)/include \
            LIBPBDATA_LIB=$(PREFIX)/lib \
             LIBBLASR_LIB=$(PREFIX)/lib \
            LIBPBIHDF_LIB=$(PREFIX)/lib \
                PBBAM_LIB=$(PREFIX)/lib \
               HTSLIB_LIB=$(PREFIX)/lib \
                 HDF5_LIB=$(PREFIX)/lib \
             DALIGNER_SRC=$(_WRKSRC)/../daligner \
              DAZZ_DB_SRC=$(_WRKSRC)/../dazzdb \
        ./configure.py --build-dir=$(_WRKSRC)/build
do-build:
	@$(MAKE) -C $(_WRKSRC)/build
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@cd $(_WRKSRC)/build/src/cpp \
      && tar cf - pbdagcon dazcon \
                  | tar xf - -C $(PREFIX)/bin
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
