include ../../../mk/config.mk

# Local variables
_VER    = 1.0.2
_NAME   = pydot-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local sanity check
_tmpvar:=$(if $(shell which dot),exists,$(error "unable to run dot, consider doing yum install graphviz"))

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@find $(PREFIX) ! -type d > $(_WRKSRC).before.list
	@find $(PREFIX) -type d > $(_WRKSRC).before.dlist
	@$(PIP) install pydot==1.0.2
	@find $(PREFIX) ! -type d > $(_WRKSRC).after.list
	@find $(PREFIX) -type d > $(_WRKSRC).after.dlist
	@diff -u $(_WRKSRC).before.list $(_WRKSRC).after.list | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >  $(PREFIX)/var/pkg/$(_NAME)
	@diff -u $(_WRKSRC).before.dlist $(_WRKSRC).after.dlist | \
	grep -v '^\++'|awk -F $(PREFIX)/ '/^\+/{print $$2}' >> $(PREFIX)/var/pkg/$(_NAME)
do-uninstall:
	@PREFIX=$(PREFIX) $(PFHOME)/bin/uninstall $(_NAME)
