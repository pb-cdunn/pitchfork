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

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	test -d $(_WRKSRC) || $(GIT) clone -o $(_REV) $(_URL) $(_WRKSRC)
do-clean:
	test -d $(_WRKSRC) && rm -rf $(_WRKSRC) || true
do-build:
	test "$(PREFIX)"
do-patch:
	$(SED)
