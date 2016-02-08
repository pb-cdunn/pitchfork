include ../../../mk/config.mk

# Local variables
_VER    = 1.0.2
_NAME   = pydot-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local sanity check
ifeq ($(OPSYS),Darwin)
_tmpvar:=$(if $(shell which dot),exists,$(error "unable to run dot, consider doing port install graphviz"))
else
_tmpvar:=$(if $(shell which dot),exists,$(error "unable to run dot, consider doing yum install graphviz"))
endif

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps pydot==$(_VER)
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $@
