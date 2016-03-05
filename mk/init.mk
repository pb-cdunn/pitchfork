override SELF_DIR:=$(dir $(lastword ${MAKEFILE_LIST}))
include ${SELF_DIR}/config.mk
include ${SELF_DIR}/sanity.mk

init: sanity
	@mkdir -p "${WORKSPACE}"
	@mkdir -p "${STAGING}"
	@mkdir -p "${PREFIX}/bin"
	@mkdir -p "${PREFIX}/etc"
	@mkdir -p "${PREFIX}/include"
	@mkdir -p "${PREFIX}/lib"
	@mkdir -p "${PREFIX}/lib/pkgconfig"
	@mkdir -p "${PREFIX}/share"
	@mkdir -p "${PREFIX}/var/pkg"

# utils
_startover:
	@echo "This will erase everything in ${PREFIX}, staging/ and workspace/ directories."
	@read -p "Are you sure? " -n 1 -r; \
        echo; \
        if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
           echo "rm -rf ${PREFIX}/* ${PREFIX}/.Python staging/* workspace/* ports/*/*/*.log"; \
           rm -rf ${PREFIX}/* ${PREFIX}/.Python staging/* workspace/* ports/*/*/*.log; \
        fi
