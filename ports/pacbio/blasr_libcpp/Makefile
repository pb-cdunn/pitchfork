include ../../../mk/config.mk

# Local variables
_NAME            = blasr_libcpp
_URL             = https://github.com/PacificBiosciences/blasr_libcpp
_WRKSRC          = $(WORKSPACE)/$(_NAME)

_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), consider doing yum install gcc-c++"))

export CC
export CXX
export CFLAGS
export CXXFLAGS=$(CFLAGS)

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	@test -d $(_WRKSRC) || ( \
        curl -O -L $(_URL)/archive/master.zip \
        && unzip master.zip -d $(WORKSPACE) \
        && mv $(WORKSPACE)/$(_NAME)-master $(_WRKSRC) )
do-config: do-extract $(_WRKSRC)/defines.mk
$(_WRKSRC)/defines.mk:
	cd $(_WRKSRC) && \
        NOPBBAM=1 ./configure.py \
        PREFIX=$(PREFIX) \
        HDF5_INC=$(PREFIX)/include HDF5_LIB=$(PREFIX)/lib \
        ZLIB_LIB=$(PREFIX)
do-build: do-config
	@$(MAKE) -C $(_WRKSRC) all
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cp -a $(_WRKSRC)/alignment/libblasr.$(DYLIB) $(PREFIX)/lib/
	@cp -a $(_WRKSRC)/hdf/libpbihdf.$(DYLIB) $(PREFIX)/lib/
	@cp -a $(_WRKSRC)/pbdata/libpbdata.$(DYLIB) $(PREFIX)/lib/
	@cd $(_WRKSRC) && tar cf - `find alignment hdf pbdata \( -name '*.hpp' -or -name '*.h' \)` | tar xf - -C $(PREFIX)/include
	@cp -a $(_WRKSRC)/libconfig.h $(PREFIX)/include/alignment/libconfig.h
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX)/ '/^+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^++'|awk -F $(PREFIX)/ '/^+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
