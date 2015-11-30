# Global overrides
GIT       = git
SED       = sed
WORKSPACE = $(realpath ../../../workspace)
PREFIX   ?= $(realpath ../../../deployment)
default:
	@echo "[INFO] nothing is done."
wscheck:
	test "$(WORKSPACE)" && mkdir -p $(WORKSPACE) || exit 1

# Local variables
_NAME   = zlib-1.2.8
_URL    = https://github.com/cloudflare/zlib
_REV    = a80420c63532c25220a54ea0980667c02303460a
_WRKSRC = $(WORKSPACE)/$(_NAME)
CFLAGS  = -fPIC -static-libgcc -O3 -march=native

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	test -d $(_WRKSRC) || $(GIT) clone -o $(_REV) $(_URL) $(_WRKSRC)
do-clean:
	test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-config: do-extract
	cd $(_WRKSRC) && CFLAGS="$(CFLAGS)" ./configure --prefix=$(PREFIX)
do-build: do-config
	test "$(PREFIX)"
do-patch:
	$(SED)
