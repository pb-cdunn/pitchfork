include ../../../mk/config.mk

# Local variables
_NAME            = boost-1.60.0
_URL             = http://sourceforge.net/projects/boost/files/boost/1.60.0
_FILE            = boost_1_60_0.tar.gz
_WRKSRC          = $(WORKSPACE)/$(_NAME)

_tmpvar:=$(if $(shell which $(CXX)),exists,$(error "unable to run $(CXX), consider doing yum install gcc-c++"))
export CC
export CXX

# Local works
do-extract: wscheck
	@test -e $(_FILE) || $(CURL) -L -O $(_URL)/$(_FILE)
	@which $(MD5SUM) >& /dev/null && $(MD5SUM) -c MD5SUM
	@test -d $(_WRKSRC) || tar zxf $(_FILE) --transform 's/^boost_1_60_0/boost-1.60.0/' -C $(WORKSPACE)
do-config: do-extract
	@cd $(_WRKSRC) && (test -e project-config.jam || ./bootstrap.sh --prefix=$(PREFIX) >& bootstrap.run.log)
do-install: do-config pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@cd $(_WRKSRC) && ./bjam --without-python --without-mpi --without-iostreams install
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
	@echo "done"
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
