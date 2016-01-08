include ../../../mk/config.mk

# Local variables
_NAME            = blasr
_URL             = https://github.com/PacificBiosciences/blasr
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), consider doing yum install gcc-c++"))

export CC
export CXX
export CFLAGS
export CXXFLAGS=$(CFLAGS)

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -d $(_WRKSRC) || git clone $(_URL) $(_WRKSRC)
	@test $($(_NAME)_VERSION) && (cd $(_WRKSRC) && git checkout $($(_NAME)_VERSION)) || true
do-config: do-extract $(_WRKSRC)/defines.mk
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
do-build: do-config
	@$(MAKE) -C $(_WRKSRC) all
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cd $(_WRKSRC) && tar cf - blasr | tar xf - -C $(PREFIX)/bin
	@cd $(_WRKSRC)/utils && tar cf - pls2fasta sawriter | tar xf - -C $(PREFIX)/bin
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
