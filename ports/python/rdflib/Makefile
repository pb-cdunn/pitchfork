include ../../../mk/config.mk

# Local variables
_VER    = 3.4.0
_NAME   = rdflib-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)
	@$(PIP) install --root $(STAGING)/$(_NAME) --no-deps rdflib==$(_VER)
	@rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	@find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $@
