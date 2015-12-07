include ../../../mk/config.mk

# Local variables
_NAME   = cython-0.23.4
_URL    = https://github.com/cython/cython
_REV    = dc00a176d896f0df892aad8b305d946d3ed632a0
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
	@test -d $(_WRKSRC) || $(GIT) clone -o $(_REV) $(_URL) $(_WRKSRC)
do-config: do-extract
do-build: do-config
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@pip install $(_WRKSRC)/
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^++'|awk -F $(PREFIX)/ '/^+/{print $$2}' > $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -f
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
