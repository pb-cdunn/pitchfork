include ../../../mk/config.mk

# Local variables
_NAME            = pbbam
_URL             = https://github.com/PacificBiosciences/$(_NAME)
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
do-config: do-extract
	@cd $(_WRKSRC) && mkdir -p build
	@cd $(_WRKSRC)/build && \
        cmake \
            -D GTEST_SRC_DIR=$(PREFIX)/src/gtest \
            -D HTSLIB_ROOTDIR=$(PREFIX)/src/htslib \
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
