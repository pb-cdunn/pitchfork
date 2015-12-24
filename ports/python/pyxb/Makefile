include ../../../mk/config.mk

# Local sanity check
_tmpvar:=$(if $(shell which $(FC)),exists,$(error "unable to run $(FC), consider doing yum install gcc-gfortran"))

# Local variables
_VER    = 1.2.4
_NAME   = pyxb-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-extract: do-gitclone
do-gitclone: wscheck
do-config: do-extract
do-build: do-config
# note that dependencies is taken care of already here, mj is lazy
do-install: do-build pfcheck $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@$(PREFIX)/bin/pip install pyxb==$(_VER)
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@cd $(PREFIX) && cat var/pkg/$(_NAME) | xargs rm -rf
	@rm -f $(PREFIX)/var/pkg/$(_NAME)
