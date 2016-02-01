include ../../../mk/config.mk

# Local variables
_VER    = 2.8
_NAME   = jinja2-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)
	@$(PIP) install --root $(STAGING)/$(_NAME) --no-deps jinja2==$(_VER)
	@cd $(STAGING)/$(_NAME)/$(PREFIX) && tar cf - * | tar xf - -C $(PREFIX)
	@find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $(PREFIX)/var/pkg/$(_NAME)
