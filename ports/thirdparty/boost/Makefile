include ../../../mk/config.mk

# CXX check
include ../../../mk/chkcxx.mk

# Local variables
_NAME    = boost-1.60.0
_URL     = http://sourceforge.net/projects/boost/files/boost/1.60.0
_FILE    = boost_1_60_0.tar.gz
_WRKSRC  = $(WORKSPACE)/$(_NAME)

# Local works
do-fetch:
	@test -e $(_FILE) || $(CURL) -L -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
do-extract:
	@test -d $(_WRKSRC) || (mkdir -p $(_WRKSRC) && tar zxf $(_FILE) --strip=1 -C $(_WRKSRC))
do-config: ;
do-build:
	@test -e $(_WRKSRC)/project-config.jam \
      || (cd $(_WRKSRC) && ./bootstrap.sh --prefix=$(STAGING)/$(_NAME) 2>&1) | tee build.log | $(PFHOME)/bin/activity
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@mkdir -p $(STAGING)/$(_NAME)
	@(cd $(_WRKSRC) && ./bjam --without-python \
                                  --without-mpi \
                                  --without-iostreams \
                                install 2>&1) | tee install.log | $(PFHOME)/bin/activity 
	@cd $(STAGING)/$(_NAME) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
	@echo "done"
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
