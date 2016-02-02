include ../../../mk/config.mk

# Local variables
_VER    = 0.8.4
_NAME   = pysam-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)
	@CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" $(PIP) install --root $(STAGING)/$(_NAME) --no-deps pysam==$(_VER)
	@rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	@find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $(PREFIX)/var/pkg/$(_NAME)
