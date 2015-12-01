# Global overrides
GIT       = git
SED       = sed
WORKSPACE = $(realpath ../../..)/workspace
PREFIX   ?= $(realpath ../../..)/deployment
CFLAGS    = -fPIC -static-libgcc
default:
	@echo "[INFO] nothing is done."
wscheck:
	@mkdir -p $(WORKSPACE) || exit 1
pfcheck:
	@mkdir -p $(PREFIX) || exit 1

# Local variables
_NAME   = Python-2.7.10
_URL    = https://www.python.org/ftp/python/2.7.10
_FILE   = Python-2.7.10.tgz
_WRKSRC = $(WORKSPACE)/$(_NAME)
_CFGVAR = --enable-unicode=ucs4
_CFLAGS = $(CFLAGS) -march=native -O3

# Local works
do-extract: wscheck
	@test -d $(_WRKSRC) || curl -O $(_URL)/$(_FILE)
	@which md5sum >& /dev/null && md5sum -c MD5SUM
	@test -d $(_WRKSRC) || tar zxf $(_FILE) -C $(WORKSPACE)
do-clean:
	@test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true

#do-config: do-extract
#	@cd $(_WRKSRC) && test -e configure.log || CFLAGS="$(_CFLAGS)" ./configure --prefix=$(PREFIX)
#do-build: do-config
#	@test -f $(_WRKSRC)/configure.log || exit 1
#	@make -C $(_WRKSRC)
#do-deploy: do-build
#	@make -C $(_WRKSRC) install
