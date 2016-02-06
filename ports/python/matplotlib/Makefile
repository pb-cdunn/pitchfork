include ../../../mk/config.mk

# Local variables
_VER    = 1.5.1
_NAME   = matplotlib-$(_VER)
_WRKSRC = $(WORKSPACE)/$(_NAME)

_tmpvar:=$(if $(shell which pkg-config),exists,$(error "unable to run pkg-config, consider doing yum install pkgconfig"))
#export PKG_CONFIG_PATH=$(PREFIX)/lib/pkgconfig

# Local works
do-install: | $(PREFIX)/var/pkg/$(_NAME)
$(PREFIX)/var/pkg/$(_NAME):
	@rm -rf $(STAGING)/$(_NAME)
	@mkdir -p $(STAGING)/$(_NAME)
	@$(PIP) install --root $(STAGING)/$(_NAME) --no-deps matplotlib==$(_VER)
	@rsync -aKx $(STAGING)/$(_NAME)/$(PREFIX)/ $(PREFIX)/
	@find $(STAGING)/$(_NAME)|awk -F $(STAGING)/$(_NAME)$(PREFIX)/ '{print $$2}'|grep -v '^$$'|sort -r > $@
