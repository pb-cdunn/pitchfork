include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME            = pbbam
$(_NAME)_REPO   ?= https://github.com/PacificBiosciences/$(_NAME)
_WRKSRC          = $(WORKSPACE)/$(_NAME)
$(_NAME)_VERSION?= HEAD

# Local works
do-fetch: | $(_WRKSRC)
	@cd $(_WRKSRC) && $(GIT) checkout $($(_NAME)_VERSION)
$(_WRKSRC):
	@$(GIT) clone $($(_NAME)_REPO) $@
do-config: | $(_WRKSRC)/build/Makefile
$(_WRKSRC)/build/Makefile:
	@cd $(_WRKSRC) && mkdir -p build
	@cd $(_WRKSRC)/build \
     && $(CMAKE) \
            -DPacBioBAM_build_shared=ON \
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
do-build:
	@cd $(_WRKSRC)/build && $(MAKE)
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)
	@cd $(_WRKSRC) && tar cf - bin lib include | tar xf - -C $(STAGING)/$(_NAME)
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
