# local variable
_NAME = zlib-1.2.8
_URL  = https://github.com/cloudflare/zlib
_REV  = a80420c63532c25220a54ea0980667c02303460a

# Global overrides
SRC_DIR = src
GIT     = git
SED	= sed

#

do-extract: do-gitclone
do-gitclone:
	test -d $(SRC_DIR) || $(GIT) clone -o $(_REV) $(_URL) $(SRC_DIR)
do-clean:
	test -d $(SRC_DIR) && rm -rf $(SRC_DIR) || true
do-patch:
	$(SED)
