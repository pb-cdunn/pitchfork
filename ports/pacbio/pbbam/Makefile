include ../../../mk/config.mk

# Local variables
_NAME            = pbbam
_URL             = https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), consider doing yum install gcc-c++"))

#export CC
#export CXX
#export CFLAGS
#export CXXFLAGS=$(CFLAGS)

# Local works
do-extract: do-fetch
do-fetch: wscheck
	@test -d $(_WRKSRC) || git clone $(_URL) $(_WRKSRC)
	@test $($(_NAME)_VERSION) && (cd $(_WRKSRC) && git checkout $($(_NAME)_VERSION)) || true
do-config: do-extract
	@cd $(_WRKSRC) && mkdir -p build
	@cd $(_WRKSRC)/build && \
        cmake \
            -DPacBioBAM_build_docs=OFF \
            -DPacBioBAM_build_tests=OFF \
            -DGTEST_SRC_DIR=$(PREFIX)/src/gtest \
            -DHTSLIB_ROOTDIR=$(PREFIX)/src/htslib \
            -DZLIB_INCLUDE_DIRS=$(PREFIX)/include \
            -DZLIB_LIBRARIES_DIRS=$(PREFIX)/lib \
            -DBoost_INCLUDE_DIRS=$(PREFIX)/include \
            -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DCMAKE_SKIP_BUILD_RPATH=TRUE \
            ..
do-build: do-config
	@cd $(_WRKSRC)/build && $(MAKE)
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@cd $(_WRKSRC) && tar cf - bin lib include | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
