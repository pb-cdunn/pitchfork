include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME   = cmake-3.4.1
_URL    = https://cmake.org/files/v3.4
_FILE   = $(_NAME).tar.gz
_WRKSRC = $(WORKSPACE)/$(_NAME)

export CFLAGS
export CXXFLAGS
export LDFLAGS

# Local works
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	tar zxf $(_FILE) -C $(WORKSPACE)
do-config: | $(_WRKSRC)/Makefile
$(_WRKSRC)/Makefile:
	(cd $(_WRKSRC) && ./bootstrap --prefix=$(STAGING)/$(_NAME) 2>&1) | tee config.log | $(PFHOME)/bin/activity
do-build: | $(_WRKSRC)/bin/cmake
$(_WRKSRC)/bin/cmake:
	$(MAKE) -C $(_WRKSRC) 2>&1 | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	$(MAKE) -C $(_WRKSRC) install 2>&1 | tee install.log | $(PFHOME)/bin/activity
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
