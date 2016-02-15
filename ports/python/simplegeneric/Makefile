include ../../../mk/pitchfork.mk

# Local variables
_NAME   = simplegeneric-$(_VER)
_VER    = 0.8.1
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	rm -rf $(STAGING)/$(_NAME)
	mkdir -p $(STAGING)/$(_NAME)
	$(PIP) install --root $(STAGING)/$(_NAME) --no-deps simplegeneric==$(_VER)
	rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	find $(STAGING)/$(_NAME)|awk -F '$(STAGING)/$(_NAME)$(PREFIX)/' '{print $$2}'|grep -v '^$$'|sort -r > $@
do-clean:
	rm -rf $(STAGING)/$(_NAME)
