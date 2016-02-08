include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME    = boost-1.60.0
_URL     = https://prdownloads.sourceforge.net/boost
_FILE    = boost_1_60_0.tar.gz
_WRKSRC  = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch: | $(_FILE)
$(_FILE):
	$(CURL) -L -O $(_URL)/$@
do-extract: | $(_WRKSRC)
$(_WRKSRC):
	$(MD5SUM) -c MD5SUM || exit
	mkdir -p $(_WRKSRC) && tar zxf $(_FILE) --strip=1 -C $(_WRKSRC)

ifneq ($(origin DO_BOOST_LIB),undefined)
do-config: | $(_WRKSRC)/project-config.jam
$(_WRKSRC)/project-config.jam:
	(cd $(_WRKSRC) && ./bootstrap.sh --prefix=$(PREFIX) 2>&1) | tee config.log | $(PFHOME)/bin/activity
endif

do-build: | $(STAGING)/$(_NAME)
$(STAGING)/$(_NAME):
	mkdir -p $(STAGING)/$(_NAME)/include
	cd $(_WRKSRC) && tar cf - boost | tar xf - -C $(STAGING)/$(_NAME)/include
ifneq ($(origin DO_BOOST_LIB),undefined)
	cd $(_WRKSRC) && ./bjam --without-python \
                                 --without-mpi \
                                 --without-iostreams \
                                 --stagedir=$(STAGING)/$(_NAME) \
                                 stage 2>&1 | tee build.log | $(PFHOME)/bin/activity
endif

do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	find $(STAGING)/$(_NAME) ! -type d|awk -F $(STAGING)/$(_NAME)/ '{print $$2}' > $@
do-clean:
	rm -rf $(_WRKSRC) || true
